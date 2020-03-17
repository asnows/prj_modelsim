/*
模块名：
	AD9945_driver
功能：
	AD9945驱动模块
参数:
	D_WIDTH		: 采样的数据位宽；
	SAMP_NUM	：每帧采样的像素个数；
	sys_clk 	: 系统输入时钟，默认100m，与CCD驱动模块的sys_clk相等；
	sh			: CCD转移栅脉冲；
	f2			: CCD移位脉冲2;
	rs			: CCD 复位脉冲；
	SHP			: AD采样参考时钟；
	SHD			: AD采样时钟；
	DATACLK		: 数据采样时钟;
	DATA_IN		：输入数据；
	tdata		: 输出数据；
	tvalid		：数据有效脉冲
	
设计原理：
	SHP 由rs复位脉冲延时RS_DLY_NUM 个sys_clk脉冲后却反生成。
	SHD 由SHP延时延时RS_DLY_NUM 个SHP_DLY_NUM脉冲后生成。
	DATACLK 由f2延时F2_DLY_NUM 个时钟脉冲后取反生成。
*/

module AD9945_driver
#(
	parameter D_WIDTH = 8'd8,
	parameter SAMP_NUM = 12'd2048, // 一帧采样数
	parameter RS_LOW_WIDTH = 10, //rs低脉冲宽度
	parameter RS_DLY_NUM = 2,
	parameter F2_DLY_NUM = 2
)
(
input  	   	sys_clk		,
input       sh			,
input       f2			,
input		rs			,
output 		SHP			,
output    	SHD			,
output    	DATACLK		,
output		CLPOB		,
output		PBLK		,
input[D_WIDTH - 1:0] DATA_IN,

output[D_WIDTH - 1:0] tdata,
output				 tvalid

);

	localparam STATE_IDLE = 2'b00, STATE_SAMP= 2'b10,STATE_OUT= 2'b11;
	localparam SHP_DLY_NUM = RS_LOW_WIDTH + 1;
	
	
	reg[1:0] state = STATE_IDLE;
	reg sh_dly;
	reg shp_reg;
	reg shd_reg;
	reg dataclk_reg;
	reg tvalid_reg;
	reg clpob_reg;

	reg[F2_DLY_NUM - 1:0] f2_dly;
	reg[RS_DLY_NUM - 1:0] rs_dly;
	reg[SHP_DLY_NUM - 1:0] shp_dly;


	reg[7:0] clk_cnt = 8'd0;
	reg[11:0] samp_cnt = 12'd0;
	
	
	assign SHP = shp_reg;
	assign SHD = shd_reg;
	assign DATACLK = dataclk_reg;
	assign tvalid = tvalid_reg;
	assign tdata = DATA_IN;
	assign CLPOB = clpob_reg;
	assign PBLK = 1'b1;
	

	always@(posedge sys_clk)
	begin
		sh_dly <= sh;
		f2_dly <= {f2_dly[F2_DLY_NUM - 2:0],f2};
		rs_dly <= {rs_dly[RS_DLY_NUM - 2:0],rs};
		shp_dly<= {shp_dly[SHP_DLY_NUM - 2:0],shp_reg};

	end

	//生成状态机
	always@(posedge sys_clk)
	begin
		if((~sh_dly) & sh)
		begin
			state <= STATE_IDLE ;
		end
		else
		begin
			case(state)
				STATE_IDLE:
				begin
					
					samp_cnt <= 12'd0;
					if(sh_dly & (~sh))
					begin
						state <= STATE_SAMP ;
					end
				
				end
				
				STATE_SAMP:
				begin
					if((~f2_dly) & f2)
					begin
						if(samp_cnt < SAMP_NUM)
						begin
							samp_cnt <= samp_cnt + 1'b1;
						end
						else
						begin
							state <= STATE_IDLE ;
						end
					end										
				end
				
				default:
				begin
					state <= STATE_IDLE ;
				end
				
			endcase
		end
		
	end
	
	

	//生成 SHP
	always@(posedge sys_clk)
	begin
		shp_reg <= ~rs_dly[RS_DLY_NUM - 1];// rs 延时10ns
	end

	//生成 SHD
	always@(posedge sys_clk)
	begin
		shd_reg <= shp_dly[SHP_DLY_NUM - 1];			
	end

	//生成 DATACLK
	always@(posedge sys_clk)
	begin
		dataclk_reg <= ~f2_dly[F2_DLY_NUM - 1];
	end
	
	//生成tvalid
	always@(posedge sys_clk)
	begin
		if(samp_cnt > 10)
		begin
			tvalid_reg <= 1'b1;
		end
		else
		begin
			tvalid_reg <= 1'b0;
		end
	end
	
	//生成CLPOB
	always@(posedge sys_clk)
	begin
		if((12< samp_cnt ) && (samp_cnt < 28))
		begin
			clpob_reg <= 1'b0;
		end
		else
		begin
			clpob_reg <= 1'b1;
		end
	end

	
	
	
	
endmodule