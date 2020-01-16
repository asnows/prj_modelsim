module tb_imgProcess
(
	input clk,
	input resetn


);

    parameter DATA_WIDTH = 8;
    parameter IMG_WIDTH  = 2560;
    parameter IMG_HEIGHT = 1440;  
     
    // wire hsync_out        ;
    // wire hblank_out       ;
    // wire vsync_out        ;
    // wire vblank_out       ;
    // wire active_video_out ;  
	
	wire [DATA_WIDTH - 1 : 0 ] vcap_m_axis_tdata ;
    wire          vcap_m_axis_tlast ;
    wire          vcap_m_axis_tready;
    wire          vcap_m_axis_tuser ;
    wire          vcap_m_axis_tvalid;  
	wire cap_tready;	
	
	reg read_en_dly = 1'b0;
	reg[7:0] couts = 8'd0;
	
	
	always@(posedge clk)
	begin
		if(~resetn)
		begin
			couts <= 8'd0;
		end
		else
		begin
			if(couts <= 8'd200)
			begin
				couts <= couts + 1'b1;
			end
		end	
	end

	always@(posedge clk)
	begin
		if(couts > 8'd16)
		begin
			read_en_dly <= 1'b1;
		end
		
	end
	



    // v_tc_0 v_tc_0_i
    // (
    // .clk                 (clk         ),
    // .clken               (1'b1            ),
    // .gen_clken           (1'b1            ),
    // .hsync_out           (hsync_out       ),
    // .hblank_out          (hblank_out      ),
    // .vsync_out           (vsync_out       ),
    // .vblank_out          (vblank_out      ),
    // .active_video_out    (active_video_out),
    // .resetn              (resetn          ),
    // .fsync_out           (                )
    // );
    
    wire [7:0] file_data;
    wire read_file_valid;
	
	read_file
	#(
		.DATA_WIDTH(DATA_WIDTH      ) ,
		.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT ),
		.FILE_NAME( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/src_sc4210_2560x1440.raw")
	)
	read_file_i
	(
		.clk      (clk),  
		.read_en  (cap_tready & read_en_dly),
		.data_valid(read_file_valid),
		.data_out (file_data)
	);    
	
	 video_caputure 
     #(
     .DATA_WIDTH(DATA_WIDTH),
     .IMG_WIDTH (IMG_WIDTH )
 )
video_caputure_0_i
    (
     //.vsync(vsync_out  ),
     .vsync(~resetn  ),
     .s_axis_aclk  (clk            ),
     .s_axis_tready(cap_tready),

     .s_axis_tdata (file_data ),
     .s_axis_tkeep (1'b1 ),
     .s_axis_tlast (1'b1 ),
     .s_axis_tvalid(read_file_valid ),

     .m_axis_tdata (vcap_m_axis_tdata ) ,
     .m_axis_tlast (vcap_m_axis_tlast ) ,
     .m_axis_tuser (vcap_m_axis_tuser ) ,
     .m_axis_tvalid(vcap_m_axis_tvalid) ,
     .m_axis_tready(1'b1)
   );



    wire                  maxtri3x3_shift_buff_0_tlast  ;
    wire                  maxtri3x3_shift_buff_0_tuser  ;
    wire                  maxtri3x3_shift_buff_0_tvalid ;
    wire[DATA_WIDTH-1:0]  maxtri3x3_shift_buff_0_tdata  ; 
    
    wire                  maxtri3x3_shift_buff_1_tlast  ;
    wire                  maxtri3x3_shift_buff_1_tuser  ;
    wire                  maxtri3x3_shift_buff_1_tvalid ;
    wire[DATA_WIDTH-1:0]  maxtri3x3_shift_buff_1_tdata  ;
    
    wire                  maxtri3x3_shift_buff_2_tlast  ;
    wire                  maxtri3x3_shift_buff_2_tuser  ;
    wire                  maxtri3x3_shift_buff_2_tvalid ;
    wire[DATA_WIDTH-1:0]  maxtri3x3_shift_buff_2_tdata  ;



   maxtri3x3_shift
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    maxtri3x3_shift_i
    (
		.resetn			(resetn),
        .s_axis_aclk     (clk            ),
        .s_axis_tdata    (vcap_m_axis_tdata ),
        .s_axis_tlast    (vcap_m_axis_tlast ),
        .s_axis_tuser    (vcap_m_axis_tuser ),
        .s_axis_tvalid   (vcap_m_axis_tvalid),
        .s_axis_tready  (),
        
        .m_axis_line_buff_0_tlast (maxtri3x3_shift_buff_0_tlast )   ,
        .m_axis_line_buff_0_tuser (maxtri3x3_shift_buff_0_tuser )   ,
        .m_axis_line_buff_0_tvalid(maxtri3x3_shift_buff_0_tvalid)   ,
        .m_axis_line_buff_0_tdata (maxtri3x3_shift_buff_0_tdata )   , 
                                                        
        .m_axis_line_buff_1_tlast (maxtri3x3_shift_buff_1_tlast )   ,
        .m_axis_line_buff_1_tuser (maxtri3x3_shift_buff_1_tuser )   ,
        .m_axis_line_buff_1_tvalid(maxtri3x3_shift_buff_1_tvalid)   ,
        .m_axis_line_buff_1_tdata (maxtri3x3_shift_buff_1_tdata )   ,
                                                                
        .m_axis_line_buff_2_tlast (maxtri3x3_shift_buff_2_tlast )   ,
        .m_axis_line_buff_2_tuser (maxtri3x3_shift_buff_2_tuser )   ,
        .m_axis_line_buff_2_tvalid(maxtri3x3_shift_buff_2_tvalid)   ,
        .m_axis_line_buff_2_tdata (maxtri3x3_shift_buff_2_tdata )     
        
    );






write_file
#(
	.DATA_WIDTH(DATA_WIDTH),
	.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT),
	.FILE_NAME ( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/dst_imgProcess.raw")
)
write_file_0
(
	.clk(clk),  
	.write_en(vcap_m_axis_tvalid ),
	.stop_en(1'b1),
	.data_in (vcap_m_axis_tdata)

);



endmodule