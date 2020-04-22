`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/18 10:58:06
// Design Name: 
// Module Name: cmos_sampling
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


module cmos_sampling
    #(
        parameter RAW_WIDTH = 10,
        parameter DATA_WIDTH = 10
    )
    (

       (*mark_debug="true"*)input                       pixel_clk       ,   
       (*mark_debug="true"*)input                       vsync           ,       
       (*mark_debug="true"*)input                       href            ,        
       (*mark_debug="true"*)input[RAW_WIDTH -1 : 0]    data_in          ,
       
       (*mark_debug="true"*)output                      pixel_clk_out   ,
       (*mark_debug="true"*)output                      vsync_out       ,       
       (*mark_debug="true"*)output                      href_out        ,        
       (*mark_debug="true"*)output[DATA_WIDTH -1 : 0]   data_out
    
    );
    
    localparam HL = 2'b10;
    reg                       vsync_dly1  ;       
    reg                       href_dly1   ;        
    reg[RAW_WIDTH -1 : 0]    data_in_dly1;
    
    reg                      vsync_out_reg ;      
    reg                      href_out_reg ;       
    reg[RAW_WIDTH -1 : 0]   data_out_reg ;
    reg[1:0]  href_reg;  
    
    reg[10:0] href_count = 11'd0;

    assign vsync_out = vsync_out_reg;
    assign href_out  = href_out_reg ;
    //assign data_out  = (data_out_reg[RAW_WIDTH -1 : DATA_WIDTH] >= 1)? 8'd255:data_out_reg[DATA_WIDTH - 1:0] ;
    assign data_out  = data_out_reg >> 4;//data_out_reg[9 : 2];
    assign pixel_clk_out = pixel_clk;
    

        
    always@(posedge pixel_clk)
    begin
        vsync_dly1   <=  vsync   ;
        href_dly1    <=  href    ;
        data_in_dly1 <=  data_in ;
        
        vsync_out_reg <= vsync_dly1  ;
        href_out_reg  <= href_dly1   ;
        data_out_reg  <= data_in_dly1;
        
        href_reg <= {href_reg[0],href};
        
    end
    
    always@(posedge pixel_clk)
    begin
        if(vsync_dly1 == 1'b1)
        begin
            href_count <= 11'd0;
        end
        else if(href_reg == HL)
        begin
            href_count <= href_count + 1'b1;
        end
        
    end
    
    
    
    

endmodule
