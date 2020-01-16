module tb_ethernet
(
	input clk_125m,
	input resetn

);

localparam IMG_WIDTH = 2560,IMG_HEIGHT =1440;
localparam DATA_WIDTH = 8;
wire [7:0] file_data;
wire read_file_valid;
wire cap_tready;
wire  tx_data_clk;

wire  [DATA_WIDTH - 1 : 0 ] m_tdata ;
wire           m_tlast ;
wire           m_tuser ;
wire           m_tvalid;
wire           m_tready;   


read_file
#(
	.DATA_WIDTH(DATA_WIDTH      ) ,
	.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT ),
	.FILE_NAME( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/src_sc4210_2560x1440.raw")
)
read_file_i
(
	.clk      (tx_data_clk),  
	.read_en  (cap_tready & resetn),
	.data_valid(read_file_valid),
	.data_out (file_data)
);
	
	
	video_caputure 
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.IMG_WIDTH (IMG_WIDTH*IMG_HEIGHT )
	)
	video_caputure_0_i
	(

		.vsync(~resetn  ),
		.s_axis_aclk  (tx_data_clk),
		.s_axis_tready(cap_tready),

		.s_axis_tdata (file_data ),
		.s_axis_tkeep (1'b1 ),
		.s_axis_tlast (1'b1 ),
		.s_axis_tvalid(read_file_valid ),

		.m_axis_tdata (m_tdata ) ,
		.m_axis_tlast (m_tlast ) ,
		.m_axis_tuser (m_tuser ) ,
		.m_axis_tvalid(m_tvalid) ,
		.m_axis_tready(m_tready)
	);

localparam DST_MAC = 48'h08_57_00_f4_ae_e5;
localparam SRC_MAC = 48'h08_57_00_f4_ae_e6;
localparam ETH_TYPE = 16'h0800;
localparam IP_SrcAddr = 32'hc0_a8_c8_64;//192.168.200.100
localparam IP_DestAddr = 32'hc0_a8_c8_65;//192.168.200.101
localparam UDP_SrcPort = 16'd1536;//192.168.200.101
localparam UDP_DestPort = 16'd1536;//192.168.200.101

wire 		tx_clk ;	
wire[3:0]   txd	;	  
wire 		tx_en;      


wire 	   mac_m_axis_aclk	 ;
wire[7:0]  mac_m_axis_tdata    ;
wire       mac_m_axis_tlast    ;
wire       mac_m_axis_tready = 1'b1   ;
wire       mac_m_axis_tuser    ;
wire       mac_m_axis_tvalid   ;



mac
#(
	.MEDIA_TYPES ( "1000Base") //100Base
)
mac_I
(
.sys_clk (clk_125m),
.dst_mac(DST_MAC),
.src_mac(SRC_MAC),
.eth_type(ETH_TYPE),
.IP_TotLen(16'd1032),   //Total Length
.IP_SrcAddr(IP_SrcAddr),
.IP_DestAddr(IP_DestAddr),
.UDP_SrcPort(UDP_SrcPort),
.UDP_DestPort(UDP_DestPort),
.UDP_TotLen  (16'd1024),//Total Length


.s_axis_aclk	 (tx_data_clk),
.s_axis_tdata    (m_tdata ) ,
.s_axis_tlast    (m_tlast ) ,
.s_axis_tready   (m_tready) ,
.s_axis_tuser    (m_tuser ) ,
.s_axis_tvalid   (m_tvalid) ,

.m_axis_aclk   (mac_m_axis_aclk	 ),
.m_axis_tdata  (mac_m_axis_tdata ),
.m_axis_tlast  (mac_m_axis_tlast ),
.m_axis_tready (mac_m_axis_tready),
.m_axis_tuser  (mac_m_axis_tuser ),
.m_axis_tvalid (mac_m_axis_tvalid),

.tx_data_clk(tx_data_clk),//generate data clk
.tx_clk 	 (tx_clk)  , //trans data clk
.txd		 (txd)  ,
.tx_en       (tx_en) ,

.rx_clk (tx_clk) 	   , //trans data clk
.rxd	(txd)	   ,
.rx_en  (tx_en)     

);


write_file
#(
	.DATA_WIDTH(DATA_WIDTH),
	.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT),
	.FILE_NAME ( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/dst_sc4210_2560x1440.raw")
)
write_file_0
(
	.clk(mac_m_axis_aclk),  
	.write_en(mac_m_axis_tvalid ),
	.stop_en(1'b1),
	.data_in (mac_m_axis_tdata)

);




endmodule