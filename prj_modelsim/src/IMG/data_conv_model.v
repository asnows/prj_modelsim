`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 14:54:47
// Design Name: 
// Module Name: data_conv_model
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
`define DATATO3840
//////////////////////////////////////////////////////////////////////////////////


module data_conv_model
#(
  parameter DATA_WIDTH = 8,
  parameter IMG_WIDTH  = 640
)
(

    input       m_aclk          ,
    input       s_aclk          ,
    input       s_aresetn       ,
    input       s_axis_tvalid   ,
    output      s_axis_tready   ,
    input[DATA_WIDTH - 1:0]  s_axis_tdata    ,
    input       s_axis_tlast    ,
    input       s_axis_tuser    ,
    input[3:0]  debug_cmd       ,
    
    (*mark_debug="true"*)output      m_axis_tvalid   ,
    (*mark_debug="true"*)input       m_axis_tready   ,
    (*mark_debug="true"*)output[DATA_WIDTH - 1:0] m_axis_tdata    ,
    (*mark_debug="true"*)output      m_axis_tlast    ,
    (*mark_debug="true"*)output      m_axis_tuser    
 );
    
    reg        s_axis_tvalid_dly  ;
    reg[DATA_WIDTH - 1:0]   s_axis_tdata_dly   ;
    reg        s_axis_tlast_dly   ;
    reg        s_axis_tuser_dly   ;
    reg        s_axis_tready_reg;
    
    reg         m_axis_tready_dly  ;
    reg         m_axis_tvalid_reg  ;
    reg[DATA_WIDTH - 1:0]   m_axis_tdata_reg   ; 
    reg         m_axis_tlast_reg   ; 
    reg         m_axis_tuser_reg   ; 
    
    
    wire        data_put_together_tlast    ;
    wire        data_put_together_tready   ;
    wire        data_put_together_tuser    ;
    wire        data_put_together_tvalid   ;
    wire[DATA_WIDTH - 1:0]   data_put_together_tdata    ; 
    
    reg[DATA_WIDTH - 1:0 ]fifo_0_s_axis_tdata ;
    reg      fifo_0_s_axis_tlast ;
    wire     fifo_0_s_axis_tready;
    reg      fifo_0_s_axis_tuser ;
    reg      fifo_0_s_axis_tvalid;
    
    wire[DATA_WIDTH - 1:0 ]fifo_0_m_axis_tdata ;
    wire      fifo_0_m_axis_tlast ;
    wire      fifo_0_m_axis_tready;
    wire      fifo_0_m_axis_tuser ;
    wire      fifo_0_m_axis_tvalid;
    
    wire[31:0]dconv_m_axis_tdata ;
    wire      dconv_m_axis_tlast ;
    wire      dconv_m_axis_tready;
    wire[3:0 ]dconv_m_axis_tkeep ;
    wire      dconv_m_axis_tuser ;
    wire      dconv_m_axis_tvalid;
    
   assign  m_axis_tvalid = m_axis_tvalid_reg;
   assign  m_axis_tdata  = m_axis_tdata_reg;
   assign  m_axis_tlast  = m_axis_tlast_reg;  
   assign  m_axis_tuser  = m_axis_tuser_reg;
   
   assign s_axis_tready = fifo_0_s_axis_tready;
   assign dconv_m_axis_tready = m_axis_tready;
   
   
    
    always@(posedge s_aclk)
    begin
    
        s_axis_tvalid_dly <= s_axis_tvalid;
        s_axis_tdata_dly  <= s_axis_tdata ;
        s_axis_tlast_dly  <= s_axis_tlast ;
        s_axis_tuser_dly  <= s_axis_tuser ;
        s_axis_tready_reg <= fifo_0_s_axis_tready;
    end
    
    data_put_together
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH(IMG_WIDTH)
    )
    data_put_together_i
    (
    .pixel_clk    (s_aclk            )   , 
    .s_axis_tdata (s_axis_tdata_dly )   ,
    .s_axis_tlast (s_axis_tlast_dly )   ,
    .s_axis_tuser (s_axis_tuser_dly )   ,
    .s_axis_tvalid(s_axis_tvalid_dly )   ,
    
    .m_axis_tlast ( data_put_together_tlast )   ,
    .m_axis_tuser ( data_put_together_tuser )   ,
    .m_axis_tvalid( data_put_together_tvalid)   ,
    .m_axis_tdata ( data_put_together_tdata )   
    
    );    
    
