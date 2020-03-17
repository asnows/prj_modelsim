module TCD1209D
#(
	parameter D_WIDTH = 8'd12
)
(
// TCD1290D_driver
input  sys_clk,
input[9:0]f1_cnt,
output sh,
output f1,
output f2,
output f2b,
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
output[D_WIDTH - 1:0] tdata ,
output				  tvalid

);


wire TCD1209D_sh,TCD1209D_f1,TCD1209D_f2,TCD1209D_f2b,TCD1209D_rs,TCD1209D_cp;


assign sh = TCD1209D_sh ;
assign f1 = TCD1209D_f1 ;
assign f2 = TCD1209D_f2 ;
assign f2b= TCD1209D_f2b;
assign rs = TCD1209D_rs ;
assign cp = TCD1209D_cp ;

TCD1209D_driver TCD1209D_driver_I
(
	.sys_clk(sys_clk),
	.f1_cnt(f1_cnt),
	.sh (TCD1209D_sh ),
	.f1 (TCD1209D_f1 ),
	.f2 (TCD1209D_f2 ),
	.f2b(TCD1209D_f2b),
	.rs (TCD1209D_rs ),
	.cp (TCD1209D_cp )

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

 AD9945_driver
#(
	.D_WIDTH (D_WIDTH),
	.SAMP_NUM (12'd2088 ),// �?帧采样数
	.RS_DLY_NUM (2),
	.RS_LOW_WIDTH( 11),
	.F2_DLY_NUM ( 20)
)
AD9945_driver_i
(
	.sys_clk(sys_clk),
	.sh		(TCD1209D_sh),
	.f2		(TCD1209D_f2),
	.rs		(TCD1209D_rs),
	.SHP	(SHP),
	.SHD	(SHD),
	.DATACLK(DATACLK),
	.CLPOB	(CLPOB)	,
	.PBLK	(PBLK)	,
	.DATA_IN(DATA_IN),
	.tdata	(tdata),
	.tvalid	(tvalid)

);




endmodule