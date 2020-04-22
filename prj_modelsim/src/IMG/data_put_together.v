`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 08:37:15
// Design Name: 
// Module Name: data_put_together
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


module data_put_together
    #(
        parameter DATA_WIDTH = 8,
        parameter IMG_WIDTH  = 640
    )
    (
        input       pixel_clk       ,
        input[DATA_WIDTH-1:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[DATA_WIDTH-1:0] m_axis_tdata    
    
     );
     
     localparam WIDTH = (30720/DATA_WIDTH);// 30720 = 3840*8
     (*dont_touch = "ture"*)reg[DATA_WIDTH-1:0] s_axis_tdata_dly1 ;
     (*dont_touch = "ture"*)reg                 s_axis_tlast_dly1 ;
     (*dont_touch = "ture"*)reg                 s_axis_tuser_dly1 ;
     (*dont_touch = "ture"*)reg                 s_axis_tvalid_dly1;
     (*dont_touch = "ture"*)reg                 m_axis_tlast_reg ;
     (*dont_touch = "ture"*)reg                 m_axis_tuser_reg ;
     (*dont_touch = "ture"*)reg                 m_axis_tvalid_reg;
     (*dont_touch = "ture"*)reg[DATA_WIDTH-1:0] m_axis_tdata_reg ;
     (*dont_touch = "ture"*)reg tlast_reg = 1'b0;
     (*dont_touch = "ture"*)reg [11:0] pixels_count = 12'd0;
     
     assign m_axis_tlast  = m_axis_tlast_reg ;
     assign m_axis_tuser  = m_axis_tuser_reg ;
     assign m_axis_tvalid = m_axis_tvalid_reg;  
     assign m_axis_tdata  = m_axis_tdata_reg ;
     
     always@(posedge pixel_clk)
     begin
         s_axis_tdata_dly1  <= s_axis_tdata ;
         s_axis_tlast_dly1  <= s_axis_tlast ;
         s_axis_tuser_dly1  <= s_axis_tuser ;
         s_axis_tvalid_dly1 <= s_axis_tvalid;
     end
    
    always@(posedge pixel_clk)
    begin
        s_axis_tdata_dly1 <= s_axis_tdata;
        s_axis_tlast_dly1 <= s_axis_tlast;
        s_axis_tuser_dly1 <= s_axis_tuser;
        s_axis_tvalid_dly1<= s_axis_tvalid;
    end
    
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser == 1'b1)
        begin
            pixels_count <= 12'd0;
        end
        else
        begin
        
            if(pixels_count < (WIDTH - 1'b1))
            begin
                if(s_axis_tvalid_dly1 == 1'b1)
                begin
                    pixels_count <= pixels_count + 1'b1;
                end
                else
                begin
                    pixels_count <= pixels_count;
                end
            end
            else
            begin
                pixels_count <= 12'd0;
            end
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(pixels_count ==(WIDTH - 12'd2))
        begin
            tlast_reg <= 1'b1;
        end
        else
        begin
            tlast_reg <= 1'b0;
        end
    end
     
     always@(posedge pixel_clk)
     begin
         m_axis_tlast_reg  <= tlast_reg         ;
         m_axis_tuser_reg  <= s_axis_tuser_dly1 ;
         m_axis_tvalid_reg <= s_axis_tvalid_dly1;  
         m_axis_tdata_reg  <= s_axis_tdata_dly1;
     end
     
     
endmodule
