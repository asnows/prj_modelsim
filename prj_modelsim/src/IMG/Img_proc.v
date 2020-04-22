`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/11 13:44:48
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
'define RGB_MODEL
//////////////////////////////////////////////////////////////////////////////////
module Img_proc
#(
        parameter CMOS_DATA_WIDTH = 8,
        parameter RGB_WIDTH  = 24,
        parameter IMG_WIDTH  = 2560,
        parameter IMG_HEIGHT = 1440

)
(
	input	   sys_resetn,
	input      CMOS_PIXCLK,   // 像素时钟信号
	input      CMOS_FSYNC,   //  帧同步信号
	input      CMOS_LREF,    //  行同步信号
	input[11:0]CMOS_DATA,    //  像素数据
	
	input       dpc_en          ,
	input       gaus_en         ,
	input       gaus_shrap_en   ,
	input[9:0]  dpc_threshold   ,
	input[3:0]  debug_cmd1      ,
	input[3:0]  debug_cmd2      ,

	input		m_axis_aclk	,
	output[31:0]m_axis_tdata ,
	output      m_axis_tlast ,
	input       m_axis_tready,
	output      m_axis_tuser ,
	output      m_axis_tvalid


	
);
    parameter RAW_WIDTH  = 12;
    parameter DATA_WIDTH = 8;
	parameter RGB_WIDTH = 24;
    parameter IMG_WIDTH  = 2560;//640;2304
    parameter IMG_HEIGHT = 1440;//480;
    
    wire FCLK_CLK0                  ;
    wire sys_reset                  ;
    wire coms_clk                   ;
    
    
                                      
    wire[DATA_WIDTH - 1: 0]vcap_m_axis_tdata ;
    wire      vcap_m_axis_tlast ;
    wire      vcap_m_axis_tready;
    wire      vcap_m_axis_tuser ;
    wire      vcap_m_axis_tvalid;
    
    
    wire[DATA_WIDTH - 1:0 ]dconv_s_axis_tdata ;
    wire      dconv_s_axis_tlast ;
    wire      dconv_s_axis_tready;
    wire      dconv_s_axis_tuser ;
    wire      dconv_s_axis_tvalid;
    
    
    wire[31:0]dconv_m_axis_tdata ;
    wire      dconv_m_axis_tlast ;
    wire      dconv_m_axis_tready;
    wire      dconv_m_axis_tuser ;
    wire      dconv_m_axis_tvalid;
    
    
    wire[DATA_WIDTH - 1:0]  coms_data_in ;
    wire                    coms_href_in ;
    wire                    coms_vsync_in;
     
    wire      isp_model_axis_tlast  ;
    wire      isp_model_axis_tready ;
    wire      isp_model_axis_tuser  ;
    wire      isp_model_axis_tvalid ;
'ifdef RGB_MODEL
    wire[RGB_WIDTH - 1:0] isp_model_axis_tdata  ;
'else
	wire[DATA_WIDTH - 1:0] isp_model_axis_tdata  ;
'ednif    

    wire                   opencv_m_axis_tready   ;
    wire                   opencv_m_axis_tlast    ;
    wire                   opencv_m_axis_tuser    ;
    wire                   opencv_m_axis_tvalid   ;
    wire [31:0]  opencv_m_axis_tdata    ;
	
	reg[31:0]m_axis_tdata_reg ;
	reg      m_axis_tlast_reg ;
	reg      m_axis_tuser_reg ;
	reg      m_axis_tvalid_reg;
         
    assign sys_reset = ~sys_resetn;
	assign m_axis_tdata  = m_axis_tdata_reg; 
	assign m_axis_tlast  = m_axis_tlast_reg ;
	assign m_axis_tuser  = m_axis_tuser_reg ;
	assign m_axis_tvalid = m_axis_tvalid_reg;

    cmos_sampling
    #(
        .RAW_WIDTH (RAW_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    )
    cmos_sampling_i
    (
        .pixel_clk(CMOS_PIXCLK) ,   
        .vsync    (CMOS_FSYNC ) ,       
        .href     (CMOS_LREF  ) ,        
        .data_in  (CMOS_DATA  ) ,
        
        .pixel_clk_out(coms_clk     ),
        .vsync_out    (coms_vsync_in),       
        .href_out     (coms_href_in ),        
        .data_out     (coms_data_in )
    );


    video_caputure 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH )
    )
    vcap_i
    (
        .piexl_clk    (coms_clk         ),
        .href         (coms_href_in     ),
        .vsync        (coms_vsync_in    ),
        .data_in      (coms_data_in     ),
       
        .m_axis_tdata (vcap_m_axis_tdata ),
        .m_axis_tlast (vcap_m_axis_tlast ),
        .m_axis_tready(vcap_m_axis_tready),
        .m_axis_tuser (vcap_m_axis_tuser ),
        .m_axis_tvalid(vcap_m_axis_tvalid)
    ); 
    
    
	
`ifdef RGB_MODEL	
   isp_rgb_model_axis 
   #(
        .DATA_WIDTH (DATA_WIDTH),
        .RGB_WIDTH  ( RGB_WIDTH),
        .IMG_WIDTH  (IMG_WIDTH ),
        .IMG_HEIGHT (IMG_HEIGHT)
    )
	isp_rgb_model_axis_I
    (
        .pixel_clk       (coms_clk),
        .s_axis_tdata    (vcap_m_axis_tdata ) ,
        .s_axis_tlast    (vcap_m_axis_tlast ) ,
        .s_axis_tready   (vcap_m_axis_tready) ,
        .s_axis_tuser    (vcap_m_axis_tuser ) ,
        .s_axis_tvalid   (vcap_m_axis_tvalid) ,
        .bayerType       (debug_cmd1[1:0]),
        .m_axis_tlast    ( isp_model_axis_tlast  ),
        .m_axis_tready   ( isp_model_axis_tready ),
        .m_axis_tuser    ( isp_model_axis_tuser  ),
        .m_axis_tvalid   ( isp_model_axis_tvalid ),
        .m_axis_tdata    ( isp_model_axis_tdata  ) 
    );

