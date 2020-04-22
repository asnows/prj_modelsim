`timescale 1ns / 1ps
/*
模块名：
	isp_rgb_model
功能能：
	RGB模式下ISP处理

版本：
	v0.0  20200428  基于sc2238工程修改，用于SC4210

*/
module isp_rgb_model
    #(
        parameter DATA_WIDTH = 8,
        parameter RGB_WIDTH  = 24,
        parameter IMG_WIDTH  = 2560,
        parameter IMG_HEIGHT = 1440
    )
    (
        input       pixel_clk       ,
		//input       rst_n			,
        input[DATA_WIDTH - 1:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        output      s_axis_tready   ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,

        input[3:0]  debug_cmd       ,
		input[1:0]  bayerType       ,
        output      m_axis_tlast    ,
        input       m_axis_tready   ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[RGB_WIDTH - 1:0] m_axis_tdata    
    );
    
    reg[DATA_WIDTH - 1:0]    s_axis_tdata_dely ;
    reg         s_axis_tlast_dely ;
    reg         s_axis_tuser_dely ;
    reg         s_axis_tvalid_dely;
    reg[3:0]    debug_cmd_dely;
    
    reg         m_axis_tlast_reg ; 
    reg         m_axis_tuser_reg ; 
    reg         m_axis_tvalid_reg; 
    reg[RGB_WIDTH - 1:0]    m_axis_tdata_reg ; 
    
    
    wire        bayer2rgb_matrix_tlast ;
    wire        bayer2rgb_matrix_tuser ;
    wire        bayer2rgb_matrix_tvalid;  
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_01;
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_11;
    wire[DATA_WIDTH - 1:0]   bayer2rgb_matrix_21;
    wire        bayer2rgb_axis_tlast ;
    wire        bayer2rgb_axis_tuser ;
    wire        bayer2rgb_axis_tvalid;   
    wire[RGB_WIDTH -1:0]  bayer2rgb_axis_tdata ;    
    

    
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
        debug_cmd_dely     <= debug_cmd;
        
    end  
    
    
    
    maxtri3x3_shift 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    maxtri3x3_bayer2rgb
    (
        .pixel_clk    (pixel_clk          ),
		//.rst_n		  (rst_n			  ),
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
        .RGB_WIDTH (RGB_WIDTH ),
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
        .bayerType	  (bayerType				),
        
        .m_axis_tlast (bayer2rgb_axis_tlast     ),
        .m_axis_tuser (bayer2rgb_axis_tuser     ),
        .m_axis_tvalid(bayer2rgb_axis_tvalid    ),   
        .m_axis_tdata (bayer2rgb_axis_tdata     )// R= m_axis_tdata[7:0],G= m_axis_tdata[15:8],B= m_axis_tdata[23:16],
        
    );
	
	
	    // rgb2gray 
    // #(
        // .DATA_WIDTH(DATA_WIDTH)
    
    // )
    // U_rgb2gray
    // (
        // .pixel_clk    (pixel_clk                ),
        // .s_axis_tlast (bayer2rgb_axis_tlast     ),
        // .s_axis_tuser (bayer2rgb_axis_tuser     ),
        // .s_axis_tvalid(bayer2rgb_axis_tvalid    ),   
        // .s_axis_tdata (bayer2rgb_axis_tdata     ), 
        // .sel_way      (1'b1   ),
        
        // .m_axis_tlast (rgb2gray_axis_tlast      ),
        // .m_axis_tuser (rgb2gray_axis_tuser      ),
        // .m_axis_tvalid(rgb2gray_axis_tvalid     ),   
        // .m_axis_tdata (rgb2gray_axis_tdata      ) 
    
    // );

      
    always@(posedge pixel_clk )
    begin
        // case (debug_cmd_dely)
            // 4'b0000:
            // begin
                // m_axis_tlast_reg  <= s_axis_tlast_dely ;
                // m_axis_tuser_reg  <= s_axis_tuser_dely ;
                // m_axis_tvalid_reg <= s_axis_tvalid_dely;
                // m_axis_tdata_reg  <= {s_axis_tdata_dely,s_axis_tdata_dely,s_axis_tdata_dely};
            // end
            
            // 4'b0001:
            // begin
                // m_axis_tlast_reg  <= bayer2rgb_matrix_tlast  ;
                // m_axis_tuser_reg  <= bayer2rgb_matrix_tuser  ;
                // m_axis_tvalid_reg <= bayer2rgb_matrix_tvalid ;
                // m_axis_tdata_reg  <= bayer2rgb_matrix_11     ;
            // end
            
            // 4'b0010:
            // begin
                // m_axis_tlast_reg  <= bayer2rgb_axis_tlast ;
                // m_axis_tuser_reg  <= bayer2rgb_axis_tuser ;
                // m_axis_tvalid_reg <= bayer2rgb_axis_tvalid;
                // m_axis_tdata_reg  <= bayer2rgb_axis_tdata ;
            // end
            
            // default:
            // begin
                // m_axis_tlast_reg  <= s_axis_tlast_dely ;
                // m_axis_tuser_reg  <= s_axis_tuser_dely ;
                // m_axis_tvalid_reg <= s_axis_tvalid_dely;
                // m_axis_tdata_reg  <= {s_axis_tdata_dely,s_axis_tdata_dely,s_axis_tdata_dely};
            // end
        // endcase
		        m_axis_tlast_reg  <= bayer2rgb_axis_tlast ;
                m_axis_tuser_reg  <= bayer2rgb_axis_tuser ;
                m_axis_tvalid_reg <= bayer2rgb_axis_tvalid;
                m_axis_tdata_reg  <= bayer2rgb_axis_tdata ;

        
        
    end    

                      
   
endmodule


