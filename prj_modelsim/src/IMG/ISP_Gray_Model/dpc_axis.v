`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 10:41:12
// Design Name: 
// Module Name: dpc_axis
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


module dpc_axis
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk,
        input       dpc_en,
        input[9:0]  threshold,
         
        input       s_axis_tlast ,
        input       s_axis_tuser ,
        input       s_axis_tvalid,   
        input[DATA_WIDTH - 1:0]  matrix_data01, 
        input[DATA_WIDTH - 1:0]  matrix_data11, 
        input[DATA_WIDTH - 1:0]  matrix_data21,
        
        output      m_axis_tlast ,
        output      m_axis_tuser ,
        output      m_axis_tvalid ,   
        output[DATA_WIDTH - 1:0] m_axis_tdata
    
    );
    
//    parameter LH = 2'b01;
//    parameter HL = 2'b10;
    localparam LH = 2'b01;
    localparam HL = 2'b10;

//    parameter IMG_WIDTH = 640;
//    parameter IMG_HEIGHT = 480;
    

    reg [DATA_WIDTH - 1:0] matrix_01,matrix_02,matrix_03;
    reg [DATA_WIDTH - 1:0] matrix_11,matrix_12,matrix_13;
    reg [DATA_WIDTH - 1:0] matrix_21,matrix_22,matrix_23;
    reg [DATA_WIDTH - 1:0] matrix_abs01,matrix_abs02,matrix_abs03;
    reg [DATA_WIDTH - 1:0] matrix_abs11,matrix_abs12,matrix_abs13;
    reg [DATA_WIDTH - 1:0] matrix_abs21,matrix_abs22,matrix_abs23;
    reg [9:0]threshold_value = 10'd90;
    reg [11:0]rows_count = 12'd0;
    reg [11:0]cols_count = 12'd0;
    reg[DATA_WIDTH - 1:0] data_DPCed;
    reg[6:0] tvalid_reg;
    reg[6:0] tuser_reg;
    reg[6:0] tlast_reg;
    
    reg cols_dpc_en;
    reg rows_dpc_en;
    reg [DATA_WIDTH - 1:0] dpc_out_reg;
    reg [DATA_WIDTH - 1:0] min_abs1,min_abs2,min_abs3,min_abs4,min_abs5,min_abs6,min_abs7;
    reg [DATA_WIDTH - 1:0] matrix_12_delay1,matrix_12_delay2,matrix_12_delay3;
    reg [DATA_WIDTH - 1:0] matrix_12_delay4,matrix_12_delay5,matrix_12_delay6;   
    
    reg [11:0] data_Aver_tmp;
    reg [DATA_WIDTH - 1:0] data_Aver_delay1;
    reg [DATA_WIDTH - 1:0] data_Aver_delay2;
    reg [DATA_WIDTH - 1:0] data_Aver_delay3; 
    reg tvalid_delay;
    reg tuser_delay;
    reg tlast_delay;  
    reg tvalid_out_reg;
    reg tuser_out_reg ;
    reg tlast_out_reg ;

      
    
    
//   assign vsync_out     = vsync_out_reg   ;
//   assign href_out      = href_out_reg    ;
//   assign data_dpc_out  = dpc_out_reg     ;

    assign m_axis_tlast  = tlast_out_reg;
    assign m_axis_tuser  = tuser_out_reg;
    assign m_axis_tvalid = tvalid_out_reg;    
    assign m_axis_tdata  = dpc_out_reg; 


   //get 3x3 matrix
   always@(posedge pixel_clk)
   begin
       {matrix_01,matrix_02,matrix_03} <= {matrix_02,matrix_03,matrix_data01};
       {matrix_11,matrix_12,matrix_13} <= {matrix_12,matrix_13,matrix_data11};
       {matrix_21,matrix_22,matrix_23} <= {matrix_22,matrix_23,matrix_data21};
   end
          
// -----------------------------dpc part----------------------------------//            
   //get matrix_abs
   always@(posedge pixel_clk)
   begin
   //matrix_abs01
       if(matrix_01 > matrix_12 )
           begin
               matrix_abs01 <=  matrix_01 -  matrix_12;  
           end
       else
           begin
               matrix_abs01 <=  matrix_12 -  matrix_01;  
   
           end
    //matrix_abs02   
       if(matrix_02 > matrix_12 )
           begin
               matrix_abs02 <=  matrix_02 -  matrix_12;  
           end
       else
           begin
               matrix_abs02 <=  matrix_12 -  matrix_02;  
           end
    //matrix_abs03  
       if(matrix_03 > matrix_12 )
           begin
               matrix_abs03 <=  matrix_03 -  matrix_12;  
           end
       else
           begin
               matrix_abs03 <=  matrix_12 -  matrix_03;  
           end
    //--------------------matrix_abs11,matrix_abs12,matrix_abs13--------------------//       
   //matrix_abs11            
       if(matrix_11 > matrix_12 )
               begin
                   matrix_abs11 <=  matrix_11 -  matrix_12;  
               end
           else
               begin
                   matrix_abs11 <=  matrix_12 -  matrix_11;  
       
               end
   //matrix_abs12   
       if(matrix_13 > matrix_12 )
           begin
               matrix_abs13 <=  matrix_13 -  matrix_12;  
           end
       else
           begin
               matrix_abs13 <=  matrix_12 -  matrix_13;  
           end
     //-------------------matrix_abs21,matrix_abs22,matrix_abs23---------------------//      
   //matrix_abs21
       if(matrix_21 > matrix_12 )
           begin
               matrix_abs21 <=  matrix_21 -  matrix_12;  
           end
       else
           begin
               matrix_abs21 <=  matrix_12 -  matrix_21;  
   
           end
    //matrix_abs22   
       if(matrix_22 > matrix_12 )
           begin
               matrix_abs22 <=  matrix_22 -  matrix_12;  
           end
       else
           begin
               matrix_abs22 <=  matrix_12 -  matrix_22;  
           end
    //matrix_abs23  
       if(matrix_23 > matrix_12 )
           begin
               matrix_abs23 <=  matrix_23 -  matrix_12;  
           end
       else
           begin
               matrix_abs23 <=  matrix_12 -  matrix_23;  
           end       
   end
   
   //get min_abs(min_abs7)
   always@(posedge pixel_clk)
   begin
       if(matrix_abs01 > matrix_abs02)
       begin
           min_abs1 <= matrix_abs02;  
       end  
       else
       begin
           min_abs1 <=  matrix_abs01;
       end
           
       if(matrix_abs03 > matrix_abs11)
       begin
           min_abs2 <= matrix_abs11;  
       end  
       else
       begin
           min_abs2 <=  matrix_abs03;
       end
       
       if(matrix_abs13 > matrix_abs21)
       begin
           min_abs3 <= matrix_abs21;  
       end  
       else
       begin
           min_abs3 <=  matrix_abs13;
       end
       
       if(matrix_abs22 > matrix_abs23)
       begin
           min_abs4 <= matrix_abs23;  
       end  
       else
       begin
           min_abs4 <=  matrix_abs22;
       end
       
   end
   
   always@(posedge pixel_clk)
   begin
       if(min_abs1 > min_abs2)
       begin
           min_abs5 <= min_abs2;
       end
       else
       begin
           min_abs5 <= min_abs1;
       end
       
       if(min_abs3 > min_abs4)
       begin
           min_abs6 <= min_abs4;
       end
       else
       begin
           min_abs6 <= min_abs3;
       end
       
   end
   
   always@(posedge pixel_clk)
   begin
       if(min_abs5 > min_abs6)
       begin
           min_abs7 <= min_abs6;
       end
       else
       begin
           min_abs7 <= min_abs5;
       end
   end
   
   //get matrix_02,matrix_11,matrix_13,matrix_22  Average
   always@(posedge pixel_clk)
   begin
       data_Aver_tmp    <= matrix_02 + matrix_11 + matrix_13 + matrix_22;
       data_Aver_delay1 <= (data_Aver_tmp>>2);
       data_Aver_delay2 <= data_Aver_delay1;
       data_Aver_delay3 <= data_Aver_delay2;
   end
   
   // get matrix_12 delay
   always@(posedge pixel_clk)
   begin
       matrix_12_delay1 <= matrix_12 ;
       matrix_12_delay2 <= matrix_12_delay1 ;
       matrix_12_delay3 <= matrix_12_delay2 ;
       matrix_12_delay4 <= matrix_12_delay3 ; 
       matrix_12_delay5 <= matrix_12_delay4 ;
       matrix_12_delay6 <= matrix_12_delay5 ;         
   end
   
   //get dpc data
   always@(posedge pixel_clk)
   begin
       if(min_abs7 > threshold_value)
           begin
               data_DPCed <=  data_Aver_delay3; 
           end
       else
           begin
               data_DPCed <=  matrix_12_delay4;   
           end
   end
   
   
   //data out control
   always@(posedge pixel_clk)
   begin
//       vsync_out_reg <= tuser_delay;
//       href_out_reg  <= tvalid_delay;
       
       tvalid_out_reg <= tvalid_delay;
       tuser_out_reg  <= tuser_delay;
       tlast_out_reg  <= tlast_delay;
       
       
       
       if((cols_dpc_en == 1'b1) && (rows_dpc_en == 1'b1) && (dpc_en == 1'b1))
           begin
               dpc_out_reg <= data_DPCed;    
           end
       else
           begin
               dpc_out_reg <= matrix_12_delay5;    
           end
   end
   
   
   //delay control
   always@(posedge pixel_clk)
   begin
       threshold_value <= threshold;
       
       tvalid_reg  <= {tvalid_reg[5:0],s_axis_tvalid};
       tvalid_delay<= tvalid_reg[5]; 
       
       tuser_reg   <= {tuser_reg[5:0],s_axis_tuser};
       tuser_delay <= tuser_reg[5]; 
       
       tlast_reg   <= {tlast_reg[5:0],s_axis_tlast};
       tlast_delay <= tlast_reg[5]; 
       
       
       
   end
   
   // get cols
   always@(posedge pixel_clk)
   begin
       if(tvalid_delay == 1'b1)
           begin
               cols_count <= cols_count + 1'b1;
           end
       else
           begin
               cols_count <= 12'd0;
           end
   end
   
   //get rows;
   always@(posedge pixel_clk)
   begin
       if(tuser_delay == 1'b1)
       begin
           rows_count <= 12'd0;
       end
       else
           begin
               if(tvalid_reg[6:5] == HL)
               begin
                   rows_count <= rows_count + 1'b1;    
               end
               else
               begin
                    rows_count <= rows_count;   
               end
           end
   end
   
   //get cols_dpc_en
   always@(posedge pixel_clk)
   begin
       if(tvalid_delay == 1'b1 && (cols_count < IMG_WIDTH - 2))
           begin
               cols_dpc_en <= 1'b1;
           end
       else
           begin
               cols_dpc_en <= 1'b0;
           end
   end
   
   //get rows_dpc_en
   always@(posedge pixel_clk)
   begin
       if((rows_count > 11'd0)&&(rows_count < IMG_HEIGHT - 1'b1))
           begin
               rows_dpc_en <= 1'b1;    
           end
       else
           begin
               rows_dpc_en <= 1'b0;    
           end
   end

endmodule
