`timescale 1ns / 1ps

module top_tb
(
);

	localparam IMG_WIDTH = 2560,IMG_HEIGHT =1440;
	localparam DATA_WIDTH = 8;
    reg clk_200m,clk_50m,clk_500m,clk_1000m,clk_100m,clk_125m;
	reg clk_445_5m;

    reg resetn = 1'b0;
    
    
    always 
    begin
        #2.5 clk_200m = 0;
        #2.5 clk_200m = 1;
    end

    always 
    begin
        #10 clk_50m = 0;
        #10 clk_50m = 1;
    end

	always
	begin
		#1 clk_500m = 0;
		#1 clk_500m = 1;
	end
	
	always
	begin
		#0.5 clk_1000m = 0;
		#0.5 clk_1000m = 1;
	end
	
	always
	begin
		#5 clk_100m = 0;
		#5 clk_100m = 1;
	end
	
	always
	begin
		#4 clk_125m = 0;
		#4 clk_125m = 1;
	end

	
	

	always
	begin
		#1.12 clk_445_5m = 0;
		#1.12 clk_445_5m = 1;
	end

	
	
    
    initial
    begin

	 #0 resetn = 1'b0;	
     #510 resetn = 1;

    end



















// axis_master
// #(
	// .DATA_NUM (1024)
// )
// axis_master_I
// (
	// .clk(tx_data_clk),
	// .reset(~resetn),
	// .m_axis_tdata   (m_tdata ) ,
	// .m_axis_tlast   (m_tlast ) ,
	// .m_axis_tready  (m_tready) ,
	// .m_axis_tuser   (m_tuser ) ,
	// .m_axis_tvalid  (m_tvalid) 

// );



// tb_iic tb_iic_I
// (
	// .clk_50m(clk_50m),
	// .resetn(resetn)

// );


// tb_lvds tb_lvds_I
// (
	// .clk_200m(clk_200m),
	// .clk_445_5m(clk_445_5m),
	// .resetn(resetn)

// );



// tb_ethernet tb_eth
// (
	// .clk_125m (clk_125m),
	// .resetn(resetn)

// );


tb_imgProcess tb_img_I
(
	.clk(clk_100m),
	.resetn(resetn)

);

wire sh,f1;
reg sh_dly,f1_dly;
reg[11:0] data;

always@(posedge clk_100m)
begin
	f1_dly <= f1;
	sh_dly <= sh;
end

always@(posedge clk_100m)
begin
	if(~sh_dly & sh)
	begin
		data <= 12'd0;
	end
	else
	begin
		if(~f1_dly & f1)
		begin
			data <= data + 1'b1;
		end
		
	end
	
	
end


wire data_clk;
wire[7 : 0 ]   m_axis_tdata ;
wire           m_axis_tlast ;
wire           m_axis_tuser ;
wire           m_axis_tvalid;
wire           m_axis_tready;
wire           m_axis_aclk  ;


/*
TCD1209D
#(
	.D_WIDTH(12)
)
TCD1209D_i
(
// TCD1290D_driver
.sys_clk(clk_100m),
.triggerMode(1'b0), //1 = 外部触发，0=内部触发
.extTrigger(1'b0), 
.f_cnt(2102),
.f2_freq(100),
.sh(sh),
.f1(f1),
.f2(),
//.f2b(),
.rs(),
.cp(),

//AD9945_cfg
.Oper		(7'b1010101),
.Ctrl		(7'b1010101),
.Clamp		(8'b01010101),
.VGA_Gain	(10'b0101010101),
.cfg_en		(resetn),
.SDATA		(),
.SCK			(),
.SL			(),

//AD9945_driver
.SHP			(),
.SHD			(),
.DATACLK		(),
.CLPOB		(),
.PBLK		(),
.DATA_IN(data),
//ccd2axis
.rows(15), // 行数
.m_axis_tdata (m_axis_tdata ),
.m_axis_tlast (m_axis_tlast ),
.m_axis_tuser (m_axis_tuser ),
.m_axis_tvalid(m_axis_tvalid),
.m_axis_tready(m_axis_tready),   
.m_axis_aclk  (m_axis_aclk	)

);


rows_resize
#(
	.DATA_WIDTH(8)
)
rows_resize_I
(
	
	.pixel_clk(m_axis_aclk)       ,
	.rows_size   	(3840),
	.s_axis_tdata    (m_axis_tdata ),
	.s_axis_tlast    (m_axis_tlast ),
	.s_axis_tuser    (m_axis_tuser ),
	.s_axis_tvalid   (m_axis_tvalid),
	
	.m_axis_tlast   (),
	.m_axis_tuser   (),
	.m_axis_tvalid  (),
	.m_axis_tdata   ()

 );

FrmCmp_Irq FrmCmp_Irq_i
(
	.s_axis_aclk(m_axis_aclk)      ,
	.s_axis_tlast(m_axis_tlast )    ,
	.s_axis_tuser (m_axis_tuser )   ,
	.img_vsize	(12'd15),
	.FrmCmp_Irq   ()
		
);

*/

endmodule