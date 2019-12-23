module eth_send
#(
	parameter MEDIA_TYPES = "1000Base" //100Base
)
(
input sys_clk,
input[47:0] dst_mac,
input[47:0] src_mac,
input[15:0] eth_type,

input 	    s_axis_aclk		,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,



output      tx_data_clk,//generate data clk
output 		tx_clk 	, //trans data clk
output[3:0] txd		,
output 		tx_en,
)



wire 		tx_dclk;
wire[7:0] 	eth_tdata  ;
wire      	eth_tvalid ;  
	
wire[7:0]  s_eth_tdata   ;
wire       s_eth_tlast   ;
wire       s_eth_tready  ;
wire       s_eth_tuser   ;
wire       s_eth_tvalid  ;





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



eth_datagram eth_datagram_I
(

	.dst_mac		 (dst_mac	),
	.src_mac		 (src_mac	),
	.eth_type		 (eth_type   ),
	.s_axis_aclk	 (s_axis_aclk ),
	.s_axis_tdata    (s_eth_tdata ),
	.s_axis_tlast    (s_eth_tlast ),
	.s_axis_tready   (s_eth_tready),
	.s_axis_tuser    (s_eth_tuser ),
	.s_axis_tvalid   (s_eth_tvalid),

	.m_axis_tdata	(eth_tdata),
	.m_axis_tvalid  (eth_tvalid)  
  
)







	eth_tx tx_I
	(
		.clk	(tx_dclk	),
		.tvalid	(eth_tvalid	),
		.tdata	(eth_tdata	),
		.tx_en	(tx_en		),
		.txd	(txd		)
	)





endmodule