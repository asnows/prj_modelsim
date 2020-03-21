module TCD1209D
#(
	parameter D_WIDTH = 8'd12
)
(
// TCD1290D_driver
input  sys_clk,
input[22:0]f_cnt,
output sh,
output f1,
output f2,
//output f2b,
output rs,
output cp,

//AD9945_cfg
input[6:0] 	Oper		,
input[6:0] 	Ctrl		,
input[7:0] 	Clamp		,
input[9:0] 	VGA_Gain	,
input	   	cfg_en		,
output 		SDATA		,
output 		SCK			,
output 		SL			,

//AD9945_driver
output 		SHP			,
output    	SHD			,
output    	DATACLK		,
output		CLPOB		,
output		PBLK		,
input[D_WIDTH - 1:0] DATA_IN,

//ccd2axis
input[10:0] rows, // 行数
output[D_WIDTH - 1 : 0 ] m_axis_tdata ,
output           m_axis_tlast ,
output           m_axis_tuser ,
output           m_axis_tvalid,
input            m_axis_tready   


);


wire TCD1209D_sh,TCD1209D_f1,TCD1209D_f2,TCD1209D_f2b,
	 TCD1209D_rs,TCD1209D_cp,TCD1209D_pclk,TCD1209D_tvalid,TCD1209D_rs_plus;

wire[D_WIDTH - 1:0] AD9945_tdata;
wire				AD9945_tvalid;

assign sh = TCD1209D_sh ;
assign f1 = TCD1209D_f1 ;
assign f2 = TCD1209D_f2 ;
assign f2b= TCD1209D_f2b;
assign rs = TCD1209D_rs ;
assign cp = TCD1209D_cp ;

TCD1209D_driver TCD1209D_driver_I
(
	.sys_clk(sys_clk),
	.f_cnt(f_cnt),
	.sh (TCD1209D_sh ),
	.f1 (TCD1209D_f1 ),
	.f2 (TCD1209D_f2 ),
	.rs (TCD1209D_rs ),
	.cp (TCD1209D_cp ),
	.pclk(TCD1209D_pclk),
	.rs_plus(TCD1209D_rs_plus),
	.os_tvalid	(TCD1209D_tvalid)
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
	.sys_clk(sys_clk),
	.pclk(TCD1209D_pclk),
	.rs_plus(TCD1209D_rs_plus),
	.os_tvalid	(TCD1209D_tvalid),
	.SHP	(SHP),
	.SHD	(SHD),
	.DATACLK(DATACLK),
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

	.pixel_clk    (DATACLK		),
	.tvalid  	  (AD9945_tvalid),
	.tdata		  (AD9945_tdata	),
	.rows(rows), // 行数
	.m_axis_tdata (m_axis_tdata ),
	.m_axis_tlast (m_axis_tlast ),
	.m_axis_tuser (m_axis_tuser ),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready)   
);



endmodule