module mac_rx
#(
	parameter MEDIA_TYPES = "1000Base" //100Base
)
(
output[47:0] dst_mac,
output[47:0] src_mac,
output[15:0] eth_type,
output[15:0] IP_TotLen,//Total Length
output[ 7:0] IP_Protocol,
output[31:0] IP_SrcAddr,
output[31:0] IP_DestAddr,
output[15:0] UDP_SrcPort,
output[15:0] UDP_DestPort,
output[15:0] UDP_TotLen  ,//Total Length
output[15:0] UDP_CheckSum,
output[15:0] arp_opcode  ,
output[47:0] arp_srcMac  ,
output[31:0] arp_srcIP   ,
output[47:0] arp_destMac ,
output[31:0] arp_destIP  ,



output 	     m_axis_aclk	,
output[7:0]  m_axis_tdata    ,
output       m_axis_tlast    ,
input      	 m_axis_tready   ,
output       m_axis_tuser    ,
output       m_axis_tvalid   ,



input 		rx_clk 	   , //trans data clk
input[3:0]  rxd		   ,
input 		rx_en      
);


wire 	  rx_tvalid;
wire[7:0] rx_tdata; 
wire 	  s_axis_aclk;

reg        ip_enable  = 1'b0;
reg 	   udp_enable = 1'b0;
reg 	   arp_enable = 1'b1;

wire[7:0]  m_eth_tdata    ;
wire       m_eth_tlast    ;
wire       m_eth_tready   ;
wire       m_eth_tuser    ;
wire       m_eth_tvalid   ;
wire 	   m_eth_fcs_err  ;

wire[7:0]  m_ip_tdata    ;
wire       m_ip_tlast    ;
wire       m_ip_tready   ;
wire       m_ip_tuser    ;
wire       m_ip_tvalid   ;
wire 	   ip_Check_err  ;


wire[7:0]  m_udp_tdata    ;
wire       m_udp_tlast    ;
wire       m_udp_tready   ;
wire       m_udp_tuser    ;
wire       m_udp_tvalid   ;

wire[7:0]  m_arp_tdata    ;
wire       m_arp_tlast    ;
wire       m_arp_tready   ;
wire       m_arp_tuser    ;
wire       m_arp_tvalid   ;


assign s_axis_aclk = rx_clk;
assign m_axis_aclk = rx_clk;


rx_oper rx_oper_I
(
	.rx_clk(rx_clk),
	.rx_en(rx_en),
	.rxd(rxd),
	.tvalid(rx_tvalid),
	.tdata(rx_tdata)

);

rx_eth rx_eth_I
(

	.dst_mac	(dst_mac),
	.src_mac	(src_mac),
	.eth_type	(eth_type),
	.s_axis_aclk	(s_axis_aclk),
	.s_axis_tdata    (rx_tdata),
	.s_axis_tvalid   (rx_tvalid),

	.m_axis_tdata    (m_eth_tdata ),
	.m_axis_tlast    (m_eth_tlast ),
	.m_axis_tready   (m_eth_tready),
	.m_axis_tuser    (m_eth_tuser ),
	.m_axis_tvalid   (m_eth_tvalid),
	.fcs_err 		 (m_eth_fcs_err)
  
);


rx_ip rx_ip_I
(
	.IP_TotLen	(IP_TotLen	),//Total Length
	.IP_Protocol(IP_Protocol),
	.IP_SrcAddr	(IP_SrcAddr	),
	.IP_DestAddr(IP_DestAddr),
	.ip_enable	(ip_enable),
	.s_axis_aclk   (s_axis_aclk ),
	.s_axis_tdata  (m_eth_tdata ),
	.s_axis_tlast  (m_eth_tlast ),
	.s_axis_tready (m_eth_tready),
	.s_axis_tuser  (m_eth_tuser ),
	.s_axis_tvalid (m_eth_tvalid),
	
	.m_axis_tdata  (m_ip_tdata ),
	.m_axis_tlast  (m_ip_tlast ),
	.m_axis_tready (m_ip_tready),
	.m_axis_tuser  (m_ip_tuser ),
	.m_axis_tvalid (m_ip_tvalid),
	.ip_Check_err  (ip_Check_err)
		
);


rx_udp rx_udp_I
(

	.UDP_SrcPort	(UDP_SrcPort),
	.UDP_DestPort	(UDP_DestPort),
	.UDP_TotLen		(UDP_TotLen	),//Total Length
	.UDP_CheckSum	(UDP_CheckSum),//Total Length

	.udp_enable	  (udp_enable ),
	.s_axis_aclk  (s_axis_aclk),
	.s_axis_tdata (m_ip_tdata ),
	.s_axis_tlast (m_ip_tlast ),
	.s_axis_tready(m_ip_tready),
	.s_axis_tuser (m_ip_tuser ),
	.s_axis_tvalid(m_ip_tvalid),

	.m_axis_tdata (m_udp_tdata ),
	.m_axis_tlast (m_udp_tlast ),
	.m_axis_tready(m_udp_tready),
	.m_axis_tuser (m_udp_tuser ),
	.m_axis_tvalid(m_udp_tvalid)

);

rx_arp rx_arp_I
(

	.arp_opcode (arp_opcode ),
	.arp_srcMac (arp_srcMac ),
	.arp_srcIP  (arp_srcIP  ),
	.arp_destMac(arp_destMac),
	.arp_destIP (arp_destIP ),

	.arp_enable	  (arp_enable ),
	.s_axis_aclk  (s_axis_aclk),
	.s_axis_tdata (m_udp_tdata ),
	.s_axis_tlast (m_udp_tlast ),
	.s_axis_tready(m_udp_tready),
	.s_axis_tuser (m_udp_tuser ),
	.s_axis_tvalid(m_udp_tvalid),

	.m_axis_tdata  (m_arp_tdata ),
	.m_axis_tlast  (m_arp_tlast ),
	.m_axis_tready (m_arp_tready),
	.m_axis_tuser  (m_arp_tuser ),
	.m_axis_tvalid (m_arp_tvalid)

);




endmodule