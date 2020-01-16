`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/22 14:05:53
// Design Name: 
// Module Name: disp_maxtri
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


module disp_maxtri
#(
    parameter X = 1,
    parameter Y = 1,
    parameter KERNAL = 3,
    parameter DATA_WIDTH = 8,
    parameter IMG_WIDTH = 640,
    parameter IMG_HEIGHT = 480,
    parameter FILE_NAME  = "E:/WorkSpace/project/FPGA/prj_ip/prj_ip/prj_ip.srcs/sim_1/new/debug.raw"

)
(
    input                   s_axis_clk      ,
    input                   s_axis_tlast    ,
    input                   s_axis_tuser    ,
    input                   s_axis_tvalid   ,        
    input[DATA_WIDTH-1:0]   s_axis_tdata    
     
);

     localparam  ROWS_START = Y - KERNAL/2;
     localparam  ROWS_END = ROWS_START + KERNAL;  
     localparam  COLS_START = X - KERNAL/2;
     localparam  COLS_END = COLS_START + KERNAL;
     
     reg[11:0] rows_counts = 12'd0;
     reg[11:0] cols_counts = 12'd0;
     
     reg s_axis_tlast_dly;
     integer     data_wr0;
     
     integer cunt = 0;
     
    initial 
     begin
     //使用 wb+ 解决在遇到 0x0a时，前面插入0x0d的问题
      data_wr0 = $fopen(FILE_NAME,"wb+"); 
     end
     
     
     
    always@(posedge s_axis_clk)
    begin
        s_axis_tlast_dly <= s_axis_tlast;      
    end
    
    
    always@(posedge s_axis_clk)
    begin
        if(s_axis_tvalid)
        begin
             if(cols_counts < (IMG_WIDTH - 1))
             begin
                cols_counts <= cols_counts + 1'b1;
             end
             else
             begin
                cols_counts <= 12'd0;
             end
        end
    end
    
    always@(posedge s_axis_clk)
    begin
        if(s_axis_tuser)
        begin
            rows_counts <= 12'd0;    
        end
        else
        begin
            if(~s_axis_tlast_dly &s_axis_tlast)
            begin
                rows_counts <= rows_counts + 1'b1;
            end
        end
    end
    
    always@(posedge s_axis_clk)
    begin
        if((ROWS_START <= rows_counts) && (rows_counts < ROWS_END))
        begin
            if((COLS_START <= cols_counts) && (cols_counts < COLS_END) )
            begin
                //$fwrite(data_wr0,"%c",data_in);  
            
//                $write("%h  ", s_axis_tdata); 
                if(cols_counts == COLS_END - 1)
                begin
                    //$write("\n  ");  
                    $fwrite(data_wr0,"%h \n",s_axis_tdata); 
                    
                end
                else
                begin
                    $fwrite(data_wr0,"%h ",s_axis_tdata);  
                  
                end 
                
                  
            end
        end
        
        
        if(rows_counts == ROWS_END )
        begin
             $fclose(data_wr0);
        end
    end
    
    
    
    
endmodule
