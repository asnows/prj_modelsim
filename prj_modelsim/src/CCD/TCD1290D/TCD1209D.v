module TCD1209D
#(
	parameter D_WIDTH = 8'd12
)
(
// TCD1290D_driver
input sys_clk,
(*mark_debug="true"*)input  triggerMode, //1 = 外部触发，0=内部触发
(*mark_debug="true"*)input  extTrigger, 
(*mark_debug="true"*)input[24:0]f_cnt,
(*mark_debug="true"*)output sh,
(*mark_debug="true"*)output f1,
(*mark_debug="true"*)output f2,
(*mark_debug="true"*)output rs,
(*mark_debug="true"*)output cp,

//AD9945_cfg
(*mark_debug="true"*)input[6:0] 	Oper		,
(*mark_debug="true"*)input[6:0] 	Ctrl		,
(*mark_debug="true"*)input[7:0] 	Clamp		,
(*mark_debug="true"*)input[9:0] 	VGA_Gain	,
(*mark_debug="true"*)input	   		cfg_en		,
(*mark_debug="true"*)output 		SDATA		,
(*mark_debug="true"*)output 		SCK			,
(*mark_debug="true"*)output 		SL			,

//AD9945_driver
(*mark_debug="true"*)output 	SHP			,
(*mark_debug="true"*)output    	SHD			,
(*mark_debug="true"*)output    	DATACLK		,
(*mark_debug="true"*)output		CLPOB		,
(*mark_debug="true"*)output		PBLK		,
(*mark_debug="true"*)input[D_WIDTH - 1:0] DATA_IN,

//ccd2axis
(*mark_debug="true"*)input[10:0] rows, // 行数
(*mark_debug="true"*)output[7 : 0 ]   m_axis_tdata ,
(*mark_debug="true"*)output           m_axis_tlast ,
(*mark_debug="true"*)output           m_axis_tuser ,
(*mark_debug="true"*)output           m_axis_tvalid,
(*mark_debug="true"*)input            m_axis_tready ,
(*mark_debug="true"*)output           m_axis_aclk


);

wire pxl_clk;
wire f2_clk;
wire rs_clk;
wire cp_clk;

wire sh_puls;
wire f2_puls;
wire rs_puls;
wire cp_puls;
(*mark_debug="true"*)wire os_tvalid;



wire[D_WIDTH - 1:0] m_tdata;
(*mark_debug="true"*)wire[D_WIDTH - 1:0] AD9945_tdata;
(*mark_debug="true"*)wire				AD9945_tvalid;
(*mark_debug="true"*)reg[D_WIDTH - 1:0] AD9945_tdata_reg ;
(*mark_debug="true"*)reg				AD9945_tvalid_reg;


assign sh = sh_puls;
assign f1 = ~(f2_puls & f2_clk);
assign f2 =  f2_puls & f2_clk;
assign rs =  rs_puls & rs_clk;
assign cp =  rs_puls & cp_clk;

assign DATACLK = pxl_clk;
assign m_axis_tdata = m_tdata[11:4];
assign m_axis_aclk = pxl_clk;


genClk genClk_I
(
	.sys_clk(sys_clk),
	.f2 (f2_clk),
	.rs (rs_clk),
	.cp (cp_clk),
	.shp(SHP),
	.shd(SHD),
	.dataclk(pxl_clk)
);



TCD1209D_driver TCD1209D_driver_I
(
	.pxl_clk(pxl_clk),
	.triggerMode(triggerMode),
	.extTrigger(extTrigger),  
	.f_cnt	(f_cnt	), 
	.sh_puls	(sh_puls),
	.f2_puls	(f2_puls),
	.rs_puls	(rs_puls),
	.os_tvalid(os_tvalid)
);


AD9945_cfg AD9945_cfg_I
(
	.sys_clk	(sys_clk	),
	.Oper		(Oper		),
	.Ctrl		(Ctrl		),
	.Clamp		(Clamp		),
	.VGA_Gain	(VGA_Gain	),
	.cfg_en		(cfg_en		),
	.SDATA		(SDATA		),
	.SCK		(SCK		),
	.SL			(SL			)

);

AD9945_driver AD9945_driver_i
(
	.pxl_clk(pxl_clk),
	.os_tvalid	(os_tvalid),
	.CLPOB	(CLPOB)	,
	.PBLK	(PBLK)	,
	.DATA_IN(DATA_IN),
	.tdata	(AD9945_tdata),
	.tvalid	(AD9945_tvalid)

);



ccd2axis  
#(
	.DATA_WIDTH(D_WIDTH),
	.EFFECT_COLS( 12'd2048),//每行有效像素
	.PRE_DUMMY_COLS(8'd32),//每行前面无效像素
	.POST_DUMMY_COLS(8'd8)
)
ccd2axis_i
(

	.pixel_clk    (pxl_clk		),
	.tvalid  	  (AD9945_tvalid_reg),
	.tdata		  (AD9945_tdata_reg),
	.rows(rows), // 行数
	.m_axis_tdata (m_tdata      ),
	.m_axis_tlast (m_axis_tlast ),
	.m_axis_tuser (m_axis_tuser ),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready)   
);

always@(posedge pxl_clk)
begin
	AD9945_tdata_reg  <= AD9945_tdata;
    AD9945_tvalid_reg <= AD9945_tvalid;
end

endmodule