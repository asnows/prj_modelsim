`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:41:25
// Design Name: 
// Module Name: gaus_filter_axis
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


module gaus_filter_axis
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH = 640,
        parameter IMG_HEIGHT = 480
    
    )
    (
        input       pixel_clk    ,
        input       gaus_en      ,
        input       s_axis_tlast ,
        input       s_axis_tuser ,
        input       s_axis_tvalid,   
        input[DATA_WIDTH - 1:0]  matrix_data01, 
        input[DATA_WIDTH - 1:0]  matrix_data11, 
        input[DATA_WIDTH - 1:0]  matrix_data21,
        
        output      m_axis_tlast ,
        output      m_axis_tuser ,
        output      m_axis_tvalid ,   
        output[DATA_WIDTH - 1:0] m_axis_tdata_gaus,
        output[DATA_WIDTH - 1:0] m_axis_tdata_raw
    
    );

//     parameter LH = 2'b01;
//     parameter HL = 2'b10;
//     parameter IMG_WIDTH = 640;
//     parameter IMG_HEIGHT = 480;

     localparam LH = 2'b01;
     localparam HL = 2'b10;
     
     reg [15:0] guas_out_reg,data_raw_out_reg;
     reg tuser_out_reg;
     reg tvalid_out_reg ;
     reg tlast_out_reg ;
            
     reg [15:0] matrix_gaus01,matrix_gaus02,matrix_gaus03;
     reg [15:0] matrix_gaus11,matrix_gaus12,matrix_gaus13;
     reg [15:0] matrix_gaus21,matrix_gaus22,matrix_gaus23;
     reg [15:0] guas_tmp0,guas_tmp1;
     reg [15:0] data_raw_delay1, data_raw_delay2;
     reg        tuser_delay0,tuser_delay1,tuser_delay2,tuser_delay3;
     reg        tvalid_delay0,tvalid_delay1,tvalid_delay2,tvalid_delay3;
     reg        tlast_delay0,tlast_delay1,tlast_delay2,tlast_delay3;
     reg [1:0]  tvalid_reg;
     reg cols_gaus_en;
     reg rows_gaus_en;
     reg [11:0]rows_count = 12'd0;
     reg [11:0]cols_count = 12'd0;
     
     

    // -----------------------------gaus part----------------------------------// 
//    assign vsync_out     = vsync_out_reg;         
//    assign href_out      = href_out_reg ;          
//    assign data_raw_out  = data_raw_out_reg;
//    assign data_gaus_out = guas_out_reg;  
    
    assign m_axis_tlast      = tlast_out_reg;
    assign m_axis_tuser      = tuser_out_reg;
    assign m_axis_tvalid     = tvalid_out_reg;   
    assign m_axis_tdata_gaus = guas_out_reg  ;
    assign m_axis_tdata_raw  = data_raw_out_reg;
    
     
     always@(posedge pixel_clk)
     begin
        {matrix_gaus01,matrix_gaus02,matrix_gaus03} <= {matrix_gaus02,matrix_gaus03,8'b0000_0000,matrix_data01};
        {matrix_gaus11,matrix_gaus12,matrix_gaus13} <= {matrix_gaus12,matrix_gaus13,8'b0000_0000,matrix_data11};
        {matrix_gaus21,matrix_gaus22,matrix_gaus23} <= {matrix_gaus22,matrix_gaus23,8'b0000_0000,matrix_data21};
    end
    
    always@(posedge pixel_clk)
    begin
        guas_tmp0 <= matrix_gaus01 + (matrix_gaus02 << 1) + matrix_gaus03
                   + (matrix_gaus11 << 1) + (matrix_gaus12 << 2) + (matrix_gaus13 << 1)
                   + matrix_gaus21 + (matrix_gaus22 << 1) + matrix_gaus23;
                    
    end
    
    always@(posedge pixel_clk)
    begin
        guas_tmp1 <= (guas_tmp0 >> 4); 
    end
    
    always@(posedge pixel_clk)
    begin
        tuser_delay0 <= s_axis_tuser;
        tuser_delay1 <= tuser_delay0;
        tuser_delay2 <= tuser_delay1;
        tuser_delay3 <= tuser_delay2;
        tuser_out_reg<= tuser_delay3;
        
        tvalid_delay0 <= s_axis_tvalid;
        tvalid_delay1 <= tvalid_delay0;
        tvalid_delay2 <= tvalid_delay1;
        tvalid_delay3 <= tvalid_delay2;
        tvalid_out_reg<= tvalid_delay3;
        
        tlast_delay0 <= s_axis_tlast;
        tlast_delay1 <= tlast_delay0;
        tlast_delay2 <= tlast_delay1;
        tlast_delay3 <= tlast_delay2;
        tlast_out_reg<= tlast_delay3;
                             
        data_raw_delay1 <= matrix_gaus12;
        data_raw_delay2 <= data_raw_delay1;
        data_raw_out_reg<= data_raw_delay2;
        
    end
    
    always@(posedge pixel_clk)
    begin
        tvalid_reg <= {tvalid_reg[0],tvalid_delay3};    
    end
    
    // get cols
    always@(posedge pixel_clk)
    begin
        if(tvalid_delay3 == 1'b1)
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
        if(tuser_delay3 == 1'b1)
            begin
                rows_count <= 11'd0;
            end
        else
            begin
                if(tvalid_reg == HL)
                    begin
                        rows_count <= rows_count + 1'b1;    
                    end
            end
    end
    
    //get cols_dpc_en
    always@(posedge pixel_clk)
    begin
        if(tvalid_delay3 == 1'b1 && (cols_count < IMG_WIDTH - 2))
            begin
                cols_gaus_en <= 1'b1;
            end
        else
            begin
                cols_gaus_en <= 1'b0;
            end
    end
    
    //get rows_dpc_en
    always@(posedge pixel_clk)
    begin
        if((rows_count > 12'd0)&&(rows_count < IMG_HEIGHT - 1'b1))
            begin
                rows_gaus_en <= 1'b1;    
            end
        else
            begin
                rows_gaus_en <= 1'b0;    
            end
    end
    
    
    always@(posedge pixel_clk)
    begin
        if((cols_gaus_en == 1'b1) && (rows_gaus_en == 1'b1) && (gaus_en == 1'b1))
        begin
            guas_out_reg <= guas_tmp1;    
        end
        else
        begin
            guas_out_reg <= data_raw_delay2;    
        end
    
    end


endmodule
