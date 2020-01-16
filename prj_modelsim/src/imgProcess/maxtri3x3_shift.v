`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/29 11:00:59
// Design Name: 
// Module Name: maxtri7x7_shift
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
`define  USE_6FIFO
//`define  FIFO_MAXTRIX
//`define  USE_6SHIFT
//////////////////////////////////////////////////////////////////////////////////


module maxtri3x3_shift
    #(
        parameter DATA_WIDTH = 8,
        parameter IMG_HEIGHT = 480
    )
    (
        //input                   vsync           ,
		input					resetn,
        input                   s_axis_aclk     ,
        input[DATA_WIDTH-1:0]   s_axis_tdata    ,
        input                   s_axis_tlast    ,
        input                   s_axis_tuser    ,
        input                   s_axis_tvalid   ,
        output                  s_axis_tready   ,
        
        output                  m_axis_line_buff_0_tlast    ,
        output                  m_axis_line_buff_0_tuser    ,
        output                  m_axis_line_buff_0_tvalid   ,
        output[DATA_WIDTH-1:0]  m_axis_line_buff_0_tdata, 
        
        output                  m_axis_line_buff_1_tlast    ,
        output                  m_axis_line_buff_1_tuser    ,
        output                  m_axis_line_buff_1_tvalid   ,
        output[DATA_WIDTH-1:0]  m_axis_line_buff_1_tdata, 
        
        output                  m_axis_line_buff_2_tlast    ,
        output                  m_axis_line_buff_2_tuser    ,
        output                  m_axis_line_buff_2_tvalid   ,
        output[DATA_WIDTH-1:0]  m_axis_line_buff_2_tdata
        
        
    );
    
    localparam HL = 2'b10;
    
    reg[DATA_WIDTH-1:0] s_axis_tdata_dly1 , s_axis_tdata_dly2 ,s_axis_tdata_dly3 ,s_axis_tdata_dly4 ;
    (*mark_debug="true"*)reg                 s_axis_tlast_dly1 , s_axis_tlast_dly2 ,s_axis_tlast_dly3 ,s_axis_tlast_dly4 ;
    (*mark_debug="true"*)reg                 s_axis_tuser_dly1 , s_axis_tuser_dly2 ,s_axis_tuser_dly3 ,s_axis_tuser_dly4 ;
    (*mark_debug="true"*)reg                 s_axis_tvalid_dly1, s_axis_tvalid_dly2,s_axis_tvalid_dly3,s_axis_tvalid_dly4;
    
    reg[DATA_WIDTH-1:0]  line_buff_0_tdata_reg ,line_buff_1_tdata_reg ,line_buff_2_tdata_reg ;
                         //line_buff_3_tdata_reg ,line_buff_4_tdata_reg ,line_buff_5_tdata_reg ,line_buff_6_tdata_reg  ;
    reg                  line_buff_0_tlast_reg ,line_buff_1_tlast_reg ,line_buff_2_tlast_reg ;
                         //line_buff_3_tlast_reg ,line_buff_4_tlast_reg ,line_buff_5_tlast_reg ,line_buff_6_tlast_reg  ;
    reg                  line_buff_0_tuser_reg ,line_buff_1_tuser_reg ,line_buff_2_tuser_reg ;
                         //line_buff_3_tuser_reg ,line_buff_4_tuser_reg ,line_buff_5_tuser_reg ,line_buff_6_tuser_reg  ;
    reg                  line_buff_0_tvalid_reg,line_buff_1_tvalid_reg,line_buff_2_tvalid_reg;
                         //line_buff_3_tvalid_reg,line_buff_4_tvalid_reg,line_buff_5_tvalid_reg,line_buff_6_tvalid_reg ;  
    
    (*mark_debug="true"*)reg[11:0] line_count = 12'd0; 
    reg tlast_reg;    
    reg[11:0] compelet_count = 12'd0;
    reg line_buff_2_tlast_rise = 1'b0;  
    reg compelet_reset;
    wire srst_reset;
    
    reg fifo_1_reset;
    reg fifo_2_reset;
    wire srst_1_reset;
    wire srst_2_reset;
    
    
    wire[DATA_WIDTH + 2:0] line_buff_dout_1 ;
    wire[DATA_WIDTH + 2:0] line_buff_dout_2 ;
    
    (*mark_debug="true"*)reg        line_buff_1_rd;
    (*mark_debug="true"*)reg        line_buff_2_rd;
    
    (*mark_debug="true"*)reg        line_buff_1_wr;
    (*mark_debug="true"*)reg        line_buff_2_wr;
    
    reg        line_buff_1_wr_ctrl,line_buff_1_rd_ctrl;
    reg        line_buff_2_wr_ctrl,line_buff_2_rd_ctrl;
          
    assign s_axis_tready = 1'b1;
   //out connect
    assign m_axis_line_buff_0_tlast  = line_buff_0_tlast_reg  ;
    assign m_axis_line_buff_0_tuser  = line_buff_0_tuser_reg  ;
    assign m_axis_line_buff_0_tvalid = line_buff_0_tvalid_reg ;
    assign m_axis_line_buff_0_tdata  = line_buff_0_tdata_reg  ;
    
    assign m_axis_line_buff_1_tlast  = line_buff_1_tlast_reg  ;
    assign m_axis_line_buff_1_tuser  = (line_count < IMG_HEIGHT )? (line_buff_1_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_1_tuser_reg  ;
    assign m_axis_line_buff_1_tvalid = (line_count < IMG_HEIGHT )? (line_buff_1_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_1_tvalid_reg ;
    assign m_axis_line_buff_1_tdata  = line_buff_1_tdata_reg  ;
    
    
    assign m_axis_line_buff_2_tlast  = line_buff_2_tlast_reg  ;
    assign m_axis_line_buff_2_tuser  = (line_count < IMG_HEIGHT )? (line_buff_2_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_2_tuser_reg  ;
    assign m_axis_line_buff_2_tvalid = (line_count < IMG_HEIGHT )? (line_buff_2_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_2_tvalid_reg ;
    assign m_axis_line_buff_2_tdata  = line_buff_2_tdata_reg  ;
    
  
    
    
    always@(posedge s_axis_aclk )
    begin
        s_axis_tlast_dly1 <= s_axis_tlast ;
        s_axis_tuser_dly1 <= s_axis_tuser ;
        s_axis_tvalid_dly1<= s_axis_tvalid;
        s_axis_tdata_dly1 <= s_axis_tdata ;
        
        s_axis_tlast_dly2 <= s_axis_tlast_dly1 ;
        s_axis_tuser_dly2 <= s_axis_tuser_dly1 ;
        s_axis_tvalid_dly2<= s_axis_tvalid_dly1;
        s_axis_tdata_dly2 <= s_axis_tdata_dly1 ;
        
        s_axis_tlast_dly3  <= s_axis_tlast_dly2  ;
        s_axis_tuser_dly3  <= s_axis_tuser_dly2  ;
        s_axis_tvalid_dly3 <= s_axis_tvalid_dly2 ;
        s_axis_tdata_dly3  <= s_axis_tdata_dly2  ;
        
        s_axis_tlast_dly4  <= s_axis_tlast_dly3  ;
        s_axis_tuser_dly4  <= s_axis_tuser_dly3  ;
        s_axis_tvalid_dly4 <= s_axis_tvalid_dly3 ;
        s_axis_tdata_dly4  <= s_axis_tdata_dly3  ;
        
        
        
    end
    

    always@(posedge s_axis_aclk)
    begin
        tlast_reg <= s_axis_tlast_dly1;
        line_buff_2_tlast_rise <= line_buff_2_tlast_reg;
    end
    
    always@(posedge s_axis_aclk)
    begin
        if(s_axis_tuser)
        begin
            line_count <= 12'd0;    
        end
        else
        begin
            if(~tlast_reg & s_axis_tlast_dly1 )
            begin
                line_count <= line_count + 1'b1;    
            end
            else
            begin
                line_count <= line_count;
            end
        end
    end
    
    always@(posedge s_axis_aclk)
    begin
        if(s_axis_tuser)
        begin
            compelet_count <= 12'd0;
        end
        else
        begin
            if(~line_buff_2_tlast_rise & line_buff_2_tlast_reg)
            begin
                compelet_count <= compelet_count + 1'b1;    
            end
            else
            begin
                compelet_count <= compelet_count; 
            end                  
        end
        
    end
    
//    always@(posedge s_axis_aclk)
//    begin
//        if(compelet_count == (IMG_HEIGHT-1))
//        begin
//            compelet_reset <= line_buff_2_tlast_reg;   // 最后一行的last 复位整个FIFO 
//        end
//        else
//        begin
//            compelet_reset <= 1'b0; 
//        end 
//    end
    
    always@(*)
    begin
        case(compelet_count)
            (IMG_HEIGHT-2):
            begin
                fifo_1_reset <= line_buff_1_tlast_reg;
                fifo_2_reset <= 1'b0;           
            end
            
            (IMG_HEIGHT-1):
            begin
                fifo_1_reset <= 1'b0;
                fifo_2_reset <= line_buff_2_tlast_reg;           
            
            end
            
            default:
            begin
                fifo_1_reset <= 1'b0;
                fifo_2_reset <= 1'b0;           
            
            end
            
                
        endcase
    end
    
    
    
    
    
    always@(*)
    begin
   
       if((line_count == 12'd0) || (compelet_count == IMG_HEIGHT))
       begin
           line_buff_1_rd <= 1'b0; 
           line_buff_2_rd <= 1'b0;
       end
       else if(line_count == 12'd1)
       begin
           line_buff_1_rd <= s_axis_tvalid_dly1; 
           line_buff_2_rd <= 1'b0;
       end
       else if((12'd1 < line_count)&&(line_count < (IMG_HEIGHT)))
       begin
           line_buff_1_rd <= s_axis_tvalid_dly1; 
           line_buff_2_rd <= s_axis_tvalid_dly1;
       end
       else if(line_count == (IMG_HEIGHT))
       begin
           line_buff_1_rd <= 1'b1; 
           line_buff_2_rd <= 1'b1;
       end
       else
       begin
           line_buff_1_rd <= 1'b0;//line_buff_1_rd; 
           line_buff_2_rd <= 1'b0;//line_buff_2_rd;
       end
       
    end
    
    
    always@(posedge s_axis_aclk)
    begin
        line_buff_2_wr <= line_buff_1_rd;
               
    end
    
    

   // assign srst_1_reset =  s_axis_tuser | fifo_1_reset;
   // assign srst_2_reset =  s_axis_tuser | fifo_2_reset;
   
   assign srst_1_reset =  ~resetn;
   assign srst_2_reset =  ~resetn;

    
    fifo_maxtrix line_buff_1
    (
       .clk   (s_axis_aclk     ),
       .srst  (srst_1_reset  ),
       .din   ({s_axis_tlast_dly1,s_axis_tuser_dly1,s_axis_tvalid_dly1,s_axis_tdata_dly1}),
       .wr_en (s_axis_tvalid_dly1),
       .rd_en (line_buff_1_rd ),
       .dout  (line_buff_dout_1),
       .full (),
       .empty ()
    );
    
    
    fifo_maxtrix line_buff_2
    (
       .clk   (s_axis_aclk     ),
       .srst  (srst_2_reset  ),
       .din   (line_buff_dout_1),
       .wr_en (line_buff_2_wr ),
       .rd_en (line_buff_2_rd ),
       .dout  (line_buff_dout_2),
       .full (),
       .empty ()
    );
    
    
  
    always@(*)
    begin    
       
       
       line_buff_0_tlast_reg <= s_axis_tlast_dly2 ;
       line_buff_0_tuser_reg <= s_axis_tuser_dly2 ;
       line_buff_0_tvalid_reg<= s_axis_tvalid_dly2;
       line_buff_0_tdata_reg <= s_axis_tdata_dly2 ;       
       
       
       line_buff_1_tlast_reg <= line_buff_dout_1[DATA_WIDTH + 2];   
       line_buff_1_tuser_reg <= line_buff_dout_1[DATA_WIDTH + 1];   
       line_buff_1_tvalid_reg<= line_buff_dout_1[DATA_WIDTH    ];   
       line_buff_1_tdata_reg <= line_buff_dout_1[DATA_WIDTH - 1:0]; 
       
       line_buff_2_tlast_reg <= line_buff_dout_2[DATA_WIDTH + 2];   
       line_buff_2_tuser_reg <= line_buff_dout_2[DATA_WIDTH + 1];   
       line_buff_2_tvalid_reg<= line_buff_dout_2[DATA_WIDTH    ];   
       line_buff_2_tdata_reg <= line_buff_dout_2[DATA_WIDTH - 1:0]; 
        
    end




    
    
    


endmodule
