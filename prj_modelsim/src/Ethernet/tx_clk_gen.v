/*
模块名称：tx_clk_gen
功能：
	产生发送时钟。
接口：
	sys_clk :系统输入时钟。
	tx_dclk :数据产生时钟。
	tx_clk  :数据发送时钟。

设计原理：
	当使用千兆网时，tx_dclk和tx_clk频率相同等于系统提供的sys_clk （125Mhz)，相位相差180°。
	当使用百兆网时，tx_dclk是sys_clk的 1/2，tx_clk是sys_clk（25Mhz）相位差180°

*/

module tx_clk_gen
#(
parameter MEDIA_TYPES = "1000Base" //100Base

)
(
input sys_clk,//125m or 25m
output tx_dclk,//generate data clk
output tx_clk  //trans data clk

);

reg[1:0] dclk_count = 2'd0;



assign tx_dclk = (MEDIA_TYPES == "100Base" )? dclk_count[0]:sys_clk;
assign tx_clk = ~sys_clk;

always@(posedge sys_clk)
begin
	 dclk_count <= dclk_count + 1'b1;
end

endmodule 