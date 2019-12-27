module mac_rx
#(
	parameter MEDIA_TYPES = "1000Base" //100Base
)
(
output[47:0] dst_mac,
output[47:0] src_mac,
output[15:0] eth_type,
output[15:0] IP_TotLen,//Total Length
output[31:0] IP_SrcAddr,
output[31:0] IP_DestAddr,
output[15:0] UDP_SrcPort,
output[15:0] UDP_DestPort,
output[15:0] UDP_TotLen  ,//Total Length
output[15:0] UDP_CheckSum,


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

rx_oper rx_oper_I
(
	.rx_clk(rx_clk),
	.rx_en(rx_en),
	.rxd(rxd),
	.tvalid(rx_tvalid),
	.tdata(rx_tdata)

);




endmodule