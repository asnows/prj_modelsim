`timescale 1ns / 1ps
/*
模块名：
	rows_resize
功能：
	根据输入参数rows_size，改变行长大小。

参数：
	rows_size：行长大小（如3840）
*/

module rows_resize
    #(
        parameter DATA_WIDTH = 8
    )
    (
		
        input       pixel_clk       ,
		input[11:0] rows_size   	,
        input[DATA_WIDTH-1:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[DATA_WIDTH-1:0] m_axis_tdata    
    
     );
     (*mark_debug="true"*)reg[11:0] rowsSize;
     (*mark_debug="true"*)reg[DATA_WIDTH-1:0] s_axis_tdata_dly1 ;
     (*mark_debug="true"*)reg                 s_axis_tlast_dly1 ;
     (*mark_debug="true"*)reg                 s_axis_tuser_dly1 ;
     (*mark_debug="true"*)reg                 s_axis_tvalid_dly1;
     (*mark_debug="true"*)reg                 m_axis_tlast_reg ;
     (*mark_debug="true"*)reg                 m_axis_tuser_reg ;
     (*mark_debug="true"*)reg                 m_axis_tvalid_reg;
     (*mark_debug="true"*)reg[DATA_WIDTH-1:0] m_axis_tdata_reg ;
     (*mark_debug="true"*)reg tlast_reg = 1'b0;
     (*mark_debug="true"*)reg [11:0] pixels_count = 12'd0;
	  
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
		 rowsSize <= rows_size;
     end
    
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser == 1'b1)
        begin
            pixels_count <= 12'd0;
        end
        else
        begin
        
            if(pixels_count < (rowsSize - 1'b1))
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
        if(pixels_count ==(rowsSize - 12'd2))
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
