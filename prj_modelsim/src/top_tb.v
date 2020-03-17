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


// tb_imgProcess tb_img_I
// (
	// .clk(clk_100m),
	// .resetn(resetn)

// );


TCD1209D
#(
	.D_WIDTH(8)
)
TCD1209D_i
(
// TCD1290D_driver
.sys_clk(clk_100m),
.f1_cnt(50),
.sh(),
.f1(),
.f2(),
.f2b(),
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
.DATA_IN(55),
.tdata(),
.tvalid()

);

endmodule