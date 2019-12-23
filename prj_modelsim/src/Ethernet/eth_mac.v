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

// eth_send
// #(
	// .MEDIA_TYPES (MEDIA_TYPES)
// )
// eth_send_I
// (
// .sys_clk	(sys_clk	)	,
// .dst_mac	(dst_mac	)	,
// .src_mac	(src_mac	)	,
// .eth_type	(eth_type	)	,

// input 	    s_axis_aclk		,
// input[7:0]  s_axis_tdata    ,
// input       s_axis_tlast    ,
// output      s_axis_tready   ,
// input       s_axis_tuser    ,
// input       s_axis_tvalid   ,



// .tx_data_clk	(tx_data_clk	)	,//generate data clk
// .tx_clk 		(tx_clk 		)	, //trans data clk
// .txd			(txd			)	,
// .tx_en			(tx_en			)	,
// )





endmodule