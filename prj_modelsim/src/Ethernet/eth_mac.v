module eth_mac
#(
	parameter MEDIA_TYPES = "1000Base" //100Base
)
(
input sys_clk,
input[47:0] dst_mac,
input[47:0] src_mac,
input[15:0] eth_type,

input 	    s_axis_aclk,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,



output tx_data_clk,//generate data clk
output 		tx_clk 	, //trans data clk
output[3:0] txd		,
output 		tx_en,


input 		rx_clk,
input[3:0]  rxd	  ,
input 		rx_en


)


wire tx_dclk;


assign tx_data_clk = tx_dclk;

eth_gen_txc gen_txc_I
#(
.MEDIA_TYPES (MEDIA_TYPES)

)
gen_txc_I
(
.sys_clk(sys_clk),
.tx_dclk(tx_dclk),//generate data clk
.tx_clk (tx_clk)//trans data clk

)


module eth_tx
(
	input clk(tx_dclk),
	input tvalid,
	input[7:0]  tdata,
	output 		tx_en,
	output[3:0] txd
)





endmodule