module eth_gen_txc
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