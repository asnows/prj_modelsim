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


module read_file
#(
    parameter DATA_WIDTH = 8,
    parameter FILE_SIZE  = 307200,
    parameter FILE_NAME  = "E:/WorkSpace/project/FPGA/prj_ip/prj_ip/prj_ip.srcs/sim_1/new/srcImg_640x480.bin"
    
)
(
    input clk,  
    input read_en,
    
    output data_valid,
    output[DATA_WIDTH - 1 :0] data_out
);

    reg [31:0] read_count = 32'd0;
    reg[7:0] mem[0:FILE_SIZE - 1];
    reg[7:0] rd_data;
    reg valid_reg;
    
    integer     data_rd;
    
    assign data_out = rd_data;
    assign data_valid = valid_reg;

    initial 
    begin
     data_rd = $fopen(FILE_NAME,"rb"); 
    end
    

    always@(posedge clk)
    begin
        if(read_en)
        begin
            if(read_count < FILE_SIZE)
            begin
                 read_count <= read_count +1'b1; 
                 $fread(rd_data, data_rd);
            end
            else
            begin
                read_count <= 32'd0;
            end 
        end    
    end
    
    always@(posedge clk)
    begin
        valid_reg <= read_en;
    end


       
endmodule
