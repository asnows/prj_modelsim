`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/04 10:03:31
// Design Name: 
// Module Name: sobel5x5_algorithm
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

module sobel5x5_algorithm
    #(
    parameter DATA_WIDTH = 10,
    parameter IMG_WIDTH  = 640,
    parameter IMG_HEIGHT = 480
)
(
    input                   pixel_clk       ,
    input                   edge_selelct    ,
    input[7:0]              threshold       ,
    input                   s_axis_tlast    ,
    input                   s_axis_tuser    ,
    input                   s_axis_tvalid   ,
    input[DATA_WIDTH-1:0]   matrix0_tdata   ,
    input[DATA_WIDTH-1:0]   matrix1_tdata   ,
    input[DATA_WIDTH-1:0]   matrix2_tdata   ,
    input[DATA_WIDTH-1:0]   matrix3_tdata   ,
    input[DATA_WIDTH-1:0]   matrix4_tdata   ,
    
    output                  m_axis_tlast    ,
    output                  m_axis_tuser    ,
    output                  m_axis_tvalid   ,
    output[DATA_WIDTH-1:0]  m_axis_Gxdata    ,
    output[DATA_WIDTH-1:0]  m_axis_Gydata    ,
    output[DATA_WIDTH-1:0]  m_axis_tdata    ,
    output[DATA_WIDTH-1:0]  m_axis_raw_tdata      
 );

    reg                   s_axis_tlast_dly1 ,s_axis_tlast_dly2 ,s_axis_tlast_dly3 ,s_axis_tlast_dly4 ,s_axis_tlast_dly5 ,s_axis_tlast_dly6 ,s_axis_tlast_dly7 ,s_axis_tlast_dly8 ;
    reg                   s_axis_tuser_dly1 ,s_axis_tuser_dly2 ,s_axis_tuser_dly3 ,s_axis_tuser_dly4 ,s_axis_tuser_dly5 ,s_axis_tuser_dly6 ,s_axis_tuser_dly7 ,s_axis_tuser_dly8 ;
    reg                   s_axis_tvalid_dly1,s_axis_tvalid_dly2,s_axis_tvalid_dly3,s_axis_tvalid_dly4,s_axis_tvalid_dly5,s_axis_tvalid_dly6,s_axis_tvalid_dly7,s_axis_tvalid_dly8;
    
    reg[DATA_WIDTH-1:0]   matrix0_tdata_dly1,matrix0_tdata_dly2,matrix0_tdata_dly3,matrix0_tdata_dly4,matrix0_tdata_dly5;//matrix0_tdata_dly6,matrix0_tdata_dly7,matrix0_tdata_dly8;
    reg[DATA_WIDTH-1:0]   matrix1_tdata_dly1,matrix1_tdata_dly2,matrix1_tdata_dly3,matrix1_tdata_dly4,matrix1_tdata_dly5;//matrix1_tdata_dly6,matrix1_tdata_dly7,matrix1_tdata_dly8;
    reg[DATA_WIDTH-1:0]   matrix2_tdata_dly1,matrix2_tdata_dly2,matrix2_tdata_dly3,matrix2_tdata_dly4,matrix2_tdata_dly5,matrix2_tdata_dly6,matrix2_tdata_dly7,matrix2_tdata_dly8;
    reg[DATA_WIDTH-1:0]   matrix3_tdata_dly1,matrix3_tdata_dly2,matrix3_tdata_dly3,matrix3_tdata_dly4,matrix3_tdata_dly5;//matrix3_tdata_dly6,matrix3_tdata_dly7,matrix3_tdata_dly8;
    reg[DATA_WIDTH-1:0]   matrix4_tdata_dly1,matrix4_tdata_dly2,matrix4_tdata_dly3,matrix4_tdata_dly4,matrix4_tdata_dly5;//matrix4_tdata_dly6,matrix4_tdata_dly7,matrix4_tdata_dly8;

 
    reg[DATA_WIDTH  :0] matrix_data_x1,matrix_data_x_1,matrix_data_x2,matrix_data_x_2,
                        matrix_data_x3,matrix_data_x_3,matrix_data_x4,matrix_data_x_4,
                        matrix_data_x6,matrix_data_x_6,matrix_data_x8,matrix_data_x_8,
                        matrix_data_x12,matrix_data_x_12;
                     
    reg[DATA_WIDTH+5:0]  matrix_data_abs_x1,matrix_data_abs_x2,matrix_data_abs_x3,matrix_data_abs_x4,
                         matrix_data_abs_x6,matrix_data_abs_x8,matrix_data_abs_x12;
    reg[DATA_WIDTH+7:0]  Gx_out; 
                    
                     
    reg[DATA_WIDTH  :0] matrix_data_y1,matrix_data_y_1,matrix_data_y2,matrix_data_y_2,
                        matrix_data_y3,matrix_data_y_3,matrix_data_y4,matrix_data_y_4,
                        matrix_data_y6,matrix_data_y_6,matrix_data_y8,matrix_data_y_8,
                        matrix_data_y12,matrix_data_y_12;
                       
    reg[DATA_WIDTH+5:0]  matrix_data_abs_y1,matrix_data_abs_y2,matrix_data_abs_y3,matrix_data_abs_y4,
                         matrix_data_abs_y6,matrix_data_abs_y8,matrix_data_abs_y12;
    reg[DATA_WIDTH+7:0] Gy_out; 
                    
    reg[11:0]            pixel_count = 12'd0;
    reg[11:0]            line_count  = 12'd0;
      
    reg                 tlast_out_reg    ;
    reg                 tuser_out_reg    ;
    reg                 tvalid_out_reg   ;
    reg[DATA_WIDTH+8:0] tdata_out_reg,Gx_out_reg,Gy_out_reg    ;
    reg[DATA_WIDTH-1:0] tdata_raw_out_reg; 
    reg                 edge_sel; 

    
    
    assign m_axis_tlast     = tlast_out_reg    ;
    assign m_axis_tuser     = tuser_out_reg    ;     
    assign m_axis_tvalid    = tvalid_out_reg   ;
    assign m_axis_raw_tdata = tdata_raw_out_reg;  
    assign m_axis_tdata     =  (tdata_out_reg > 8'd255)? 8'd255:tdata_out_reg;
    assign m_axis_Gxdata    =    (Gx_out_reg > 8'd255 )? 8'd255:Gx_out_reg;
    assign m_axis_Gydata    =    (Gy_out_reg > 8'd255 )? 8'd255:Gy_out_reg;
     
    always@(posedge pixel_clk)
    begin
        {s_axis_tlast_dly8,s_axis_tlast_dly7,s_axis_tlast_dly6,s_axis_tlast_dly5,s_axis_tlast_dly4,s_axis_tlast_dly3,s_axis_tlast_dly2,s_axis_tlast_dly1}<=
        {s_axis_tlast_dly7,s_axis_tlast_dly6,s_axis_tlast_dly5,s_axis_tlast_dly4,s_axis_tlast_dly3,s_axis_tlast_dly2,s_axis_tlast_dly1,s_axis_tlast};
        
        {s_axis_tuser_dly8,s_axis_tuser_dly7,s_axis_tuser_dly6,s_axis_tuser_dly5,s_axis_tuser_dly4,s_axis_tuser_dly3,s_axis_tuser_dly2,s_axis_tuser_dly1}<=
        {s_axis_tuser_dly7,s_axis_tuser_dly6,s_axis_tuser_dly5,s_axis_tuser_dly4,s_axis_tuser_dly3,s_axis_tuser_dly2,s_axis_tuser_dly1,s_axis_tuser};
        
        {s_axis_tvalid_dly8,s_axis_tvalid_dly7,s_axis_tvalid_dly6,s_axis_tvalid_dly5,s_axis_tvalid_dly4,s_axis_tvalid_dly3,s_axis_tvalid_dly2,s_axis_tvalid_dly1}<=
        {s_axis_tvalid_dly7,s_axis_tvalid_dly6,s_axis_tvalid_dly5,s_axis_tvalid_dly4,s_axis_tvalid_dly3,s_axis_tvalid_dly2,s_axis_tvalid_dly1,s_axis_tvalid};
        
        {matrix0_tdata_dly5,matrix0_tdata_dly4,matrix0_tdata_dly3,matrix0_tdata_dly2,matrix0_tdata_dly1} <= {matrix0_tdata_dly4,matrix0_tdata_dly3,matrix0_tdata_dly2,matrix0_tdata_dly1,matrix0_tdata};
        {matrix1_tdata_dly5,matrix1_tdata_dly4,matrix1_tdata_dly3,matrix1_tdata_dly2,matrix1_tdata_dly1} <= {matrix1_tdata_dly4,matrix1_tdata_dly3,matrix1_tdata_dly2,matrix1_tdata_dly1,matrix1_tdata};
        {matrix2_tdata_dly5,matrix2_tdata_dly4,matrix2_tdata_dly3,matrix2_tdata_dly2,matrix2_tdata_dly1} <= {matrix2_tdata_dly4,matrix2_tdata_dly3,matrix2_tdata_dly2,matrix2_tdata_dly1,matrix2_tdata};
        {matrix3_tdata_dly5,matrix3_tdata_dly4,matrix3_tdata_dly3,matrix3_tdata_dly2,matrix3_tdata_dly1} <= {matrix3_tdata_dly4,matrix3_tdata_dly3,matrix3_tdata_dly2,matrix3_tdata_dly1,matrix3_tdata};
        {matrix4_tdata_dly5,matrix4_tdata_dly4,matrix4_tdata_dly3,matrix4_tdata_dly2,matrix4_tdata_dly1} <= {matrix4_tdata_dly4,matrix4_tdata_dly3,matrix4_tdata_dly2,matrix4_tdata_dly1,matrix4_tdata};
    
    
        matrix2_tdata_dly6 <= matrix2_tdata_dly5; 
        matrix2_tdata_dly7 <= matrix2_tdata_dly6; 
        matrix2_tdata_dly8 <= matrix2_tdata_dly7; 
        
        edge_sel <= edge_selelct;
    
    
    end 
    

    always@(posedge pixel_clk)
    begin
        //xx
        matrix_data_x1  <= matrix0_tdata_dly1 + matrix4_tdata_dly1;// 1x 
        matrix_data_x_1 <= matrix0_tdata_dly5 + matrix4_tdata_dly5;// -1x 
        matrix_data_x2  <= matrix0_tdata_dly2 + matrix4_tdata_dly2;// 2x 
        matrix_data_x_2 <= matrix0_tdata_dly4 + matrix4_tdata_dly4;// -2x 
        matrix_data_x4  <= matrix1_tdata_dly1 + matrix3_tdata_dly1;// 4x 
        matrix_data_x_4 <= matrix1_tdata_dly5 + matrix3_tdata_dly5;// -4x 
        matrix_data_x6  <= matrix2_tdata_dly1;// 6x 
        matrix_data_x_6 <= matrix2_tdata_dly5;// -6x 
        matrix_data_x8  <= matrix1_tdata_dly2 + matrix3_tdata_dly2;// 8x 
        matrix_data_x_8 <= matrix1_tdata_dly4 + matrix3_tdata_dly4;// -8x 
        matrix_data_x12 <= matrix2_tdata_dly2;// 12x 
        matrix_data_x_12<= matrix2_tdata_dly4;// -12x 
        
        //yy
        matrix_data_y1  <= matrix4_tdata_dly5 + matrix4_tdata_dly1;// 1x 
        matrix_data_y_1 <= matrix0_tdata_dly5 + matrix0_tdata_dly1;// -1x 
        matrix_data_y2  <= matrix3_tdata_dly5 + matrix3_tdata_dly1;// 2x 
        matrix_data_y_2 <= matrix1_tdata_dly5 + matrix1_tdata_dly1;// -2x 
        matrix_data_y4  <= matrix4_tdata_dly4 + matrix4_tdata_dly2;// 4x 
        matrix_data_y_4 <= matrix0_tdata_dly4 + matrix0_tdata_dly2;// -4x 
        matrix_data_y6  <= matrix4_tdata_dly3;// 6x 
        matrix_data_y_6 <= matrix0_tdata_dly3;// -6x 
        matrix_data_y8  <= matrix3_tdata_dly4 + matrix3_tdata_dly2;// 8x 
        matrix_data_y_8 <= matrix1_tdata_dly4 + matrix1_tdata_dly2;// -8x 
        matrix_data_y12 <= matrix3_tdata_dly3;// 12x 
        matrix_data_y_12<= matrix1_tdata_dly3;// -12x 
    end
    
    
//    //Gx
//    always@(posedge pixel_clk)
//    begin
    
//        if(matrix_data_x1 > matrix_data_x_1)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x1 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x1 <= matrix_data_x1 - matrix_data_x_1;
//            end

//        end
//        else
//        begin
//            matrix_data_abs_x1 <= matrix_data_x_1 - matrix_data_x1;
//        end
        
        
//        if(matrix_data_x2 > matrix_data_x_2 )
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x2 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x2 <= ((matrix_data_x2 - matrix_data_x_2)<<1);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_x2 <= ((matrix_data_x_2 - matrix_data_x2)<<1);
//        end
        
        
//        if(matrix_data_x4 > matrix_data_x_4)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x4 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x4 <= ((matrix_data_x4 - matrix_data_x_4)<<2);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_x4 <= ((matrix_data_x_4 - matrix_data_x4)<<2);
//        end
        
        
//        if(matrix_data_x6 > matrix_data_x_6)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x6 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x6 <= ((matrix_data_x6 - matrix_data_x_6)<<2) + ((matrix_data_x6 - matrix_data_x_6)<<1);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_x6 <= ((matrix_data_x_6 - matrix_data_x6)<<2) + ((matrix_data_x_6 - matrix_data_x6)<<1);
//        end
        
              
//        if(matrix_data_x8 > matrix_data_x_8)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x8 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x8 <= ((matrix_data_x8 - matrix_data_x_8)<<3);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_x8 <= ((matrix_data_x_8 - matrix_data_x8)<<3);
//        end
        
        
//        if(matrix_data_x12 > matrix_data_x_12)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_x12 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_x12 <= ((matrix_data_x12 - matrix_data_x_12)<<3) + ((matrix_data_x12 - matrix_data_x_12)<<2);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_x12 <= ((matrix_data_x_12 - matrix_data_x12)<<3) + ((matrix_data_x_12 - matrix_data_x12)<<2);
//        end      
//    end


//    //Gy
//    always@(posedge pixel_clk)
//    begin
    
//        if(matrix_data_y1 > matrix_data_y_1)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y1 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y1 <= matrix_data_y1 - matrix_data_y_1;
//            end
            
            
//        end
//        else
//        begin
//            matrix_data_abs_y1 <= matrix_data_y_1 - matrix_data_y1;
//        end
        
        
//        if(matrix_data_y2 > matrix_data_y_2 )
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y2 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y2 <= ((matrix_data_y2 - matrix_data_y_2)<<1);
//            end
            
            
//        end
//        else
//        begin
//            matrix_data_abs_y2 <= ((matrix_data_y_2 - matrix_data_y2)<<1);
//        end
        
        
//        if(matrix_data_y4 > matrix_data_y_4)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y4 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y4 <= ((matrix_data_y4 - matrix_data_y_4)<<2);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_y4 <= ((matrix_data_y_4 - matrix_data_y4)<<2);
//        end
        
        
//        if(matrix_data_y6 > matrix_data_y_6)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y6 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y6 <= ((matrix_data_y6 - matrix_data_y_6)<<2) + ((matrix_data_y6 - matrix_data_y_6)<<1);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_y6 <= ((matrix_data_y_6 - matrix_data_y6)<<2) + ((matrix_data_y_6 - matrix_data_y6)<<1);
//        end
        
              
//        if(matrix_data_y8 > matrix_data_y_8)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y8 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y8 <= ((matrix_data_y8 - matrix_data_y_8)<<3);
//            end
            
            
//        end
//        else
//        begin
//            matrix_data_abs_y8 <= ((matrix_data_y_8 - matrix_data_y8)<<3);
//        end
        
        
//        if(matrix_data_y12 > matrix_data_y_12)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_data_abs_y12 <= 16'd0;
//            end
//            else
//            begin
//                matrix_data_abs_y12 <= ((matrix_data_y12 - matrix_data_y_12)<<3) + ((matrix_data_y12 - matrix_data_y_12)<<2);
//            end
            
//        end
//        else
//        begin
//            matrix_data_abs_y12 <= ((matrix_data_y_12 - matrix_data_y12)<<3) + ((matrix_data_y_12 - matrix_data_y12)<<2);
//        end      
//    end



    //Gx
    always@(posedge pixel_clk)
    begin
    
        if(matrix_data_x1 < matrix_data_x_1)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x1 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x1 <= matrix_data_x_1 - matrix_data_x1;
            end

        end
        else
        begin
            matrix_data_abs_x1 <= matrix_data_x1 - matrix_data_x_1;
        end
        
        
        
        
        
        if(matrix_data_x2 < matrix_data_x_2 )
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x2 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x2 <= ((matrix_data_x_2 - matrix_data_x2)<<1);
            end
            
        end
        else
        begin
            matrix_data_abs_x2 <= ((matrix_data_x2 - matrix_data_x_2)<<1);
        end
        
        
        if(matrix_data_x4 < matrix_data_x_4)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x4 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x4 <= ((matrix_data_x_4 - matrix_data_x4)<<2);
            end
            
        end
        else
        begin
            matrix_data_abs_x4 <= ((matrix_data_x4 - matrix_data_x_4)<<2);
        end
        
        
        if(matrix_data_x6 < matrix_data_x_6)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x6 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x6 <= ((matrix_data_x_6 - matrix_data_x6)<<2) + ((matrix_data_x_6 - matrix_data_x6)<<1);
            end
            
        end
        else
        begin
            matrix_data_abs_x6 <= ((matrix_data_x6 - matrix_data_x_6)<<2) + ((matrix_data_x6 - matrix_data_x_6)<<1);
        end
        
              
        if(matrix_data_x8 < matrix_data_x_8)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x8 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x8 <= ((matrix_data_x_8 - matrix_data_x8)<<3);
            end
            
        end
        else
        begin
            matrix_data_abs_x8 <= ((matrix_data_x8 - matrix_data_x_8)<<3);
        end
        
        
        if(matrix_data_x12 < matrix_data_x_12)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_x12 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_x12 <= ((matrix_data_x_12 - matrix_data_x12)<<3) + ((matrix_data_x_12 - matrix_data_x12)<<2);
            end
            
        end
        else
        begin
            matrix_data_abs_x12 <= ((matrix_data_x12 - matrix_data_x_12)<<3) + ((matrix_data_x12 - matrix_data_x_12)<<2);
        end      
    end



    //Gy
    always@(posedge pixel_clk)
    begin
    
        if(matrix_data_y1 < matrix_data_y_1)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y1 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y1 <= matrix_data_y_1 - matrix_data_y1;
            end
            
            
        end
        else
        begin
            matrix_data_abs_y1 <= matrix_data_y1 - matrix_data_y_1;
        end
        
        
        if(matrix_data_y2 < matrix_data_y_2 )
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y2 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y2 <= ((matrix_data_y_2 - matrix_data_y2)<<1);
            end
            
            
        end
        else
        begin
            matrix_data_abs_y2 <= ((matrix_data_y2 - matrix_data_y_2)<<1);
        end
        
        
        if(matrix_data_y4 < matrix_data_y_4)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y4 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y4 <= ((matrix_data_y_4 - matrix_data_y4)<<2);
            end
            
        end
        else
        begin
            matrix_data_abs_y4 <= ((matrix_data_y4 - matrix_data_y_4)<<2);
        end
        
        
        if(matrix_data_y6 < matrix_data_y_6)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y6 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y6 <= ((matrix_data_y_6 - matrix_data_y6)<<2) + ((matrix_data_y_6 - matrix_data_y6)<<1);
            end
            
        end
        else
        begin
            matrix_data_abs_y6 <= ((matrix_data_y6 - matrix_data_y_6)<<2) + ((matrix_data_y6 - matrix_data_y_6)<<1);
        end
        
              
        if(matrix_data_y8 < matrix_data_y_8)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y8 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y8 <= ((matrix_data_y_8 - matrix_data_y8)<<3);
            end
            
            
        end
        else
        begin
            matrix_data_abs_y8 <= ((matrix_data_y8 - matrix_data_y_8)<<3);
        end
        
        
        if(matrix_data_y12 < matrix_data_y_12)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_data_abs_y12 <= 16'd0;
            end
            else
            begin
                matrix_data_abs_y12 <= ((matrix_data_y_12 - matrix_data_y12)<<3) + ((matrix_data_y_12 - matrix_data_y12)<<2);
            end
            
        end
        else
        begin
            matrix_data_abs_y12 <= ((matrix_data_y12 - matrix_data_y_12)<<3) + ((matrix_data_y12 - matrix_data_y_12)<<2);
        end      
    end
    
    always@(posedge pixel_clk)
    begin
        Gx_out <= matrix_data_abs_x1 + matrix_data_abs_x2 + matrix_data_abs_x4 
                + matrix_data_abs_x6 + matrix_data_abs_x8 + matrix_data_abs_x12;
        Gy_out <= matrix_data_abs_y1 + matrix_data_abs_y2 + matrix_data_abs_y4 
                + matrix_data_abs_y6 + matrix_data_abs_y8 + matrix_data_abs_y12;
    end

    //line count
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser_dly1 == 1'b1)
        begin
            line_count <= 12'd0;
        end
        else
        begin
            if(s_axis_tlast_dly6 == 1'b1)
            begin
                line_count <= line_count + 1'b1;
            end
            else
            begin
                line_count <= line_count;
            end
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(s_axis_tlast_dly6 == 1'b1)
        begin
            pixel_count <= 12'd0;
        end
        else
        begin
            if(s_axis_tvalid_dly6 == 1'b1)
            begin
                pixel_count <= pixel_count + 1'b1;
            end
            else
            begin
                pixel_count <= pixel_count;
            end
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(((line_count > 10'd1) && (line_count < (IMG_HEIGHT - 10'd2)))
         &&((pixel_count > 10'd1) && (pixel_count < (IMG_WIDTH - 10'd2))))
        begin
            Gx_out_reg <= Gx_out;   
            Gy_out_reg <= Gy_out; 
            tdata_out_reg <= Gx_out + Gy_out;  
        end
        else
        begin
            tdata_out_reg <= 17'd0;  
        end
    end
 
    always@(posedge pixel_clk)
    begin
        tlast_out_reg      <= s_axis_tlast_dly6 ; 
        tuser_out_reg      <= s_axis_tuser_dly6 ; 
        tvalid_out_reg     <= s_axis_tvalid_dly6; 
        tdata_raw_out_reg  <= matrix2_tdata_dly6;  
    end   

endmodule
