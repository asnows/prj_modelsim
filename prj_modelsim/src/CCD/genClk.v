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


assign f2   = f2_reg ;
assign rs   = rs_reg ;
assign cp   = cp_reg ;
assign shp  = shp_reg;
assign shd  = shd_reg;



assign tmp_cnt0 = (quart_freq <= 2)?(half_freq + quart_freq - 8'd1) :(half_freq + quart_freq - 8'd2);
assign tmp_cnt1 = (quart_freq <= 2)?(half_freq + (quart_freq <<1) - 8'd1) : (half_freq + (quart_freq <<1) - 8'd2);

BUFG BUFG_inst
(
.O(dataclk),//1-bitoutput:Clockoutput
.I(f2_reg)//1-bitinput:Clockinput
);


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





endmodule