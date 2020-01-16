`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/21 10:45:25
// Design Name: 
// Module Name: read_file
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


module write_file
#(
    parameter DATA_WIDTH = 8,
    parameter FILE_SIZE  = 307200,
    parameter FILE_NAME  = "E:/WorkSpace/project/FPGA/prj_ip/prj_ip/prj_ip.srcs/sim_1/new/debug.raw"
)
(
    input clk,  
    input write_en,
    input stop_en,
    input [DATA_WIDTH - 1 :0] data_in,
    output done

);

    reg [31:0] write_count = 32'd0;
    reg done_reg = 1'b0;
    
    integer     data_wr0;
    assign done = done_reg;
    
    initial 
    begin
    //使用 wb+ 解决在遇到 0x0a时，前面插入0x0d的问题
     data_wr0 = $fopen(FILE_NAME,"wb+"); 
     write_count <= 32'd0; 
     done_reg <= 1'b0;
    end
    
    
    always@(posedge clk)
    begin
        if(write_en)
        begin
            if(write_count < FILE_SIZE)
            begin
                write_count <= write_count +1'b1; 
//                $fwrite(data_wr0,"%c",data_in); 
//                $fwrite(data_wr0,"%c",data_in[15:8]);
//                $fwrite(data_wr0,"%c",data_in[23:16]);
//                $fwrite(data_wr0,"%c",data_in[31:24]);
                case(DATA_WIDTH)
                8'd8:
                begin
                    $fwrite(data_wr0,"%c",data_in); 
                end
                
                8'd16:
                begin
                    $fwrite(data_wr0,"%c",data_in[7:0]); 
                    $fwrite(data_wr0,"%c",data_in[15:8]);               
                end
                
                8'd32:
                begin
                    $fwrite(data_wr0,"%c",data_in[7:0]); 
                    $fwrite(data_wr0,"%c",data_in[15:8]);
                    $fwrite(data_wr0,"%c",data_in[23:16]);
                    $fwrite(data_wr0,"%c",data_in[31:24]);

                end
                
                default:;
                endcase
                
                $fflush(data_wr0); 
            end          
            
        end    
    end


    always@(posedge clk)
    begin
        if(write_count == FILE_SIZE)
        begin
             $fclose(data_wr0);
             done_reg <= 1'b1;
             if(stop_en == 1'b1)
             begin
                $stop;
             end
            
        end
    end


       
endmodule
