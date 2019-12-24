module eth_send
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
input[15:0] UDP_CheckSum,


input 	    s_axis_aclk		,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,


output      tx_data_clk,//generate data clk
output 		tx_clk 	   , //trans data clk
output[3:0] txd		   ,
output 		tx_en      
);



wire 		tx_dclk;

wire[7:0]  s_ip_tdata   ;
wire       s_ip_tlast   ;
wire       s_ip_tready  ;
wire       s_ip_tuser   ;
wire       s_ip_tvalid  ;

wire[7:0]  m_ip_tdata   ;
wire       m_ip_tlast   ;
wire       m_ip_tready  ;
wire       m_ip_tuser   ;
wire       m_ip_tvalid  ;


wire[7:0] 	eth_tdata  ;
wire      	eth_tvalid ;  
wire[7:0]  s_eth_tdata   ;
wire       s_eth_tlast   ;
wire       s_eth_tready  ;
wire       s_eth_tuser   ;
wire       s_eth_tvalid  ;


reg udp_enable = 1'b1;
reg ip_enable = 1'b1;




assign tx_data_clk = tx_dclk;

eth_gen_txc 
#(
	.MEDIA_TYPES (MEDIA_TYPES)

)
gen_txc_I
(
	.sys_clk(sys_clk),
	.tx_dclk(tx_dclk),//generate data clk
	.tx_clk (tx_clk)//trans data clk

);


udp_datagram udp_datagram_I
(

	.UDP_SrcPort (UDP_SrcPort ),
	.UDP_DestPort(UDP_DestPort),
	.UDP_TotLen  (UDP_TotLen  ),//Total Length
	.UDP_CheckSum(UDP_CheckSum),
    .udp_enable		 (udp_enable  ),
	.s_axis_aclk	 (s_axis_aclk  ),
	.s_axis_tdata    (s_axis_tdata ),
	.s_axis_tlast    (s_axis_tlast ),
	.s_axis_tready   (s_axis_tready),
	.s_axis_tuser    (s_axis_tuser ),
	.s_axis_tvalid   (s_axis_tvalid),

	.m_axis_tdata  (s_ip_tdata ),
	.m_axis_tlast  (s_ip_tlast ),
	.m_axis_tready (s_ip_tready),
	.m_axis_tuser  (s_ip_tuser ),
	.m_axis_tvalid (s_ip_tvalid)

);

ip_datagram ip_datagram_I
(
	.IP_TotLen		 (IP_TotLen	),//Total Length
	.IP_SrcAddr	 	 (IP_SrcAddr),
	.IP_DestAddr	 (IP_DestAddr),
	.ip_enable		 (ip_enable  ),
	.s_axis_aclk	 (s_axis_aclk),
	
	.s_axis_tdata    (s_ip_tdata ),
	.s_axis_tlast    (s_ip_tlast ),
	.s_axis_tready   (s_ip_tready),
	.s_axis_tuser    (s_ip_tuser ),
	.s_axis_tvalid   (s_ip_tvalid),
	
	.m_axis_tdata    (s_eth_tdata ),
	.m_axis_tlast    (s_eth_tlast ),
	.m_axis_tready   (s_eth_tready),
	.m_axis_tuser    (s_eth_tuser ),
	.m_axis_tvalid   (s_eth_tvalid)
		
);


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
  
);

mac_tx mac_tx_I
(
	.clk	(tx_dclk	),
	.tvalid	(eth_tvalid	),
	.tdata	(eth_tdata	),
	.tx_en	(tx_en		),
	.txd	(txd		)
);





endmodule