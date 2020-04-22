module tb_imgProcess
(
	input clk,
	input resetn


);

    parameter DATA_WIDTH = 8;
    parameter IMG_WIDTH  = 2560;
    parameter IMG_HEIGHT = 1440;  
     

	wire [DATA_WIDTH - 1 : 0 ] vcap_m_axis_tdata ;
    wire          vcap_m_axis_tlast ;
    wire          vcap_m_axis_tready;
    wire          vcap_m_axis_tuser ;
    wire          vcap_m_axis_tvalid;  
	wire cap_tready;	
	
	reg read_en_dly = 1'b0;
	reg[11:0] couts = 12'd0;
	
	    wire       isp_rgb_tlast  ;
        wire       isp_rgb_tready ;
        wire       isp_rgb_tuser  ;
        wire       isp_rgb_tvalid ;
        wire[23:0] isp_rgb_tdata  ;

	
	
	
	always@(posedge clk)
	begin
		if(~resetn)
		begin
			couts <= IMG_WIDTH;
		end
		else
		begin
			if(couts < IMG_WIDTH + 20)
			begin
				couts <= couts + 1'b1;
			end
			else
			begin
				couts <= 12'd0;
			end			
		end	
	end

	always@(posedge clk)
	begin
		if(couts < IMG_WIDTH)
		begin
			read_en_dly <= 1'b1;
		end
		else
		begin
			read_en_dly <= 1'b0;
		end
		
		
	end
	
	
	   
    wire [7:0] file_data;
    wire read_file_valid;
	
	read_file
	#(
		.DATA_WIDTH(DATA_WIDTH      ) ,
		.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT ),
		.FILE_NAME( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/src_4210gray.raw")
	)
	read_file_i
	(
		.clk      (clk),  
		.read_en  (resetn&read_en_dly),//(cap_tready & read_en_dly),
		.data_valid(read_file_valid),
		.data_out (file_data)
	);    
	


    video_caputure 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH )
    )
    vcap_i
    (
        .piexl_clk    (clk         ),
        .href         (read_file_valid     ),
        .vsync        (~resetn    		),
        .data_in      (file_data     	),
       
        .m_axis_tdata (vcap_m_axis_tdata ),
        .m_axis_tlast (vcap_m_axis_tlast ),
        .m_axis_tready(1'b1),
        .m_axis_tuser (vcap_m_axis_tuser ),
        .m_axis_tvalid(vcap_m_axis_tvalid)
    ); 
	
	


	isp_rgb_model 
    #(
        .DATA_WIDTH(DATA_WIDTH),
		.RGB_WIDTH (24),
        .IMG_WIDTH (IMG_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
	isp_rgb_model_I
    (
        .pixel_clk       (clk),
		.rst_n			 (resetn),
        .s_axis_tdata    (vcap_m_axis_tdata ) ,
        .s_axis_tlast    (vcap_m_axis_tlast ) ,
        .s_axis_tready   () ,
        .s_axis_tuser    (vcap_m_axis_tuser ) ,
        .s_axis_tvalid   (vcap_m_axis_tvalid) ,
		.debug_cmd		 (4'b0010),
        .bayerType       (2'b11),
        .m_axis_tlast    ( isp_rgb_tlast  ),
        .m_axis_tready   ( 1'b1 ),
        .m_axis_tuser    ( isp_rgb_tuser  ),
        .m_axis_tvalid   ( isp_rgb_tvalid ),
        .m_axis_tdata    ( isp_rgb_tdata  ) 

    );
	
// write_file
// #(
	// .DATA_WIDTH(DATA_WIDTH),
	// .FILE_SIZE (IMG_WIDTH*IMG_HEIGHT),
	// .FILE_NAME ( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/Cap_imgProcess.raw")
// )
// write_file_0
// (
	// .clk(clk),  
	// .write_en(vcap_m_axis_tvalid ),//isp_rgb_tvalid
	// .stop_en(1'b0),
	// .data_in (vcap_m_axis_tdata)//isp_rgb_tdata

// );

write_file
#(
	.DATA_WIDTH(24),
	.FILE_SIZE (IMG_WIDTH*IMG_HEIGHT),
	.FILE_NAME ( "E:/WorkSpace/project/FPGA/prj_modelsim/prj_modelsim/src/SimFile/images/dst_imgProcess.raw")
)
write_file_1
(
	.clk(clk),  
	.write_en(isp_rgb_tvalid ),//isp_rgb_tvalid
	.stop_en(1'b1),
	.data_in (isp_rgb_tdata)//isp_rgb_tdata

);



endmodule