'else
    
   isp_model_axis
   #(
       .DATA_WIDTH(DATA_WIDTH),
       .IMG_WIDTH (IMG_WIDTH ),
       .IMG_HEIGHT(IMG_HEIGHT)
   )
   isp_model_axis_i
   (
       .pixel_clk       (coms_clk         ),
       .s_axis_tdata    (vcap_m_axis_tdata ),
       .s_axis_tlast    (vcap_m_axis_tlast ),
       .s_axis_tready   (vcap_m_axis_tready),
       .s_axis_tuser    (vcap_m_axis_tuser ),
       .s_axis_tvalid   (vcap_m_axis_tvalid), 
       .dpc_en          (isp_model_dpc_en       ),  
       .gaus_en         (isp_model_gaus_en      ),  
       .gaus_shrap_en   (isp_model_gaus_sharp_en),  
       .dpc_threshold       (dpc_threshold         ),//颜色黑电G平校正设   
       .debug_cmd           (debug_cmd1            ), //B颜色黑电平校正设 
       .gaus_shrap_threshold(gaus_shrap_threshold  ),                     
       .gaus_sharp_factor   (gaus_sharp_factor     ),                     
       .m_axis_tlast (isp_model_axis_tlast ),
       .m_axis_tready(isp_model_axis_tready),
       .m_axis_tuser (isp_model_axis_tuser ),
       .m_axis_tvalid(isp_model_axis_tvalid),
       .m_axis_tdata (isp_model_axis_tdata )   
   );

'endif   
    
 
`ifdef OPENC_CV_MODLE 
   opencv_model
   #(
       .DATA_WIDTH(DATA_WIDTH),
       .IMG_WIDTH (IMG_WIDTH ),
       .IMG_HEIGHT(IMG_HEIGHT)
   )
   opencv_model_i
   (
       .pixel_clk         (coms_clk       ),
       .resetn            (sys_resetn     ),
       .debug_cmd         (debug_cmd2     ),
       .sobel_enable      (WO_reg11[18]     ),
       .sobel_threshold   (WO_reg11[15:8]   ),
       .sobel_kernel      (WO_reg11[17:16] ),
       .sobel_model       (WO_reg11[19] ), 
       .s_axis_tlast    (isp_model_axis_tlast  ),
       .s_axis_tuser    (isp_model_axis_tuser  ),
       .s_axis_tvalid   (isp_model_axis_tvalid ), 
       .s_axis_tdata    (isp_model_axis_tdata  ),
       .s_axis_tready   (isp_model_axis_tready ),
       .m_axis_tready   (opencv_m_axis_tready   ),
       .m_axis_tlast    (opencv_m_axis_tlast    ),
       .m_axis_tuser    (opencv_m_axis_tuser    ),
       .m_axis_tvalid   (opencv_m_axis_tvalid   ),
       .m_axis_tdata    (opencv_m_axis_tdata    )
   );
    
   assign dconv_s_axis_tdata  = opencv_m_axis_tdata  ;
   assign dconv_s_axis_tlast  = opencv_m_axis_tlast  ;
   assign opencv_m_axis_tready= dconv_s_axis_tready ;
   assign dconv_s_axis_tuser  = opencv_m_axis_tuser  ;
   assign dconv_s_axis_tvalid = opencv_m_axis_tvalid ;

`else

   assign dconv_s_axis_tdata  = vcap_m_axis_tdata  ;
   assign dconv_s_axis_tlast  = vcap_m_axis_tlast  ;
   assign vcap_m_axis_tready  = dconv_s_axis_tready ;
   assign dconv_s_axis_tuser  = vcap_m_axis_tuser  ;
   assign dconv_s_axis_tvalid = vcap_m_axis_tvalid ;

`endif 

    data_conv_model
    #(
      .DATA_WIDTH(24),
      .IMG_WIDTH(IMG_WIDTH)
    ) data_conv_model_i
    (
    
        .m_aclk        (FCLK_CLK0          ),
        .s_aclk        (coms_clk           ),
        .s_aresetn     (sys_resetn         ),        
        .s_axis_tvalid (dconv_s_axis_tvalid),
        .s_axis_tready (dconv_s_axis_tready),
        .s_axis_tdata  (dconv_s_axis_tdata ),
        .s_axis_tlast  (dconv_s_axis_tlast ),
        .s_axis_tuser  (dconv_s_axis_tuser ),        
        .debug_cmd     (debug_cmd2         ),//R颜色黑电平校正设 ,
        .m_axis_tvalid(dconv_m_axis_tvalid) ,
        .m_axis_tready(m_axis_tready	  ) ,
        .m_axis_tdata (dconv_m_axis_tdata ) ,
        .m_axis_tlast (dconv_m_axis_tlast ) ,
        .m_axis_tuser (dconv_m_axis_tuser )   
    );
	

always@(posedge m_axis_aclk)
begin

	if(m_axis_tready == 1'b1)
	begin
		m_axis_tdata_reg  <= dconv_m_axis_tdata ;
		m_axis_tlast_reg  <= dconv_m_axis_tlast ;
		m_axis_tuser_reg  <= dconv_m_axis_tuser ;
		m_axis_tvalid_reg <= dconv_m_axis_tvalid; 
	end                       
end


endmodule
