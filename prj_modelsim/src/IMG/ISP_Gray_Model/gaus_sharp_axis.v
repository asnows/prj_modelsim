`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:13:04
// Design Name: 
// Module Name: gaus_sharp_axis
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


module gaus_sharp_axis
    #(
        parameter DATA_WIDTH = 10
    )
    (
        input pixel_clk,
        input shrap_en,
        input[9:0]  sharp_threlode_in,
        input[7:0]  sharp_factor_in ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        input[DATA_WIDTH - 1:0]  data_raw_in     ,
        input[DATA_WIDTH - 1:0]  data_gaus_in    ,
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[DATA_WIDTH - 1:0] m_axis_tdata    
    );
    
    reg[19:0] data_abs = 20'd0,data_tmp2 = 20'd0;
    reg tuser_delay1,tuser_delay2,tuser_delay3,tuser_delay4,tuser_delay5;
    reg tvalid_delay1,tvalid_delay2,tvalid_delay3,tvalid_delay4,tvalid_delay5;
    reg tlast_delay1,tlast_delay2,tlast_delay3,tlast_delay4,tlast_delay5;
    reg data_abs_flg = 1'b0 ;
    reg[9:0]  sharp_threlode;
    reg[7:0]  sharp_factor  ;
    reg[DATA_WIDTH - 1:0]  data_raw_delay1,data_raw_delay2,data_raw_delay3,data_raw_delay4    ;
    reg[DATA_WIDTH - 1:0]  data_gaus_delay1,data_gaus_delay2,data_gaus_delay3,data_gaus_delay4;
    reg[DATA_WIDTH - 1:0]  data_out_reg;
    reg[19:0] data_factor ;
   
    
    assign  m_axis_tlast  = (shrap_en == 1'b1) ? tlast_delay5 : s_axis_tlast;  
    assign  m_axis_tuser  = (shrap_en == 1'b1) ? tuser_delay5 : s_axis_tuser;    
    assign  m_axis_tvalid = (shrap_en == 1'b1) ? tvalid_delay5: s_axis_tvalid;     
    assign  m_axis_tdata  = (shrap_en == 1'b1) ? data_out_reg : data_gaus_in ; 
    
//    assign data_factor = sharp_factor*data_abs; 
    
    always@(posedge pixel_clk)
    begin
        sharp_threlode    <= sharp_threlode_in;
        sharp_factor      <= sharp_factor_in ;
        
        data_raw_delay1   <= data_raw_in     ;
        data_raw_delay2   <= data_raw_delay1;
        data_raw_delay3   <= data_raw_delay2;
        
        data_gaus_delay1  <= data_gaus_in    ;
        data_gaus_delay2  <= data_gaus_delay1;
        data_gaus_delay3  <= data_gaus_delay2;
        data_gaus_delay4  <= data_gaus_delay3;  
    end
    
    always@(posedge pixel_clk)
    begin
        if(data_raw_delay1 > data_gaus_delay1)
        begin
            data_abs_flg <= 1'b1;
            data_abs <= data_raw_delay1 - data_gaus_delay1;    
        end
        else
        begin
            data_abs_flg <= 1'b0;
            data_abs <= data_gaus_delay1 - data_raw_delay1;    
        end
    end
    
    
    always@(posedge pixel_clk)
    begin
        data_factor = sharp_factor*data_abs; 
    end
    
    always@(posedge pixel_clk)
    begin
        if(data_abs_flg == 1'b1)
        begin
            //data_tmp2 <= data_raw_delay2 + sharp_factor*data_abs; 
            //data_tmp2 <= data_raw_delay2 + data_factor; 
            data_tmp2 <= data_raw_delay3 + data_factor;       
        end
        else
        begin
            if(data_raw_delay3 > data_factor )
            begin
                data_tmp2 <= data_raw_delay3 - data_factor; 
            end
            else
            begin
                data_tmp2 <= data_raw_delay3;  
            end
        
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(data_abs > sharp_threlode)
        begin
            if(data_tmp2 > 8'd255) //10'd1023
            begin
                data_out_reg <=  8'd255;//10'd1023
            end
            else
            begin
                data_out_reg <= data_tmp2;     
            end
        end
        else
        begin
            data_out_reg <= data_gaus_delay4;
        end
    end
    
    always@(posedge pixel_clk)
    begin
        tuser_delay1 <= s_axis_tuser;
        tuser_delay2 <= tuser_delay1;
        tuser_delay3 <= tuser_delay2;
        tuser_delay4 <= tuser_delay3;
        tuser_delay5 <= tuser_delay4;
        
        tvalid_delay1 <= s_axis_tvalid;
        tvalid_delay2 <= tvalid_delay1;
        tvalid_delay3 <= tvalid_delay2;
        tvalid_delay4 <= tvalid_delay3;
        tvalid_delay5 <= tvalid_delay4;
        
        tlast_delay1 <= s_axis_tlast;
        tlast_delay2 <= tlast_delay1;
        tlast_delay3 <= tlast_delay2;
        tlast_delay4 <= tlast_delay3;
        tlast_delay5 <= tlast_delay4;
    end
    
    
endmodule
