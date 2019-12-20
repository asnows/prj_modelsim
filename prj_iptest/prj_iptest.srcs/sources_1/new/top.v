`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 20:14:39
// Design Name: 
// Module Name: top
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


module top(
    input clrl_refclk ,
    input reset ,
    input clkin_p    ,
    input clkin_n    ,
    input tx_clkdiv     ,
    input[3:0] datain_p,
    input[3:0] datain_n,
    output dataout_p


    );
    
    
    reg dataout_p_reg;
    wire [7:0] rx_data ; 
    assign dataout_p = dataout_p_reg;
    
    
    lvds lvds_i
    (
        .clrl_refclk(clrl_refclk),
        .reset(reset),
        .bitslip_en(1'b1),
        .bit_align_en(1'b1),
        .rx_clkin_p    (clkin_p),
        .rx_clkin_n    (clkin_n),
        .tx_clkdiv    (1'b1) ,
        .datain_p(datain_p[0]),
        .datain_n(datain_n[0]),
        .tx_data(10'd0) ,
        
        .dataout_p(),
        .dataout_n(),
        .rx_data  (rx_data)
               
    );
    
    
    
    always@(posedge clrl_refclk)
    begin
        dataout_p_reg <= (&rx_data);
    end
     
    
endmodule
