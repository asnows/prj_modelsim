/*
模块名称：
	genClk
功能：
	生成CCD f1,f2,rs,cp,以及AD9945的shp,shd和dataclk 信号
接口：
	sys_clk： 系统输入时钟，默认100m
	f2_freq；f2频率设置参数，f2频率 = sys_clk/f2_freq = 100mhz/f2_freq
	dataclk: AD9945 数据时钟dataclk

设计原理：
	f2:由计数器half_freq来控制生成，当f2_freq为奇数时，高脉冲比低脉冲多一个时钟，如（20mhz 时，高低脉冲时钟比为3:2）
	rs:脉冲宽度f2脉冲宽度的1/2;上升沿与f2上升沿对齐
	cP:脉冲宽度f2脉冲宽度的1/2;上升沿于rs下降沿对齐
	shp:等价于cp取反
	shd：在f2下降沿延时tmp_cnt0 时钟后拉低，低脉冲宽度等于是f2脉冲宽度的1/2;
	
*/
//`define USE_REG

module genClk
(
input sys_clk,
input[7:0] f2_freq,// f2 频率设置
output f2 ,
output rs ,
output cp ,
output shp,
output shd,
output dataclk

);

reg[7:0] clk_div = 8'd0;
reg f2_reg ;
reg rs_reg ;
reg cp_reg ;
reg shp_reg;
reg shd_reg;
reg[7:0] half_freq;
reg[7:0] quart_freq;
wire[7:0] tmp_cnt0;
wire[7:0] tmp_cnt1;


wire clk_fb;
wire mmcm_f2;
wire mmcm_rs;
wire mmcm_cp;
wire mmcm_shp;
wire mmcm_shd;


wire tmp_f2 ;
wire tmp_rs ;
wire tmp_cp ;
wire tmp_shp;
wire tmp_shd;



assign f2   = tmp_f2 ;
assign rs   = tmp_rs ;
assign cp   = tmp_cp ;
assign shp  = tmp_shp;
assign shd  = tmp_shd;






`ifdef USE_REG

	BUFG BUFG_inst
	(
	.O(dataclk),//1-bitoutput:Clockoutput
	.I(f2_reg)//1-bitinput:Clockinput
	);


	assign tmp_cnt0 = (quart_freq <= 2)?(half_freq + quart_freq - 8'd1) :(half_freq + quart_freq - 8'd2);
	assign tmp_cnt1 = (quart_freq <= 2)?(half_freq + (quart_freq <<1) - 8'd1) : (half_freq + (quart_freq <<1) - 8'd2);

	always@(posedge sys_clk)
	begin
		half_freq <= (f2_freq >> 1) + f2_freq[0];
		quart_freq <= (f2_freq >> 2);
	end

	always@(posedge sys_clk)
	begin
		if(clk_div <(f2_freq - 1'b1))
		begin
			clk_div <= clk_div + 1'b1;
		end
		else
		begin
			clk_div <= 3'd0;
		end
	end

	always@(posedge sys_clk)
	begin
		if(clk_div < half_freq)
		begin
			f2_reg  <= 1'b1;
		end
		else
		begin
			f2_reg  <= 1'b0;
		end
		
	end


	always@(posedge sys_clk)
	begin
		if(clk_div < quart_freq)
		begin
			rs_reg  <= 1'b1;
		end
		else
		begin
			rs_reg  <= 1'b0;
		end
		
	end

	always@(posedge sys_clk)
	begin
		if( (quart_freq <= clk_div) && (clk_div < (quart_freq << 1)))
		begin
			cp_reg  <= 1'b1;
			shp_reg <= 1'b0;
		end
		else
		begin
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
		end
		
	end

	always@(posedge sys_clk)
	begin
		if((tmp_cnt0 <= clk_div) && (clk_div < tmp_cnt1))
		begin
			shd_reg  <= 1'b0;
		end
		else
		begin
			shd_reg  <= 1'b1;
		end
		
	end

	assign tmp_f2   = f2_reg ;
	assign tmp_rs   = rs_reg ;
	assign tmp_cp   = cp_reg ;
	assign tmp_shp  = shp_reg;
	assign tmp_shd  = shd_reg;

`else

   MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(6.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(10.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(30),
      .CLKOUT2_DIVIDE(30),
      .CLKOUT3_DIVIDE(30),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(30.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.25),
      .CLKOUT2_DUTY_CYCLE(0.25),
      .CLKOUT3_DUTY_CYCLE(0.25),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(90.0),
      .CLKOUT3_PHASE(232.5),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(mmcm_f2),     // 1-bit output: CLKOUT0
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(mmcm_rs),     // 1-bit output: CLKOUT1
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(mmcm_cp),     // 1-bit output: CLKOUT2
      .CLKOUT2B(mmcm_shp),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(),     // 1-bit output: CLKOUT3
      .CLKOUT3B(mmcm_shd),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(),     // 1-bit output: CLKOUT4
      .CLKOUT5(),     // 1-bit output: CLKOUT5
      .CLKOUT6(),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clk_fb),   // 1-bit output: Feedback clock
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(sys_clk),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down
      .RST(1'b0),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk_fb)      // 1-bit input: Feedback clock
   );

   // End of MMCME2_BASE_inst instantiation

	assign tmp_f2   = mmcm_f2 ;
	assign tmp_rs   = mmcm_rs ;
	assign tmp_cp   = mmcm_cp ;
	assign tmp_shp  = mmcm_shp;
	assign tmp_shd  = mmcm_shd;
	assign dataclk  = mmcm_f2;

`endif




endmodule