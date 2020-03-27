module TCD1209D
#(
	parameter D_WIDTH = 8'd12
)
(
// TCD1290D_driver
input  sys_clk,
(*mark_debug="true"*)input[7:0]f1_freq,
(*mark_debug="true"*)input[22:0]f_cnt,
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

wire[D_WIDTH - 1:0] m_tdata;

wire TCD1209D_sh,TCD1209D_f1,TCD1209D_f2,TCD1209D_f2b,
	 TCD1209D_rs,TCD1209D_cp,TCD1209D_pclk,TCD1209D_tvalid,TCD1209D_rs_plus;

(*mark_debug="true"*)wire[D_WIDTH - 1:0] AD9945_tdata;
(*mark_debug="true"*)wire				AD9945_tvalid;
(*mark_debug="true"*)wire data_clk;

(*mark_debug="true"*)reg[D_WIDTH - 1:0] AD9945_tdata_reg ;
(*mark_debug="true"*)reg				AD9945_tvalid_reg;


assign sh = TCD1209D_sh ;
assign f1 = TCD1209D_f1 ;
assign f2 = TCD1209D_f2 ;
assign f2b= TCD1209D_f2b;
assign rs = TCD1209D_rs ;
assign cp = TCD1209D_cp ;
assign m_axis_tdata = m_tdata[11:4];
assign m_axis_aclk = data_clk;
assign DATACLK = data_clk;

TCD1209D_driver TCD1209D_driver_I
(
	.sys_clk(sys_clk),
	.f1_freq(f1_freq),
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
	.DATACLK(data_clk),
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

	.pixel_clk    (data_clk		),
	.tvalid  	  (AD9945_tvalid_reg),
	.tdata		  (AD9945_tdata_reg),
	.rows(rows), // 行数
	.m_axis_tdata (m_tdata      ),
	.m_axis_tlast (m_axis_tlast ),
	.m_axis_tuser (m_axis_tuser ),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready)   
);

always@(posedge data_clk)
begin
	AD9945_tdata_reg  <= AD9945_tdata;
    AD9945_tvalid_reg <= AD9945_tvalid;
end

endmodule