//    always@(posedge s_aclk)
//    begin
//        case(debug_cmd)
//        4'b0000:
//        begin
//            fifo_0_s_axis_tvalid =  s_axis_tvalid_dly;
//            fifo_0_s_axis_tdata  =  s_axis_tdata_dly ;
//            fifo_0_s_axis_tlast  =  s_axis_tlast_dly ;
//            fifo_0_s_axis_tuser  =  s_axis_tuser_dly ;
//        end
//        4'b0001:
//        begin
//            fifo_0_s_axis_tvalid =  data_put_together_tvalid;
//            fifo_0_s_axis_tdata  =  data_put_together_tdata ;
//            fifo_0_s_axis_tlast  =  data_put_together_tlast ;
//            fifo_0_s_axis_tuser  =  data_put_together_tuser ;     
//        end
//        default:
//        begin
//            fifo_0_s_axis_tvalid =  s_axis_tvalid_dly;
//            fifo_0_s_axis_tdata  =  s_axis_tdata_dly ;
//            fifo_0_s_axis_tlast  =  s_axis_tlast_dly ;
//            fifo_0_s_axis_tuser  =  s_axis_tuser_dly ;
//        end
//        endcase
        
        
//    end
    

    fifo_generator_0 fifo_0_i
    (
        .m_aclk       (m_aclk           ),
        .s_aclk       (s_aclk           ),
        .s_aresetn    (s_aresetn        ),
//        .s_axis_tvalid(fifo_0_s_axis_tvalid),
//        .s_axis_tready(fifo_0_s_axis_tready),
//        .s_axis_tdata (fifo_0_s_axis_tdata ),
//        .s_axis_tlast (fifo_0_s_axis_tlast ),
//        .s_axis_tuser (fifo_0_s_axis_tuser ), 
        
        .s_axis_tvalid(data_put_together_tvalid),
        .s_axis_tready(fifo_0_s_axis_tready),
        .s_axis_tdata (data_put_together_tdata ),
        .s_axis_tlast (data_put_together_tlast ),
        .s_axis_tuser (data_put_together_tuser ), 
        
        
        .m_axis_tvalid(fifo_0_m_axis_tvalid),
        //.m_axis_tready(fifo_0_m_axis_tready),     
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata (fifo_0_m_axis_tdata ),
        .m_axis_tlast (fifo_0_m_axis_tlast ),
        .m_axis_tuser (fifo_0_m_axis_tuser )
    ); 
    
//    axis_dwidth_converter_0 dconv_i
//    (
//        .aclk         (m_aclk              ),
//        .aresetn      (s_aresetn           ),
//        .s_axis_tvalid(fifo_0_m_axis_tvalid),
//        .s_axis_tready(fifo_0_m_axis_tready),
//        .s_axis_tdata (fifo_0_m_axis_tdata ),
//        .s_axis_tlast (fifo_0_m_axis_tlast ),
//        .s_axis_tuser (fifo_0_m_axis_tuser ), 
              
//        .m_axis_tvalid(dconv_m_axis_tvalid ),
//        .m_axis_tready(m_axis_tready_dly   ),
//        .m_axis_tdata (dconv_m_axis_tdata  ),
//        .m_axis_tkeep (dconv_m_axis_tkeep  ),
//        .m_axis_tlast (dconv_m_axis_tlast  ),
//        .m_axis_tuser (dconv_m_axis_tuser  )
//    );
    
    always@(posedge m_aclk)
    begin
//        m_axis_tvalid_reg <= dconv_m_axis_tvalid ;
//        m_axis_tdata_reg  <= dconv_m_axis_tdata ;
//        m_axis_tlast_reg  <= dconv_m_axis_tlast  ;
//        m_axis_tuser_reg  <= dconv_m_axis_tuser  ;
//        m_axis_tready_dly <= m_axis_tready ;
        
        m_axis_tvalid_reg <= fifo_0_m_axis_tvalid ;
        m_axis_tdata_reg  <= fifo_0_m_axis_tdata ;
        m_axis_tlast_reg  <= fifo_0_m_axis_tlast  ;
        m_axis_tuser_reg  <= fifo_0_m_axis_tuser  ;
        //m_axis_tready_dly <= m_axis_tready ;
        
        
    end
    

endmodule
