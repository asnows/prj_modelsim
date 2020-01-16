`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 14:21:45
// Design Name: 
// Module Name: rgb2gray
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


module rgb2gray
    #(
        parameter DATA_WIDTH = 10
    
    )
    (
        input       pixel_clk    ,
        input       s_axis_tlast ,
        input       s_axis_tuser ,
        input       s_axis_tvalid,   
        input[23:0] s_axis_tdata , 
        input       sel_way       ,
        
        output      m_axis_tlast ,
        output      m_axis_tuser ,
        output      m_axis_tvalid ,   
        output[DATA_WIDTH -1:0] m_axis_tdata  
        
    );
    
    reg[3:0]  s_axis_tlast_dely ;
    reg[3:0]  s_axis_tuser_dely ;
    reg[3:0]  s_axis_tvalid_dely;   
    reg[23:0] s_axis_tdata_dely ; 
    reg       sel_way_dely      ;
    reg[DATA_WIDTH -1:0] aver_data; 
 
    
    reg                 m_axis_tlast_reg ;
    reg                 m_axis_tuser_reg ;
    reg                 m_axis_tvalid_reg;
    reg[DATA_WIDTH -1:0]m_axis_tdata_reg ;
    
    reg[15:0] r_data1,r_data2,g_data1,g_data2,b_data1,b_data2,form_data;
    
    assign m_axis_tlast  = m_axis_tlast_reg  ;
    assign m_axis_tuser  = m_axis_tuser_reg  ;
    assign m_axis_tvalid = m_axis_tvalid_reg ;
    assign m_axis_tdata  = m_axis_tdata_reg  ;
    
    always@(posedge pixel_clk)
    begin
    
        s_axis_tlast_dely <= {s_axis_tlast_dely[2:0],s_axis_tlast };
        s_axis_tuser_dely <= {s_axis_tuser_dely[2:0],s_axis_tuser };
        s_axis_tvalid_dely<= {s_axis_tvalid_dely[2:0],s_axis_tvalid};
        s_axis_tdata_dely <= s_axis_tdata ;
        sel_way_dely      <= sel_way      ;                     
    end     
    
    // averag Gray = (R + G + B) /3
    always@(posedge pixel_clk)
    begin
        aver_data <= (s_axis_tdata_dely[23:16] + s_axis_tdata_dely[15:8]+s_axis_tdata_dely[7:0]) / 3;                       
    end

    // form Gray = R*0.299 + G*0.587 + B*0.114;
    //Gray = (R*38 + G*75 + B*15) >> 7
    always@(posedge pixel_clk)
    begin
        r_data1 <= s_axis_tdata_dely[7:0];
        r_data2 <= ((r_data1 << 5) + (r_data1 << 2) + (r_data1 << 1));

        
        g_data1 <= s_axis_tdata_dely[15:8];
        g_data2 <= ((g_data1 << 6) + (g_data1 << 3) + (g_data1<<1) + g_data1);
        
        b_data1 <= s_axis_tdata_dely[23:16];
        b_data2 <= ((b_data1<<4) - b_data1);
        
        form_data <= (r_data2 + g_data2 + b_data2)>>7;
                                    
    end
    
    always@(posedge pixel_clk)
    begin
        case(sel_way_dely)
            1'b0:
            begin
                m_axis_tlast_reg <= s_axis_tlast_dely [1];
                m_axis_tuser_reg <= s_axis_tuser_dely [1];
                m_axis_tvalid_reg<= s_axis_tvalid_dely[1];
                m_axis_tdata_reg <=  aver_data;   
            end
            
            1'b1:
            begin
            
                m_axis_tlast_reg <= s_axis_tlast_dely [3];
                m_axis_tuser_reg <= s_axis_tuser_dely [3];
                m_axis_tvalid_reg<= s_axis_tvalid_dely[3];
                m_axis_tdata_reg <=  form_data;             
            end
            default:;
        endcase
    end
    
    
    

endmodule
