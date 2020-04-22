`timescale 1ns / 1ps
/*
模块名：
	isp_model_axis
功能：
	图像ISP处理模块
参数：
	DATA_WIDTH：
		数据位宽
	IMG_WIDTH：
		图像宽度
	IMG_HEIGHT：
		图像高度
	
	pixel_clk：
		像素时钟
	


设计原理：
	支持RGB模式和mono模式
	

版本：
	1.0:20200217——基于基于sc4210修改为支持RGB模式

*/
'define RGB_MODLE

module isp_model_axis
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk       ,
        input[DATA_WIDTH - 1:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        output      s_axis_tready   ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        input       dpc_en          ,
        input       gaus_en         ,
        input       gaus_shrap_en   ,
        input[9:0]  dpc_threshold   ,
        input[3:0]  debug_cmd       ,
        input[9:0]  gaus_shrap_threshold,
        input[7:0]  gaus_sharp_factor,
        (*mark_debug="true"*)output      m_axis_tlast    ,
        (*mark_debug="true"*)input       m_axis_tready   ,
        (*mark_debug="true"*)output      m_axis_tuser    ,
        (*mark_debug="true"*)output      m_axis_tvalid   ,
'ifdef RGB_MODLE
                             output[23:0] m_axis_tdata    
'else
							 output[DATA_WIDTH - 1:0] m_axis_tdata 
'endif							 
    );
    
    reg[DATA_WIDTH - 1:0]    s_axis_tdata_dely ;
    reg         s_axis_tlast_dely ;
    reg         s_axis_tuser_dely ;
    reg         s_axis_tvalid_dely;
    reg[3:0]    debug_cmd_dely;
    
    reg         m_axis_tlast_reg ; 
    reg         m_axis_tuser_reg ; 
    reg         m_axis_tvalid_reg; 
	
'ifdef RGB_MODLE	
    reg[DATA_WIDTH - 1:0]    m_axis_tdata_reg ; 
'else
	reg[23:0]    m_axis_tdata_reg ; 
'endif
    
    wire        dpc_matrix_tlast ;
    wire        dpc_matrix_tuser ;
    wire        dpc_matrix_tvalid;  
    wire[DATA_WIDTH - 1:0]   dpc_matrix_01;
    wire[DATA_WIDTH - 1:0]   dpc_matrix_11;
    wire[DATA_WIDTH - 1:0]   dpc_matrix_21;
    
    wire        dpc_axis_tlast ;
    wire        dpc_axis_tuser ;
    wire        dpc_axis_tvalid;   
    wire[DATA_WIDTH - 1:0]   dpc_axis_tdata ;
    
    wire        gaus_matrix_tlast ;
    wire        gaus_matrix_tuser ;
    wire        gaus_matrix_tvalid;  
    wire[DATA_WIDTH - 1:0]   gaus_matrix_01;
    wire[DATA_WIDTH - 1:0]   gaus_matrix_11;
    wire[DATA_WIDTH - 1:0]   gaus_matrix_21;
    
    wire        gaus2_matrix_tlast ;
    wire        gaus2_matrix_tuser ;
    wire        gaus2_matrix_tvalid;  
    wire[DATA_WIDTH - 1:0]   gaus2_matrix_01;
    wire[DATA_WIDTH - 1:0]   gaus2_matrix_11;
    wire[DATA_WIDTH - 1:0]   gaus2_matrix_21;
    
    wire         gaus_filter_tlast      ;
    wire         gaus_filter_tuser      ;
    wire         gaus_filter_tvalid     ;   
    wire[DATA_WIDTH - 1:0]    gaus_filter_tdata_gaus ;
    wire[DATA_WIDTH - 1:0]    gaus_filter_tdata_raw  ;
    
    wire         gaus2_filter_tlast      ;
    wire         gaus2_filter_tuser      ;
    wire         gaus2_filter_tvalid     ;   
    wire[DATA_WIDTH - 1:0]    gaus2_filter_tdata_gaus ;
    wire[DATA_WIDTH - 1:0]    gaus2_filter_tdata_raw  ;
    
    
    reg          dpc_en_dely          ;
    reg          gaus_en_dely         ;
    reg          gaus_shrap_en_dely   ;
    reg[DATA_WIDTH - 1:0]     dpc_threshold_dely   ;
    reg[DATA_WIDTH - 1:0]     gaus_shrap_threshold_dely;
    reg[7:0]     gaus_sharp_factor_dely;
    
    wire         gaus_sharp_tlast ;
    wire         gaus_sharp_tuser ;
    wire         gaus_sharp_tvalid;
    wire[DATA_WIDTH - 1:0]    gaus_sharp_tdata ;
    
    
    wire          histogram_axis_tlast ;
    wire          histogram_axis_tready;
    wire          histogram_axis_tuser ;
    wire          histogram_axis_tvalid;
    wire[7:0]     histogram_axis_tdata ; 
    
    
    wire        bayer2rgb_matrix_tlast ;
    wire        bayer2rgb_matrix_tuser ;
    wire        bayer2rgb_matrix_tvalid;  
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_01;
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_11;
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_21;
    wire        bayer2rgb_axis_tlast ;
    wire        bayer2rgb_axis_tuser ;
    wire        bayer2rgb_axis_tvalid;   
    wire[23:0]  bayer2rgb_axis_tdata ;   
    
    
    wire                   gamma_axis_tlast ;                 
    wire                   gamma_axis_tuser ;                
    wire                   gamma_axis_tvalid;             
    wire[DATA_WIDTH - 1:0] gamma_axis_tdata ; 
    
    wire                    rgb2gray_axis_tlast ;
    wire                    rgb2gray_axis_tuser ;
    wire                    rgb2gray_axis_tvalid;   
    wire[DATA_WIDTH -1:0]   rgb2gray_axis_tdata ; 
    

       
    assign m_axis_tlast  = m_axis_tlast_reg ;
    assign m_axis_tuser  = m_axis_tuser_reg ;
    assign m_axis_tvalid = m_axis_tvalid_reg;
    assign m_axis_tdata  = m_axis_tdata_reg;
    assign s_axis_tready = m_axis_tready;

  
    always@(posedge pixel_clk)
    begin
        s_axis_tdata_dely  <= s_axis_tdata ;
        s_axis_tlast_dely  <= s_axis_tlast ;
        s_axis_tuser_dely  <= s_axis_tuser ;
        s_axis_tvalid_dely <= s_axis_tvalid;
        
        dpc_en_dely                 <= dpc_en         ;    
        gaus_en_dely                <= gaus_en        ;    
        gaus_shrap_en_dely          <= gaus_shrap_en  ;    
        dpc_threshold_dely          <= dpc_threshold  ;    
        gaus_shrap_threshold_dely   <= gaus_shrap_threshold;
        gaus_sharp_factor_dely      <= gaus_sharp_factor;   
        debug_cmd_dely              <= debug_cmd;
        
    end  
    
    
    
    maxtri3x3_shift 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    maxtri3x3_bayer2rgb
    (
        .pixel_clk    (pixel_clk          ),
        .s_axis_tdata (s_axis_tdata_dely  ),
        .s_axis_tlast (s_axis_tlast_dely  ),
        .s_axis_tuser (s_axis_tuser_dely  ),
        .s_axis_tvalid(s_axis_tvalid_dely ),
        
        
        .m_axis_tlast (bayer2rgb_matrix_tlast   ),
        .m_axis_tuser (bayer2rgb_matrix_tuser   ),
        .m_axis_tvalid(bayer2rgb_matrix_tvalid  ),   
        .matrix_01    (bayer2rgb_matrix_21      ),
        .matrix_11    (bayer2rgb_matrix_11      ),
        .matrix_21    (bayer2rgb_matrix_01      )
    
    );
    
    bayer2rgb    
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    U_bayer2rgb
    (
        .pixel_clk    (pixel_clk                ),
        .s_axis_tlast (bayer2rgb_matrix_tlast   ),
        .s_axis_tuser (bayer2rgb_matrix_tuser   ),
        .s_axis_tvalid(bayer2rgb_matrix_tvalid  ),   
        .matrix_data01(bayer2rgb_matrix_01      ), 
        .matrix_data11(bayer2rgb_matrix_11      ), 
        .matrix_data21(bayer2rgb_matrix_21      ),
        //.debug_cmd(gaus_sharp_factor)         ,
        .debug_cmd(2'b11)         , //SC2238  BayerType = RGGB = 2'b11;
        
        .m_axis_tlast (bayer2rgb_axis_tlast     ),
        .m_axis_tuser (bayer2rgb_axis_tuser     ),
        .m_axis_tvalid(bayer2rgb_axis_tvalid    ),   
        .m_axis_tdata (bayer2rgb_axis_tdata     )// R= m_axis_tdata[7:0],G= m_axis_tdata[15:8],B= m_axis_tdata[23:16],
        
    );
    
    rgb2gray 
    #(
        .DATA_WIDTH(DATA_WIDTH)
    
    )
    U_rgb2gray
    (
        .pixel_clk    (pixel_clk                ),
        .s_axis_tlast (bayer2rgb_axis_tlast     ),
        .s_axis_tuser (bayer2rgb_axis_tuser     ),
        .s_axis_tvalid(bayer2rgb_axis_tvalid    ),   
        .s_axis_tdata (bayer2rgb_axis_tdata     ), 
        .sel_way      (1'b1   ),
        
        .m_axis_tlast (rgb2gray_axis_tlast      ),
        .m_axis_tuser (rgb2gray_axis_tuser      ),
        .m_axis_tvalid(rgb2gray_axis_tvalid     ),   
        .m_axis_tdata (rgb2gray_axis_tdata      ) 
    
    );

    
    
    
    
    
    maxtri3x3_shift 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    maxtri3x3_dpc_i
    (
        .pixel_clk    (pixel_clk            ),
        .s_axis_tdata (rgb2gray_axis_tdata  ),
        .s_axis_tlast (rgb2gray_axis_tlast  ),
        .s_axis_tuser (rgb2gray_axis_tuser  ),
        .s_axis_tvalid(rgb2gray_axis_tvalid ),
        
        .m_axis_tlast (dpc_matrix_tlast   ),
        .m_axis_tuser (dpc_matrix_tuser   ),
        .m_axis_tvalid(dpc_matrix_tvalid  ),   
        .matrix_01    (dpc_matrix_01      ),
        .matrix_11    (dpc_matrix_11      ),
        .matrix_21    (dpc_matrix_21      )
    
    );

    
    
    dpc_axis 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    dpc_axis_i
    (
        .pixel_clk   (pixel_clk          ),
        .dpc_en      (dpc_en_dely        ),
        .threshold   (10'd40             ),
         
        .s_axis_tlast (dpc_matrix_tlast ),
        .s_axis_tuser (dpc_matrix_tuser ),
        .s_axis_tvalid(dpc_matrix_tvalid),   
        .matrix_data01(dpc_matrix_01    ), 
        .matrix_data11(dpc_matrix_11    ), 
        .matrix_data21(dpc_matrix_21    ),
        
        .m_axis_tlast (dpc_axis_tlast ),
        .m_axis_tuser (dpc_axis_tuser ),
        .m_axis_tvalid(dpc_axis_tvalid),   
        .m_axis_tdata (dpc_axis_tdata )
    
    );
    
    
    maxtri3x3_shift
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
     maxtri3x3_gaus_i
    (
        .pixel_clk    (pixel_clk         ),
        .s_axis_tdata (dpc_axis_tdata    ),
        .s_axis_tlast (dpc_axis_tlast    ),
        .s_axis_tuser (dpc_axis_tuser    ),
        .s_axis_tvalid(dpc_axis_tvalid   ),
        
        .m_axis_tlast (gaus_matrix_tlast   ),
        .m_axis_tuser (gaus_matrix_tuser   ),
        .m_axis_tvalid(gaus_matrix_tvalid  ),   
        .matrix_01    (gaus_matrix_01      ),
        .matrix_11    (gaus_matrix_11      ),
        .matrix_21    (gaus_matrix_21      )
    
    );


    gaus_filter_axis
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
     gaus_filter_axis_i
    (
        .pixel_clk    (pixel_clk           ),
        .gaus_en      (gaus_en_dely        ),
        .s_axis_tlast (gaus_matrix_tlast   ),
        .s_axis_tuser (gaus_matrix_tuser   ),
        .s_axis_tvalid(gaus_matrix_tvalid  ),   
        .matrix_data01(gaus_matrix_01      ), 
        .matrix_data11(gaus_matrix_11      ), 
        .matrix_data21(gaus_matrix_21      ),
        
        .m_axis_tlast     (gaus_filter_tlast     ),
        .m_axis_tuser     (gaus_filter_tuser     ),
        .m_axis_tvalid    (gaus_filter_tvalid    ), 
        .m_axis_tdata_gaus(gaus_filter_tdata_gaus),
        .m_axis_tdata_raw (gaus_filter_tdata_raw )
    
    );
    
    
    gaus_sharp_axis
    #(
        .DATA_WIDTH(DATA_WIDTH)
    )
     gaus_sharp_axis_i
    (
        .pixel_clk(pixel_clk),
        .shrap_en(gaus_shrap_en_dely),
        .sharp_threlode_in(gaus_shrap_threshold_dely) ,
        .sharp_factor_in  (gaus_sharp_factor_dely   ),
        .s_axis_tlast (gaus_filter_tlast     ),
        .s_axis_tuser (gaus_filter_tuser     ),
        .s_axis_tvalid(gaus_filter_tvalid    ),
        .data_raw_in  (gaus_filter_tdata_raw),
        .data_gaus_in (gaus_filter_tdata_gaus ),
        
        .m_axis_tlast  (gaus_sharp_tlast )  ,
        .m_axis_tuser  (gaus_sharp_tuser )  ,
        .m_axis_tvalid (gaus_sharp_tvalid)  ,
        .m_axis_tdata  (gaus_sharp_tdata )  
    
    );
    
    
//     v_gamma_0  U_gamma
//       (
//        .aclk                    (pixel_clk          ),
//        .aclken                  (1'b1               ),
//        .aresetn                 (~s_axis_tuser_dely   ),
//        .s_axis_video_tdata      (gaus_sharp_tdata   ),
//        .s_axis_video_tready     (),
//        .s_axis_video_tvalid     (gaus_sharp_tvalid  ),
//        .s_axis_video_tlast      (gaus_sharp_tlast   ),
//        .s_axis_video_tuser_sof  (gaus_sharp_tuser   ),
        
//        .m_axis_video_tdata      (gamma_axis_tdata   ),
//        .m_axis_video_tvalid     (gamma_axis_tvalid  ),
//        .m_axis_video_tready     (1'b1               ),
//        .m_axis_video_tlast      (gamma_axis_tlast   ),
//        .m_axis_video_tuser_sof  (gamma_axis_tuser   )
//      );
  
    
    
//    histogram_axis
//    #(
//        .IMG_HEIGHT (IMG_HEIGHT)
//    )
//    histogram_axis_i
//    (
//        .pixel_clk     (pixel_clk        ),
//        .s_axis_tlast (gaus_sharp_tlast  ),
//        .s_axis_tready(                  ),
//        .s_axis_tuser (gaus_sharp_tuser  ),
//        .s_axis_tvalid(gaus_sharp_tvalid ),
//        .s_axis_tdata (gaus_sharp_tdata  ), 
//        .m_axis_tlast (histogram_axis_tlast ),
//        .m_axis_tready(histogram_axis_tready),
//        .m_axis_tuser (histogram_axis_tuser ),
//        .m_axis_tvalid(histogram_axis_tvalid),
//        .m_axis_tdata (histogram_axis_tdata )   
//    );
    
    
    
    
    
    

    

    // always@(posedge pixel_clk )
    // begin
        // case (debug_cmd_dely)
            // 4'b0000:
            // begin
                
                // m_axis_tlast_reg  <= gaus_filter_tlast     ;
                // m_axis_tuser_reg  <= gaus_filter_tuser     ;
                // m_axis_tvalid_reg <= gaus_filter_tvalid    ;
                // m_axis_tdata_reg  <= gaus_filter_tdata_gaus;
                
                
            // end
            
            // 4'b0001:
            // begin
                // m_axis_tlast_reg  <= s_axis_tlast_dely ;
                // m_axis_tuser_reg  <= s_axis_tuser_dely ;
                // m_axis_tvalid_reg <= s_axis_tvalid_dely;
                // m_axis_tdata_reg  <= s_axis_tdata_dely;
                
            // end
            
            // 4'b0010:
            // begin
                // m_axis_tlast_reg  <= dpc_matrix_tlast  ;
                // m_axis_tuser_reg  <= dpc_matrix_tuser  ;
                // m_axis_tvalid_reg <= dpc_matrix_tvalid ;
                // m_axis_tdata_reg  <= dpc_matrix_11     ;
                
            // end
            
            // 4'b0011:
            // begin
            
                // m_axis_tlast_reg  <= dpc_axis_tlast ;
                // m_axis_tuser_reg  <= dpc_axis_tuser ;
                // m_axis_tvalid_reg <= dpc_axis_tvalid;
                // m_axis_tdata_reg  <= dpc_axis_tdata ;
            
            // end
            
            // 4'b0100:
            // begin
                // m_axis_tlast_reg  <= gaus_matrix_tlast  ;
                // m_axis_tuser_reg  <= gaus_matrix_tuser  ;
                // m_axis_tvalid_reg <= gaus_matrix_tvalid ;
                // m_axis_tdata_reg  <= gaus_matrix_11     ;
            // end
            
            // 4'b0101:
            // begin
                // m_axis_tlast_reg  <= gaus_filter_tlast     ;
                // m_axis_tuser_reg  <= gaus_filter_tuser     ;
                // m_axis_tvalid_reg <= gaus_filter_tvalid    ;
                // m_axis_tdata_reg  <= gaus_filter_tdata_gaus;
            
            // end
            
            // 4'b0110:
            // begin
                // m_axis_tlast_reg  <= gaus_sharp_tlast ;
                // m_axis_tuser_reg  <= gaus_sharp_tuser ;
                // m_axis_tvalid_reg <= gaus_sharp_tvalid;
                // m_axis_tdata_reg  <= gaus_sharp_tdata ;

            // end
            
            // 4'b0111:
            // begin
                // m_axis_tlast_reg  <= gamma_axis_tlast ;
                // m_axis_tuser_reg  <= gamma_axis_tuser ;
                // m_axis_tvalid_reg <= gamma_axis_tvalid;
                // m_axis_tdata_reg  <= gamma_axis_tdata ;

            // end            
            
            // default:
            // begin
                // m_axis_tlast_reg  <= gaus_filter_tlast     ;
                // m_axis_tuser_reg  <= gaus_filter_tuser     ;
                // m_axis_tvalid_reg <= gaus_filter_tvalid    ;
                // m_axis_tdata_reg  <= gaus_filter_tdata_gaus;
            // end
        // endcase        
    // end    


'ifdef
                m_axis_tlast_reg  <= bayer2rgb_axis_tlast ;
                m_axis_tuser_reg  <= bayer2rgb_axis_tuser ;
                m_axis_tvalid_reg <= bayer2rgb_axis_tvalid;
                m_axis_tdata_reg  <= bayer2rgb_axis_tdata ;

'else
                m_axis_tlast_reg  <= gaus_filter_tlast     ;
                m_axis_tuser_reg  <= gaus_filter_tuser     ;
                m_axis_tvalid_reg <= gaus_filter_tvalid    ;
                m_axis_tdata_reg  <= gaus_filter_tdata_gaus;				
'endif

                      
   
endmodule


