module mac
#(
	parameter MEDIA_TYPES = "1000Base" //100Base
)
(
input sys_clk,
input[47:0] dst_mac,
input[47:0] src_mac,
input[15:0] eth_type,
input[15:0] IP_TotLen,//Total Length
input[31:0] IP_SrcAddr,
input[31:0] IP_DestAddr,
input[15:0] UDP_SrcPort,
input[15:0] UDP_DestPort,
input[15:0] UDP_TotLen  ,//Total Length


input 	    s_axis_aclk		,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,

output 	     m_axis_aclk	,
output[7:0]  m_axis_tdata    ,
output       m_axis_tlast    ,
input      	 m_axis_tready   ,
output       m_axis_tuser    ,
output       m_axis_tvalid   ,


output      tx_data_clk,//generate data clk
output 		tx_clk 	   , //trans data clk
output[3:0] txd		   ,
output 		tx_en      ,

input 		rx_clk 	   , //trans data clk
input[3:0]  rxd		   ,
input 		rx_en      


);

mac_tx
#(
	.MEDIA_TYPES (MEDIA_TYPES)
)
mac_tx_I
(
	.sys_clk		(sys_clk		),
	.dst_mac		(dst_mac		),
	.src_mac		(src_mac		),
	.eth_type	(eth_type	),
	.IP_TotLen	(IP_TotLen	),//Total Length
	.IP_SrcAddr	(IP_SrcAddr	),
	.IP_DestAddr	(IP_DestAddr	),
	.UDP_SrcPort	(UDP_SrcPort	),
	.UDP_DestPort(UDP_DestPort),
	.UDP_TotLen  (UDP_TotLen  ),//Total Length
	.UDP_CheckSum(16'd0),


	.s_axis_aclk	 (s_axis_aclk  ),
	.s_axis_tdata    (s_axis_tdata ),
	.s_axis_tlast    (s_axis_tlast ),
	.s_axis_tready   (s_axis_tready),
	.s_axis_tuser    (s_axis_tuser ),
	.s_axis_tvalid   (s_axis_tvalid),


	.tx_data_clk(tx_data_clk),//generate data clk
	.tx_clk 	   (tx_clk 	   ), //trans data clk
	.txd		   (txd		   ),
	.tx_en      (tx_en      )
);

mac_rx
#(
	.MEDIA_TYPES (MEDIA_TYPES) //100Base
)
mac_rx_I
(
	.dst_mac		 (),
	.src_mac		(),
	.eth_type		(),
	.IP_TotLen		(),//Total Length
	.IP_SrcAddr		(),
	.IP_DestAddr	(),
	.UDP_SrcPort	(),
	.UDP_DestPort	(),
	.UDP_TotLen  	(),//Total Length
	.UDP_CheckSum	(),


	.m_axis_aclk   (m_axis_aclk	 ),
	.m_axis_tdata  (m_axis_tdata ),
	.m_axis_tlast  (m_axis_tlast ),
	.m_axis_tready (m_axis_tready),
	.m_axis_tuser  (m_axis_tuser ),
	.m_axis_tvalid (m_axis_tvalid),



	.rx_clk (rx_clk)	   , //trans data clk
	.rxd	(rxd)	   ,
	.rx_en (rx_en)     
);




endmodule