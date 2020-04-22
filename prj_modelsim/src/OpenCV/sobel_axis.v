`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/29 10:27:10
// Design Name: 
// Module Name: sobel_axis
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
//////////////////////////////////////////////////////////////////////////////////


module sobel_axis
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk       ,
        input       enable          ,
         input      edge_selelct    ,
        input[7:0]  threshold       ,
        input[1:0]  kernel          ,
        input[DATA_WIDTH-1:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[DATA_WIDTH-1:0] m_axis_Gxdata ,
        output[DATA_WIDTH-1:0] m_axis_Gydata ,
        output[DATA_WIDTH-1:0] m_axis_tdata ,
        output[DATA_WIDTH-1:0] m_axis_raw_tdata    
     );
     
    reg                  s_axis_tlast_dly1 ;
    reg                  s_axis_tuser_dly1 ;
    reg                  s_axis_tvalid_dly1;
    reg[DATA_WIDTH-1:0]  s_axis_tdata_dly1 ;
    
    reg                  m_axis_tlast_reg    ;
    reg                  m_axis_tuser_reg    ;
    reg                  m_axis_tvalid_reg   ;
    reg[DATA_WIDTH-1:0]  m_axis_Gxdata_reg    ;
    reg[DATA_WIDTH-1:0]  m_axis_Gydata_reg    ;
    reg[DATA_WIDTH-1:0]  m_axis_tdata_reg    ;
    reg[DATA_WIDTH-1:0]  m_axis_raw_tdata_reg;   
    
    

    wire                   maxtri7x7_line_0_tlast , maxtri7x7_line_1_tlast , maxtri7x7_line_2_tlast , 
                            maxtri7x7_line_3_tlast , maxtri7x7_line_4_tlast , maxtri7x7_line_5_tlast , maxtri7x7_line_6_tlast ;
    wire                   maxtri7x7_line_0_tuser , maxtri7x7_line_1_tuser , maxtri7x7_line_2_tuser , 
                            maxtri7x7_line_3_tuser , maxtri7x7_line_4_tuser , maxtri7x7_line_5_tuser , maxtri7x7_line_6_tuser ;
    wire                   maxtri7x7_line_0_tvalid, maxtri7x7_line_1_tvalid, maxtri7x7_line_2_tvalid, 
                            maxtri7x7_line_3_tvalid, maxtri7x7_line_4_tvalid, maxtri7x7_line_5_tvalid, maxtri7x7_line_6_tvalid;
    wire[DATA_WIDTH-1:0]   maxtri7x7_line_0_tdata , maxtri7x7_line_1_tdata , maxtri7x7_line_2_tdata ,
                            maxtri7x7_line_3_tdata , maxtri7x7_line_4_tdata , maxtri7x7_line_5_tdata , maxtri7x7_line_6_tdata ;

    wire                 sobel3x3_tlast     ;
    wire                 sobel3x3_tuser     ;
    wire                 sobel3x3_tvalid    ;
    wire[DATA_WIDTH-1:0] sobel3x3_Gxdata     ;
    wire[DATA_WIDTH-1:0] sobel3x3_Gydata     ;
    wire[DATA_WIDTH-1:0] sobel3x3_tdata     ;
    wire[DATA_WIDTH-1:0] sobel3x3_raw_tdata ; 
    
    wire                 sobel5x5_tlast     ;
    wire                 sobel5x5_tuser     ;
    wire                 sobel5x5_tvalid    ;
    wire[DATA_WIDTH-1:0] sobel5x5_Gxdata     ;
    wire[DATA_WIDTH-1:0] sobel5x5_Gydata     ;
    wire[DATA_WIDTH-1:0] sobel5x5_tdata     ;
    wire[DATA_WIDTH-1:0] sobel5x5_raw_tdata ;  
    
    wire                 sobel7x7_tlast     ;
    wire                 sobel7x7_tuser     ;
    wire                 sobel7x7_tvalid    ;
    wire[DATA_WIDTH-1:0] sobel7x7_Gxdata     ;
    wire[DATA_WIDTH-1:0] sobel7x7_Gydata     ;
    wire[DATA_WIDTH-1:0] sobel7x7_tdata     ;
    wire[DATA_WIDTH-1:0] sobel7x7_raw_tdata ;      
        
         
    
    
     
    assign m_axis_tlast     = (enable == 1'b1)? m_axis_tlast_reg     : s_axis_tlast_dly1  ;
    assign m_axis_tuser     = (enable == 1'b1)? m_axis_tuser_reg     : s_axis_tuser_dly1  ;
    assign m_axis_tvalid    = (enable == 1'b1)? m_axis_tvalid_reg    : s_axis_tvalid_dly1 ;
    assign m_axis_Gxdata    = (enable == 1'b1)? m_axis_Gxdata_reg    : s_axis_tdata_dly1  ;
    assign m_axis_Gydata    = (enable == 1'b1)? m_axis_Gydata_reg    : s_axis_tdata_dly1  ;
    assign m_axis_tdata     = (enable == 1'b1)? m_axis_tdata_reg     : s_axis_tdata_dly1  ;
    assign m_axis_raw_tdata = (enable == 1'b1)? m_axis_raw_tdata_reg : s_axis_tdata_dly1  ;

     always@(posedge pixel_clk)
     begin
     
        s_axis_tlast_dly1 <= s_axis_tlast   ;
        s_axis_tuser_dly1 <= s_axis_tuser   ;
        s_axis_tvalid_dly1<= s_axis_tvalid  ;
        s_axis_tdata_dly1 <= s_axis_tdata   ;
        
     end
     
    maxtri7x7_shift
    #(
        .DATA_WIDTH (DATA_WIDTH),
        .IMG_HEIGHT (IMG_HEIGHT)
    )
    maxtri7x7_shift_i
    (
        .pixel_clk    (pixel_clk         )   ,
        .s_axis_tdata (s_axis_tdata_dly1 )   ,
        .s_axis_tlast (s_axis_tlast_dly1 )   ,
        .s_axis_tuser (s_axis_tuser_dly1 )   ,
        .s_axis_tvalid(s_axis_tvalid_dly1 )   ,
        
        .line_buff_0_tlast (maxtri7x7_line_0_tlast ),
        .line_buff_0_tuser (maxtri7x7_line_0_tuser ),
        .line_buff_0_tvalid(maxtri7x7_line_0_tvalid),
        .line_buff_0_tdata (maxtri7x7_line_0_tdata ), 
        
        .line_buff_1_tlast (maxtri7x7_line_1_tlast ),
        .line_buff_1_tuser (maxtri7x7_line_1_tuser ),
        .line_buff_1_tvalid(maxtri7x7_line_1_tvalid),
        .line_buff_1_tdata (maxtri7x7_line_1_tdata ), 
        
        .line_buff_2_tlast (maxtri7x7_line_2_tlast ),
        .line_buff_2_tuser (maxtri7x7_line_2_tuser ),
        .line_buff_2_tvalid(maxtri7x7_line_2_tvalid),
        .line_buff_2_tdata (maxtri7x7_line_2_tdata ), 
        
        .line_buff_3_tlast (maxtri7x7_line_3_tlast ),
        .line_buff_3_tuser (maxtri7x7_line_3_tuser ),
        .line_buff_3_tvalid(maxtri7x7_line_3_tvalid),
        .line_buff_3_tdata (maxtri7x7_line_3_tdata ), 
        
        .line_buff_4_tlast (maxtri7x7_line_4_tlast ),
        .line_buff_4_tuser (maxtri7x7_line_4_tuser ),
        .line_buff_4_tvalid(maxtri7x7_line_4_tvalid),
        .line_buff_4_tdata (maxtri7x7_line_4_tdata ), 
        
        .line_buff_5_tlast (maxtri7x7_line_5_tlast ),
        .line_buff_5_tuser (maxtri7x7_line_5_tuser ),
        .line_buff_5_tvalid(maxtri7x7_line_5_tvalid),
        .line_buff_5_tdata (maxtri7x7_line_5_tdata ), 
        
        .line_buff_6_tlast (maxtri7x7_line_6_tlast ),
        .line_buff_6_tuser (maxtri7x7_line_6_tuser ),
        .line_buff_6_tvalid(maxtri7x7_line_6_tvalid),
        .line_buff_6_tdata (maxtri7x7_line_6_tdata ) 
    
    );
    
    sobel3x3_algorithm
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    sobel3x3_algorithm_i
    (
        .pixel_clk          (pixel_clk              ),
        .edge_selelct       (edge_selelct           ),
        .threshold          (threshold              ),  
        .s_axis_tlast       (maxtri7x7_line_1_tlast ),
        .s_axis_tuser       (maxtri7x7_line_1_tuser ),
        .s_axis_tvalid      (maxtri7x7_line_1_tvalid),
        .matrix0_tdata      (maxtri7x7_line_0_tdata ),
        .matrix1_tdata      (maxtri7x7_line_1_tdata ),
        .matrix2_tdata      (maxtri7x7_line_2_tdata ),
        .m_axis_tlast       (sobel3x3_tlast         ),
        .m_axis_tuser       (sobel3x3_tuser         ),
        .m_axis_tvalid      (sobel3x3_tvalid        ),
        .m_axis_Gxdata      (sobel3x3_Gxdata        ),
        .m_axis_Gydata      (sobel3x3_Gydata        ),
        .m_axis_tdata       (sobel3x3_tdata         ),
        .m_axis_raw_tdata   (sobel3x3_raw_tdata     )      
    );
    
    
    sobel5x5_algorithm
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    sobel5x5_algorithm_i
    (
        .pixel_clk          (pixel_clk                  ),
        .edge_selelct       (edge_selelct               ),
        .threshold          (threshold                  ),
        .s_axis_tlast       (maxtri7x7_line_2_tlast     ),
        .s_axis_tuser       (maxtri7x7_line_2_tuser     ),
        .s_axis_tvalid      (maxtri7x7_line_2_tvalid    ),
        .matrix0_tdata      (maxtri7x7_line_0_tdata     ),
        .matrix1_tdata      (maxtri7x7_line_1_tdata     ),
        .matrix2_tdata      (maxtri7x7_line_2_tdata     ),
        .matrix3_tdata      (maxtri7x7_line_3_tdata     ),
        .matrix4_tdata      (maxtri7x7_line_4_tdata     ),
        
        .m_axis_tlast       (sobel5x5_tlast             ),
        .m_axis_tuser       (sobel5x5_tuser             ),
        .m_axis_tvalid      (sobel5x5_tvalid            ),
        .m_axis_Gxdata      (sobel5x5_Gxdata        ),
        .m_axis_Gydata      (sobel5x5_Gydata        ),
        .m_axis_tdata       (sobel5x5_tdata             ),
        .m_axis_raw_tdata   (sobel5x5_raw_tdata         )      
    );
    
    
    sobel7x7_algorithm
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    sobel7x7_algorithm_i
    (
        .pixel_clk       (pixel_clk                  ),
        .edge_selelct    (edge_selelct               ),
        .threshold       (threshold                  ),
        .s_axis_tlast    (maxtri7x7_line_3_tlast     ),
        .s_axis_tuser    (maxtri7x7_line_3_tuser     ),
        .s_axis_tvalid   (maxtri7x7_line_3_tvalid    ),
        .matrix0_tdata   (maxtri7x7_line_0_tdata     ),
        .matrix1_tdata   (maxtri7x7_line_1_tdata     ),
        .matrix2_tdata   (maxtri7x7_line_2_tdata     ),
        .matrix3_tdata   (maxtri7x7_line_3_tdata     ),
        .matrix4_tdata   (maxtri7x7_line_4_tdata     ),
        .matrix5_tdata   (maxtri7x7_line_5_tdata     ),
        .matrix6_tdata   (maxtri7x7_line_6_tdata     ),
        .m_axis_tlast    (sobel7x7_tlast             ),
        .m_axis_tuser    (sobel7x7_tuser             ),
        .m_axis_tvalid   (sobel7x7_tvalid            ),
        .m_axis_Gxdata   (sobel7x7_Gxdata        ),
        .m_axis_Gydata   (sobel7x7_Gydata        ),
        .m_axis_tdata    (sobel7x7_tdata             ),
        .m_axis_raw_tdata(sobel7x7_raw_tdata         )      
    );

    
    
    
    always@(posedge pixel_clk)
    begin  
        case(kernel)
            2'b00:
            begin
                m_axis_tlast_reg     <= sobel3x3_tlast     ;
                m_axis_tuser_reg     <= sobel3x3_tuser     ;
                m_axis_tvalid_reg    <= sobel3x3_tvalid    ;
                m_axis_Gxdata_reg    <= sobel3x3_Gxdata    ; 
                m_axis_Gydata_reg    <= sobel3x3_Gydata    ; 
                m_axis_tdata_reg     <= sobel3x3_tdata     ;
                m_axis_raw_tdata_reg <= sobel3x3_raw_tdata ;
            end       
            
            2'b01:
            begin
                m_axis_tlast_reg     <= sobel5x5_tlast     ;
                m_axis_tuser_reg     <= sobel5x5_tuser     ;
                m_axis_tvalid_reg    <= sobel5x5_tvalid    ;
                m_axis_Gxdata_reg    <= sobel5x5_Gxdata     ; 
                m_axis_Gydata_reg    <= sobel5x5_Gydata     ; 
                m_axis_tdata_reg     <= sobel5x5_tdata     ;
                m_axis_raw_tdata_reg <= sobel5x5_raw_tdata ;
            end
            
            2'b10:
            begin
                m_axis_tlast_reg     <= sobel7x7_tlast     ;
                m_axis_tuser_reg     <= sobel7x7_tuser     ;
                m_axis_tvalid_reg    <= sobel7x7_tvalid    ;
                m_axis_Gxdata_reg    <= sobel7x7_Gxdata    ; 
                m_axis_Gydata_reg    <= sobel7x7_Gydata    ; 
                m_axis_tdata_reg     <= sobel7x7_tdata     ;
                m_axis_raw_tdata_reg <= sobel7x7_raw_tdata ;
            end
            default:
            begin
                m_axis_tlast_reg     <= sobel3x3_tlast     ;
                m_axis_tuser_reg     <= sobel3x3_tuser     ;
                m_axis_tvalid_reg    <= sobel3x3_tvalid    ;
                m_axis_Gxdata_reg    <= sobel3x3_Gxdata    ; 
                m_axis_Gydata_reg    <= sobel3x3_Gydata    ; 
                m_axis_tdata_reg     <= sobel3x3_tdata     ;
                m_axis_raw_tdata_reg <= sobel3x3_raw_tdata ;
            
            end
        endcase
    end

 
         
         
     
     
 
endmodule
