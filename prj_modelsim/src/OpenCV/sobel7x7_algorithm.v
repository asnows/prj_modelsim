`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/06 14:43:06
// Design Name: 
// Module Name: sobel7x7_algorithm
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


module sobel7x7_algorithm
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
        input[DATA_WIDTH-1:0]   matrix5_tdata   ,
        input[DATA_WIDTH-1:0]   matrix6_tdata   ,
        
        
        
        output                  m_axis_tlast    ,
        output                  m_axis_tuser    ,
        output                  m_axis_tvalid   ,
        output[DATA_WIDTH-1:0]  m_axis_Gxdata    ,
        output[DATA_WIDTH-1:0]  m_axis_Gydata    ,
        output[DATA_WIDTH-1:0]  m_axis_tdata    ,
        output[DATA_WIDTH-1:0]  m_axis_raw_tdata      
    );
    
    reg                   s_axis_tlast_dly1 ,s_axis_tlast_dly2 ,s_axis_tlast_dly3 ,s_axis_tlast_dly4 ,s_axis_tlast_dly5 ,s_axis_tlast_dly6 ,s_axis_tlast_dly7 ,s_axis_tlast_dly8 ,s_axis_tlast_dly9 ,s_axis_tlast_dly10 ;
    reg                   s_axis_tuser_dly1 ,s_axis_tuser_dly2 ,s_axis_tuser_dly3 ,s_axis_tuser_dly4 ,s_axis_tuser_dly5 ,s_axis_tuser_dly6 ,s_axis_tuser_dly7 ,s_axis_tuser_dly8 ,s_axis_tuser_dly9 ,s_axis_tuser_dly10 ;
    reg                   s_axis_tvalid_dly1,s_axis_tvalid_dly2,s_axis_tvalid_dly3,s_axis_tvalid_dly4,s_axis_tvalid_dly5,s_axis_tvalid_dly6,s_axis_tvalid_dly7,s_axis_tvalid_dly8,s_axis_tvalid_dly9,s_axis_tvalid_dly10;
    reg[DATA_WIDTH-1:0]   matrix0_tdata_dly1,matrix0_tdata_dly2,matrix0_tdata_dly3,matrix0_tdata_dly4,matrix0_tdata_dly5,matrix0_tdata_dly6,matrix0_tdata_dly7;//matrix0_tdata_dly8,matrix0_tdata_dly9,matrix0_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix1_tdata_dly1,matrix1_tdata_dly2,matrix1_tdata_dly3,matrix1_tdata_dly4,matrix1_tdata_dly5,matrix1_tdata_dly6,matrix1_tdata_dly7;//matrix1_tdata_dly8,matrix1_tdata_dly9,matrix1_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix2_tdata_dly1,matrix2_tdata_dly2,matrix2_tdata_dly3,matrix2_tdata_dly4,matrix2_tdata_dly5,matrix2_tdata_dly6,matrix2_tdata_dly7;//matrix2_tdata_dly8,matrix2_tdata_dly9,matrix2_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix3_tdata_dly1,matrix3_tdata_dly2,matrix3_tdata_dly3,matrix3_tdata_dly4,matrix3_tdata_dly5,matrix3_tdata_dly6,matrix3_tdata_dly7,matrix3_tdata_dly8,matrix3_tdata_dly9,matrix3_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix4_tdata_dly1,matrix4_tdata_dly2,matrix4_tdata_dly3,matrix4_tdata_dly4,matrix4_tdata_dly5,matrix4_tdata_dly6,matrix4_tdata_dly7;//matrix4_tdata_dly8,matrix4_tdata_dly9,matrix4_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix5_tdata_dly1,matrix5_tdata_dly2,matrix5_tdata_dly3,matrix5_tdata_dly4,matrix5_tdata_dly5,matrix5_tdata_dly6,matrix5_tdata_dly7;//matrix5_tdata_dly8,matrix5_tdata_dly9,matrix5_tdata_dly10;
    reg[DATA_WIDTH-1:0]   matrix6_tdata_dly1,matrix6_tdata_dly2,matrix6_tdata_dly3,matrix6_tdata_dly4,matrix6_tdata_dly5,matrix6_tdata_dly6,matrix6_tdata_dly7;//matrix6_tdata_dly8,matrix6_tdata_dly9,matrix6_tdata_dly10;
    
    
    reg[DATA_WIDTH  :0]   matrix_tdata_x1,matrix_tdata_x_1,matrix_tdata_x4,matrix_tdata_x_4,matrix_tdata_x5,matrix_tdata_x_5,matrix_tdata_x6,matrix_tdata_x_6,
                          matrix_tdata_x15,matrix_tdata_x_15,matrix_tdata_x20,matrix_tdata_x_20,matrix_tdata_x24,matrix_tdata_x_24,matrix_tdata_x30,matrix_tdata_x_30,
                          matrix_tdata_x60,matrix_tdata_x_60,matrix_tdata_x75,matrix_tdata_x_75,matrix_tdata_x80,matrix_tdata_x_80,matrix_tdata_x100,matrix_tdata_x_100;
                          
    reg[DATA_WIDTH+8:0]  matrix_tdata_abs_x1,matrix_tdata_abs_x4,matrix_tdata_abs_x5,matrix_tdata_abs_x6,matrix_tdata_abs_x15,matrix_tdata_abs_x20,matrix_tdata_abs_x24,
                         matrix_tdata_abs_x30,matrix_tdata_abs_x60,matrix_tdata_abs_x75,matrix_tdata_abs_x80,matrix_tdata_abs_x100;
    reg[DATA_WIDTH+12:0] Gx_out; 
                          
    reg[DATA_WIDTH  :0]   matrix_tdata_y1,matrix_tdata_y_1,matrix_tdata_y4,matrix_tdata_y_4,matrix_tdata_y5,matrix_tdata_y_5,matrix_tdata_y6,matrix_tdata_y_6,
                          matrix_tdata_y15,matrix_tdata_y_15,matrix_tdata_y20,matrix_tdata_y_20,matrix_tdata_y24,matrix_tdata_y_24,matrix_tdata_y30,matrix_tdata_y_30,
                          matrix_tdata_y60,matrix_tdata_y_60,matrix_tdata_y75,matrix_tdata_y_75,matrix_tdata_y80,matrix_tdata_y_80,matrix_tdata_y100,matrix_tdata_y_100;
                          
    reg[DATA_WIDTH+8:0] matrix_tdata_abs_y1,matrix_tdata_abs_y4,matrix_tdata_abs_y5,matrix_tdata_abs_y6,matrix_tdata_abs_y15,matrix_tdata_abs_y20,matrix_tdata_abs_y24,
                        matrix_tdata_abs_y30,matrix_tdata_abs_y60,matrix_tdata_abs_y75,matrix_tdata_abs_y80,matrix_tdata_abs_y100;
    reg[DATA_WIDTH+12:0] Gy_out; 
                          
    reg[11:0]            pixel_count = 12'd0;
    reg[11:0]            line_count  = 12'd0;
    
    reg                 tlast_out_reg    ;
    reg                 tuser_out_reg    ;
    reg                 tvalid_out_reg   ;
    reg[DATA_WIDTH+13:0] tdata_out_reg,Gx_out_reg,Gy_out_reg    ;
    reg[DATA_WIDTH-1:0] tdata_raw_out_reg; 
    
    reg                 edge_sel ; 
    
    assign m_axis_tlast     = tlast_out_reg     ;
    assign m_axis_tuser     = tuser_out_reg     ;
    assign m_axis_tvalid    = tvalid_out_reg    ;
    assign m_axis_raw_tdata = tdata_raw_out_reg ;
    assign m_axis_tdata     =  (tdata_out_reg  > 8'd255 )? 8'd255:tdata_out_reg;
    assign m_axis_Gxdata    =  (Gx_out_reg     > 8'd255 )? 8'd255:Gx_out_reg;
    assign m_axis_Gydata    =  (Gy_out_reg     > 8'd255 )? 8'd255:Gy_out_reg;
    
    always@(posedge pixel_clk )
    begin
    
        {s_axis_tlast_dly10 ,s_axis_tlast_dly9 ,s_axis_tlast_dly8 ,s_axis_tlast_dly7 ,s_axis_tlast_dly6 ,s_axis_tlast_dly5 ,s_axis_tlast_dly4 ,s_axis_tlast_dly3 ,s_axis_tlast_dly2 ,s_axis_tlast_dly1 }
        <={s_axis_tlast_dly9 ,s_axis_tlast_dly8 ,s_axis_tlast_dly7 ,s_axis_tlast_dly6 ,s_axis_tlast_dly5 ,s_axis_tlast_dly4 ,s_axis_tlast_dly3 ,s_axis_tlast_dly2 ,s_axis_tlast_dly1,s_axis_tlast };
        {s_axis_tuser_dly10 ,s_axis_tuser_dly9 ,s_axis_tuser_dly8 ,s_axis_tuser_dly7 ,s_axis_tuser_dly6 ,s_axis_tuser_dly5 ,s_axis_tuser_dly4 ,s_axis_tuser_dly3 ,s_axis_tuser_dly2 ,s_axis_tuser_dly1 }
        <={s_axis_tuser_dly9 ,s_axis_tuser_dly8 ,s_axis_tuser_dly7 ,s_axis_tuser_dly6 ,s_axis_tuser_dly5 ,s_axis_tuser_dly4 ,s_axis_tuser_dly3 ,s_axis_tuser_dly2 ,s_axis_tuser_dly1,s_axis_tuser }; 
        {s_axis_tvalid_dly10,s_axis_tvalid_dly9,s_axis_tvalid_dly8,s_axis_tvalid_dly7,s_axis_tvalid_dly6,s_axis_tvalid_dly5,s_axis_tvalid_dly4,s_axis_tvalid_dly3,s_axis_tvalid_dly2,s_axis_tvalid_dly1}
        <={s_axis_tvalid_dly9,s_axis_tvalid_dly8,s_axis_tvalid_dly7,s_axis_tvalid_dly6,s_axis_tvalid_dly5,s_axis_tvalid_dly4,s_axis_tvalid_dly3,s_axis_tvalid_dly2,s_axis_tvalid_dly1,s_axis_tvalid}; 
    
        {matrix0_tdata_dly7, matrix0_tdata_dly6, matrix0_tdata_dly5, matrix0_tdata_dly4, matrix0_tdata_dly3, matrix0_tdata_dly2, matrix0_tdata_dly1} <= {matrix0_tdata_dly6, matrix0_tdata_dly5, matrix0_tdata_dly4, matrix0_tdata_dly3, matrix0_tdata_dly2, matrix0_tdata_dly1,matrix0_tdata};
        {matrix1_tdata_dly7, matrix1_tdata_dly6, matrix1_tdata_dly5, matrix1_tdata_dly4, matrix1_tdata_dly3, matrix1_tdata_dly2, matrix1_tdata_dly1} <= {matrix1_tdata_dly6, matrix1_tdata_dly5, matrix1_tdata_dly4, matrix1_tdata_dly3, matrix1_tdata_dly2, matrix1_tdata_dly1,matrix1_tdata};
        {matrix2_tdata_dly7, matrix2_tdata_dly6, matrix2_tdata_dly5, matrix2_tdata_dly4, matrix2_tdata_dly3, matrix2_tdata_dly2, matrix2_tdata_dly1} <= {matrix2_tdata_dly6, matrix2_tdata_dly5, matrix2_tdata_dly4, matrix2_tdata_dly3, matrix2_tdata_dly2, matrix2_tdata_dly1,matrix2_tdata};
        {matrix3_tdata_dly7, matrix3_tdata_dly6, matrix3_tdata_dly5, matrix3_tdata_dly4, matrix3_tdata_dly3, matrix3_tdata_dly2, matrix3_tdata_dly1} <= {matrix3_tdata_dly6, matrix3_tdata_dly5, matrix3_tdata_dly4, matrix3_tdata_dly3, matrix3_tdata_dly2, matrix3_tdata_dly1,matrix3_tdata};
        {matrix4_tdata_dly7, matrix4_tdata_dly6, matrix4_tdata_dly5, matrix4_tdata_dly4, matrix4_tdata_dly3, matrix4_tdata_dly2, matrix4_tdata_dly1} <= {matrix4_tdata_dly6, matrix4_tdata_dly5, matrix4_tdata_dly4, matrix4_tdata_dly3, matrix4_tdata_dly2, matrix4_tdata_dly1,matrix4_tdata};
        {matrix5_tdata_dly7, matrix5_tdata_dly6, matrix5_tdata_dly5, matrix5_tdata_dly4, matrix5_tdata_dly3, matrix5_tdata_dly2, matrix5_tdata_dly1} <= {matrix5_tdata_dly6, matrix5_tdata_dly5, matrix5_tdata_dly4, matrix5_tdata_dly3, matrix5_tdata_dly2, matrix5_tdata_dly1,matrix5_tdata};
        {matrix6_tdata_dly7, matrix6_tdata_dly6, matrix6_tdata_dly5, matrix6_tdata_dly4, matrix6_tdata_dly3, matrix6_tdata_dly2, matrix6_tdata_dly1} <= {matrix6_tdata_dly6, matrix6_tdata_dly5, matrix6_tdata_dly4, matrix6_tdata_dly3, matrix6_tdata_dly2, matrix6_tdata_dly1,matrix6_tdata};
        
        matrix3_tdata_dly8  <= matrix3_tdata_dly7;
        matrix3_tdata_dly9  <= matrix3_tdata_dly8;
        matrix3_tdata_dly10 <= matrix3_tdata_dly9;
        
        edge_sel <= edge_selelct;

    
    end
    
    always@(posedge pixel_clk)
    begin
        matrix_tdata_x1    <= matrix0_tdata_dly1 + matrix6_tdata_dly1;//1x
        matrix_tdata_x_1   <= matrix0_tdata_dly7 + matrix6_tdata_dly7;//-1x
        matrix_tdata_x4    <= matrix0_tdata_dly2 + matrix6_tdata_dly2;//4x
        matrix_tdata_x_4   <= matrix0_tdata_dly6 + matrix6_tdata_dly6;//-4x
        matrix_tdata_x5    <= matrix0_tdata_dly3 + matrix6_tdata_dly3;//5x
        matrix_tdata_x_5   <= matrix0_tdata_dly5 + matrix6_tdata_dly5;//-5x
        matrix_tdata_x6    <= matrix1_tdata_dly1 + matrix5_tdata_dly1;//6x
        matrix_tdata_x_6   <= matrix1_tdata_dly7 + matrix5_tdata_dly7;//-6x
        matrix_tdata_x15   <= matrix2_tdata_dly1 + matrix4_tdata_dly1;//15x
        matrix_tdata_x_15  <= matrix2_tdata_dly7 + matrix4_tdata_dly7;//-15x
        matrix_tdata_x20   <= matrix3_tdata_dly1;//20x
        matrix_tdata_x_20  <= matrix3_tdata_dly7;//-20x
        matrix_tdata_x24   <= matrix1_tdata_dly2 + matrix5_tdata_dly2;//24x
        matrix_tdata_x_24  <= matrix1_tdata_dly6 + matrix5_tdata_dly6;//-24x
        matrix_tdata_x30   <= matrix1_tdata_dly3 + matrix5_tdata_dly3;//30x
        matrix_tdata_x_30  <= matrix1_tdata_dly5 + matrix5_tdata_dly5;//-30x
        matrix_tdata_x60   <= matrix2_tdata_dly2 + matrix4_tdata_dly2;//60x
        matrix_tdata_x_60  <= matrix2_tdata_dly6 + matrix4_tdata_dly6;//-60x
        matrix_tdata_x75   <= matrix1_tdata_dly3 + matrix4_tdata_dly3;//75x
        matrix_tdata_x_75  <= matrix2_tdata_dly5 + matrix4_tdata_dly5;//-75x
        matrix_tdata_x80   <= matrix3_tdata_dly2;//80x
        matrix_tdata_x_80  <= matrix3_tdata_dly6;//-80x
        matrix_tdata_x100  <= matrix3_tdata_dly3;//100x
        matrix_tdata_x_100 <= matrix3_tdata_dly5;//-100x
    
    end
    
    always@(posedge pixel_clk)
    begin
        matrix_tdata_y1    <= matrix6_tdata_dly7 + matrix6_tdata_dly1;//1x
        matrix_tdata_y_1   <= matrix0_tdata_dly7 + matrix0_tdata_dly1;//-1x
        matrix_tdata_y4    <= matrix5_tdata_dly7 + matrix5_tdata_dly1;//4x
        matrix_tdata_y_4   <= matrix1_tdata_dly7 + matrix1_tdata_dly1;//-4x        
        matrix_tdata_y5    <= matrix4_tdata_dly7 + matrix4_tdata_dly1;//5x
        matrix_tdata_y_5   <= matrix2_tdata_dly7 + matrix2_tdata_dly1;//-5x
        matrix_tdata_y6    <= matrix6_tdata_dly6 + matrix6_tdata_dly2;//6x
        matrix_tdata_y_6   <= matrix0_tdata_dly6 + matrix0_tdata_dly2;//-6x        
        matrix_tdata_y15   <= matrix6_tdata_dly5 + matrix6_tdata_dly3;//15x
        matrix_tdata_y_15  <= matrix0_tdata_dly5 + matrix0_tdata_dly3;//-15x        
        matrix_tdata_y20   <= matrix6_tdata_dly4;//20x
        matrix_tdata_y_20  <= matrix0_tdata_dly4;//-20x        
        matrix_tdata_y24   <= matrix5_tdata_dly6 + matrix5_tdata_dly2;//24x
        matrix_tdata_y_24  <= matrix1_tdata_dly6 + matrix1_tdata_dly2;//-24x       
        matrix_tdata_y30   <= matrix4_tdata_dly6 + matrix4_tdata_dly2;//30x
        matrix_tdata_y_30  <= matrix2_tdata_dly6 + matrix2_tdata_dly2;//-30x        
        matrix_tdata_y60   <= matrix5_tdata_dly5 + matrix5_tdata_dly3;//60x
        matrix_tdata_y_60  <= matrix1_tdata_dly5 + matrix1_tdata_dly3;//-60x        
        matrix_tdata_y75   <= matrix4_tdata_dly5 + matrix4_tdata_dly3;//75x
        matrix_tdata_y_75  <= matrix2_tdata_dly5 + matrix2_tdata_dly3;//-75x
        matrix_tdata_y80   <= matrix5_tdata_dly4;//80x
        matrix_tdata_y_80  <= matrix1_tdata_dly4;//-80x
        matrix_tdata_y100  <= matrix4_tdata_dly4;//100x
        matrix_tdata_y_100 <= matrix2_tdata_dly4;//-100x
    
    end
    
//    //Gx
//    always@(posedge pixel_clk)
//    begin
//        if(matrix_tdata_x1 > matrix_tdata_x_1)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x1 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x1 <= matrix_tdata_x1 - matrix_tdata_x_1;
//            end
            
//        end
//        else
//        begin
//            matrix_tdata_abs_x1 <= matrix_tdata_x_1 - matrix_tdata_x1;
//        end
        
//        if(matrix_tdata_x4 > matrix_tdata_x_4)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x4 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x4 <= ((matrix_tdata_x4 - matrix_tdata_x_4)<<2);
//            end
            
            
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x4 <= ((matrix_tdata_x_4 - matrix_tdata_x4)<<2);
//        end
        
//        if(matrix_tdata_x5 > matrix_tdata_x_5)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x5 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x5 <= ((matrix_tdata_x5 - matrix_tdata_x_5)<<2) + (matrix_tdata_x5 - matrix_tdata_x_5);
//            end
            
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x5 <= ((matrix_tdata_x_5 - matrix_tdata_x5)<<2) + (matrix_tdata_x_5 - matrix_tdata_x5);
//        end
        
//        if(matrix_tdata_x6 > matrix_tdata_x_6)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x6 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x6 <= ((matrix_tdata_x6 - matrix_tdata_x_6)<<2) + ((matrix_tdata_x6 - matrix_tdata_x_6)<<1);
//            end
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x6 <= ((matrix_tdata_x_6 - matrix_tdata_x6)<<2) + ((matrix_tdata_x_6 - matrix_tdata_x6)<<1);
//        end
        
//        if(matrix_tdata_x15 > matrix_tdata_x_15)
//        begin
            
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x15 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x15 <= ((matrix_tdata_x15 - matrix_tdata_x_15)<<4) - (matrix_tdata_x15 - matrix_tdata_x_15);
//            end
            
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x15 <= ((matrix_tdata_x_15 - matrix_tdata_x15)<<4) - (matrix_tdata_x_15 - matrix_tdata_x15);
//        end
        
//        if(matrix_tdata_x20 > matrix_tdata_x_20)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x20 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x20 <= ((matrix_tdata_x20 - matrix_tdata_x_20)<<4) + ((matrix_tdata_x20 - matrix_tdata_x_20)<<2);
//            end
            
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x20 <= ((matrix_tdata_x_20 - matrix_tdata_x20)<<4) + ((matrix_tdata_x_20 - matrix_tdata_x20)<<2);
//        end
        
//        if(matrix_tdata_x24 > matrix_tdata_x_24)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x24 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x24 <= ((matrix_tdata_x24 - matrix_tdata_x_24)<<4) + ((matrix_tdata_x24 - matrix_tdata_x_24)<<3);
//            end
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x24 <= ((matrix_tdata_x_24 - matrix_tdata_x24)<<4) + ((matrix_tdata_x_24 - matrix_tdata_x24)<<3);
//        end
        
//        if(matrix_tdata_x30 > matrix_tdata_x_30)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x30 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x30 <= ((matrix_tdata_x30 - matrix_tdata_x_30)<<5) - ((matrix_tdata_x30 - matrix_tdata_x_30)<<1);
//            end
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x30 <= ((matrix_tdata_x_30 - matrix_tdata_x30)<<5) - ((matrix_tdata_x_30 - matrix_tdata_x30)<<1);
//        end
        
//        if(matrix_tdata_x60 > matrix_tdata_x_60)
//        begin
        
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x60 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x60 <= ((matrix_tdata_x60 - matrix_tdata_x_60)<<6) - ((matrix_tdata_x60 - matrix_tdata_x_60)<<2);
//            end
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x60 <= ((matrix_tdata_x_60 - matrix_tdata_x60)<<6) - ((matrix_tdata_x_60 - matrix_tdata_x60)<<2);
//        end
        
//        if(matrix_tdata_x75 > matrix_tdata_x_75)
//        begin
        
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x75 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x75 <= ((matrix_tdata_x75 - matrix_tdata_x_75)<<6) + ((matrix_tdata_x75 - matrix_tdata_x_75)<<3) + ((matrix_tdata_x75 - matrix_tdata_x_75)<<1) 
//                                      + ((matrix_tdata_x75 - matrix_tdata_x_75));
                
//            end
                                  
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x75 <= ((matrix_tdata_x_75 - matrix_tdata_x75)<<6) + ((matrix_tdata_x_75 - matrix_tdata_x75)<<3) + ((matrix_tdata_x_75 - matrix_tdata_x75)<<1)
//                                  + ((matrix_tdata_x_75 - matrix_tdata_x75));
//        end
        
//        if(matrix_tdata_x80 > matrix_tdata_x_80)
//        begin
        
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x80 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x80 <= ((matrix_tdata_x80 - matrix_tdata_x_80)<<6) + ((matrix_tdata_x80 - matrix_tdata_x_80)<<4) + ((matrix_tdata_x80 - matrix_tdata_x_80)<<3) 
//                                      + ((matrix_tdata_x80 - matrix_tdata_x_80)<<1);
            
//            end
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x80 <= ((matrix_tdata_x_80 - matrix_tdata_x80)<<6) + ((matrix_tdata_x_80 - matrix_tdata_x80)<<4) + ((matrix_tdata_x_80 - matrix_tdata_x80)<<3)
//                                  + ((matrix_tdata_x_80 - matrix_tdata_x80)<<1);
//        end
        
//        if(matrix_tdata_x100 > matrix_tdata_x_100)
//        begin
//            if(edge_sel == 1'b1)
//            begin
//                matrix_tdata_abs_x100 <= 19'd0;
//            end
//            else
//            begin
//                matrix_tdata_abs_x100 <= ((matrix_tdata_x100 - matrix_tdata_x_100)<<6) + ((matrix_tdata_x100 - matrix_tdata_x_100)<<5) + ((matrix_tdata_x100 - matrix_tdata_x_100)<<2);
//            end
            
//        end                   
//        else                  
//        begin                 
//            matrix_tdata_abs_x100 <= ((matrix_tdata_x_100 - matrix_tdata_x100)<<6) + ((matrix_tdata_x_100 - matrix_tdata_x100)<<5) + ((matrix_tdata_x_100 - matrix_tdata_x100)<<2);
//        end
        
//    end
    
    
    //Gx
    always@(posedge pixel_clk)
    begin
        if(matrix_tdata_x1 < matrix_tdata_x_1)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x1 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x1 <= matrix_tdata_x_1 - matrix_tdata_x1;
            end
            
        end
        else
        begin
            matrix_tdata_abs_x1 <= matrix_tdata_x1 - matrix_tdata_x_1;
        end
        
        if(matrix_tdata_x4 < matrix_tdata_x_4)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x4 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x4 <= ((matrix_tdata_x_4 - matrix_tdata_x4)<<2);
            end
            
            
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x4 <= ((matrix_tdata_x4 - matrix_tdata_x_4)<<2);
        end
        
        if(matrix_tdata_x5 < matrix_tdata_x_5)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x5 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x5 <= ((matrix_tdata_x_5 - matrix_tdata_x5)<<2) + (matrix_tdata_x_5 - matrix_tdata_x5);
            end
            
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x5 <= ((matrix_tdata_x5 - matrix_tdata_x_5)<<2) + (matrix_tdata_x5 - matrix_tdata_x_5);
        end
        
        if(matrix_tdata_x6 < matrix_tdata_x_6)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x6 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x6 <= ((matrix_tdata_x_6 - matrix_tdata_x6)<<2) + ((matrix_tdata_x_6 - matrix_tdata_x6)<<1);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x6 <= ((matrix_tdata_x6 - matrix_tdata_x_6)<<2) + ((matrix_tdata_x6 - matrix_tdata_x_6)<<1);
        end
        
        if(matrix_tdata_x15 < matrix_tdata_x_15)
        begin
            
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x15 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x15 <= ((matrix_tdata_x_15 - matrix_tdata_x15)<<4) - (matrix_tdata_x_15 - matrix_tdata_x15);
            end
            
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x15 <= ((matrix_tdata_x15 - matrix_tdata_x_15)<<4) - (matrix_tdata_x15 - matrix_tdata_x_15);
        end
        
        if(matrix_tdata_x20 < matrix_tdata_x_20)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x20 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x20 <= ((matrix_tdata_x_20 - matrix_tdata_x20)<<4) + ((matrix_tdata_x_20 - matrix_tdata_x20)<<2);
            end
            
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x20 <= ((matrix_tdata_x20 - matrix_tdata_x_20)<<4) + ((matrix_tdata_x20 - matrix_tdata_x_20)<<2);
        end
        
        if(matrix_tdata_x24 < matrix_tdata_x_24)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x24 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x24 <= ((matrix_tdata_x_24 - matrix_tdata_x24)<<4) + ((matrix_tdata_x_24 - matrix_tdata_x24)<<3);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x24 <= ((matrix_tdata_x24 - matrix_tdata_x_24)<<4) + ((matrix_tdata_x24 - matrix_tdata_x_24)<<3);
        end
        
        if(matrix_tdata_x30 < matrix_tdata_x_30)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x30 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x30 <= ((matrix_tdata_x_30 - matrix_tdata_x30)<<5) - ((matrix_tdata_x_30 - matrix_tdata_x30)<<1);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x30 <= ((matrix_tdata_x30 - matrix_tdata_x_30)<<5) - ((matrix_tdata_x30 - matrix_tdata_x_30)<<1);
        end
        
        if(matrix_tdata_x60 < matrix_tdata_x_60)
        begin
        
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x60 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x60 <= ((matrix_tdata_x_60 - matrix_tdata_x60)<<6) - ((matrix_tdata_x_60 - matrix_tdata_x60)<<2);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x60 <= ((matrix_tdata_x60 - matrix_tdata_x_60)<<6) - ((matrix_tdata_x60 - matrix_tdata_x_60)<<2);
        end
        
        if(matrix_tdata_x75 < matrix_tdata_x_75)
        begin
        
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x75 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x75 <= ((matrix_tdata_x_75 - matrix_tdata_x75)<<6) + ((matrix_tdata_x_75 - matrix_tdata_x75)<<3) + ((matrix_tdata_x_75 - matrix_tdata_x75)<<1) 
                                      + ((matrix_tdata_x_75 - matrix_tdata_x75));
                
            end
                                  
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x75 <= ((matrix_tdata_x75 - matrix_tdata_x_75)<<6) + ((matrix_tdata_x75 - matrix_tdata_x_75)<<3) + ((matrix_tdata_x75 - matrix_tdata_x_75)<<1)
                                  + ((matrix_tdata_x75 - matrix_tdata_x_75));
        end
        
        if(matrix_tdata_x80 < matrix_tdata_x_80)
        begin
        
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x80 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x80 <= ((matrix_tdata_x_80 - matrix_tdata_x80)<<6) + ((matrix_tdata_x_80 - matrix_tdata_x80)<<4) + ((matrix_tdata_x_80 - matrix_tdata_x80)<<3) 
                                      + ((matrix_tdata_x_80 - matrix_tdata_x80)<<1);
            
            end
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x80 <= ((matrix_tdata_x80 - matrix_tdata_x_80)<<6) + ((matrix_tdata_x80 - matrix_tdata_x_80)<<4) + ((matrix_tdata_x80 - matrix_tdata_x_80)<<3)
                                  + ((matrix_tdata_x80 - matrix_tdata_x_80)<<1);
        end
        
        if(matrix_tdata_x100 < matrix_tdata_x_100)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_x100 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_x100 <= ((matrix_tdata_x_100 - matrix_tdata_x100)<<6) + ((matrix_tdata_x_100 - matrix_tdata_x100)<<5) + ((matrix_tdata_x_100 - matrix_tdata_x100)<<2);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_x100 <= ((matrix_tdata_x100 - matrix_tdata_x_100)<<6) + ((matrix_tdata_x100 - matrix_tdata_x_100)<<5) + ((matrix_tdata_x100 - matrix_tdata_x_100)<<2);
        end
        
    end
    
    
    
    //Gy
    always@(posedge pixel_clk)
    begin
        if(matrix_tdata_y1 < matrix_tdata_y_1)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y1 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y1 <= matrix_tdata_y_1 - matrix_tdata_y1;
            end
        end
        else
        begin
            matrix_tdata_abs_y1 <= matrix_tdata_y1 - matrix_tdata_y_1;
        end
        
        if(matrix_tdata_y4 < matrix_tdata_y_4)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y4 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y4 <= ((matrix_tdata_y_4 - matrix_tdata_y4)<<2);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y4 <= ((matrix_tdata_y4 - matrix_tdata_y_4)<<2);
        end
        
        if(matrix_tdata_y5 < matrix_tdata_y_5)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y5 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y5 <= ((matrix_tdata_y_5 - matrix_tdata_y5)<<2) + (matrix_tdata_y_5 - matrix_tdata_y5);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y5 <= ((matrix_tdata_y5 - matrix_tdata_y_5)<<2) + (matrix_tdata_y5 - matrix_tdata_y_5);
        end
        
        if(matrix_tdata_y6 < matrix_tdata_y_6)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y6 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y6 <= ((matrix_tdata_y_6 - matrix_tdata_y6)<<2) + ((matrix_tdata_y_6 - matrix_tdata_y6)<<1);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y6 <= ((matrix_tdata_y6 - matrix_tdata_y_6)<<2) + ((matrix_tdata_y6 - matrix_tdata_y_6)<<1);
        end
        
        if(matrix_tdata_y15 < matrix_tdata_y_15)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y15 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y15 <= ((matrix_tdata_y_15 - matrix_tdata_y15)<<4) - (matrix_tdata_y_15 - matrix_tdata_y15);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y15 <= ((matrix_tdata_y15 - matrix_tdata_y_15)<<4) - (matrix_tdata_y15 - matrix_tdata_y_15);
        end
        
        if(matrix_tdata_y20 < matrix_tdata_y_20)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y20 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y20 <= ((matrix_tdata_y_20 - matrix_tdata_y20)<<4) + ((matrix_tdata_y_20 - matrix_tdata_y20)<<2);
            end
            
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y20 <= ((matrix_tdata_y20 - matrix_tdata_y_20)<<4) + ((matrix_tdata_y20 - matrix_tdata_y_20)<<2);
        end
        
        if(matrix_tdata_y24 < matrix_tdata_y_24)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y24 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y24 <= ((matrix_tdata_y_24 - matrix_tdata_y24)<<4) + ((matrix_tdata_y_24 - matrix_tdata_y24)<<3);
            end
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y24 <= ((matrix_tdata_y24 - matrix_tdata_y_24)<<4) + ((matrix_tdata_y24 - matrix_tdata_y_24)<<3);
        end
        
        if(matrix_tdata_y30 < matrix_tdata_y_30)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y30 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y30 <= ((matrix_tdata_y_30 - matrix_tdata_y30)<<5) - ((matrix_tdata_y_30 - matrix_tdata_y30)<<1);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y30 <= ((matrix_tdata_y30 - matrix_tdata_y_30)<<5) - ((matrix_tdata_y30 - matrix_tdata_y_30)<<1);
        end
        
        if(matrix_tdata_y60 < matrix_tdata_y_60)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y60 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y60 <= ((matrix_tdata_y_60 - matrix_tdata_y60)<<6) - ((matrix_tdata_y_60 - matrix_tdata_y60)<<2);
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y60 <= ((matrix_tdata_y60 - matrix_tdata_y_60)<<6) - ((matrix_tdata_y60 - matrix_tdata_y_60)<<2);
        end
        
        if(matrix_tdata_y75 < matrix_tdata_y_75)
        begin
       
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y75 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y75 <= ((matrix_tdata_y_75 - matrix_tdata_y75)<<6) + ((matrix_tdata_y_75 - matrix_tdata_y75)<<3) + ((matrix_tdata_y_75 - matrix_tdata_y75)<<1) 
                                      + ((matrix_tdata_y_75 - matrix_tdata_y75));
            
            end

       
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y75 <= ((matrix_tdata_y75 - matrix_tdata_y_75)<<6) + ((matrix_tdata_y75 - matrix_tdata_y_75)<<3) + ((matrix_tdata_y75 - matrix_tdata_y_75)<<1)
                                  + ((matrix_tdata_y75 - matrix_tdata_y_75));
        end
        
        if(matrix_tdata_y80 < matrix_tdata_y_80)
        begin
                                  
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y80 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y80 <= ((matrix_tdata_y_80 - matrix_tdata_y80)<<6) + ((matrix_tdata_y_80 - matrix_tdata_y80)<<4) + ((matrix_tdata_y_80 - matrix_tdata_y80)<<3) 
                                      + ((matrix_tdata_y_80 - matrix_tdata_y80)<<1);
            
            end
                                  
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y80 <= ((matrix_tdata_y80 - matrix_tdata_y_80)<<6) + ((matrix_tdata_y80 - matrix_tdata_y_80)<<4) + ((matrix_tdata_y80 - matrix_tdata_y_80)<<3)
                                  + ((matrix_tdata_y80 - matrix_tdata_y_80)<<1);
        end
        
        if(matrix_tdata_y100 < matrix_tdata_y_100)
        begin
            if(edge_sel == 1'b1)
            begin
                matrix_tdata_abs_y100 <= 19'd0;
            end
            else
            begin
                matrix_tdata_abs_y100 <= ((matrix_tdata_y_100 - matrix_tdata_y100)<<6) + ((matrix_tdata_y_100 - matrix_tdata_y100)<<5) + ((matrix_tdata_y_100 - matrix_tdata_y100)<<2);
            
            end
            
        end                   
        else                  
        begin                 
            matrix_tdata_abs_y100 <= ((matrix_tdata_y100 - matrix_tdata_y_100)<<6) + ((matrix_tdata_y100 - matrix_tdata_y_100)<<5) + ((matrix_tdata_y100 - matrix_tdata_y_100)<<2);
        end
        
    end
    
    always@(posedge pixel_clk)
    begin
        Gx_out <= matrix_tdata_abs_x1 + matrix_tdata_abs_x4 + matrix_tdata_abs_x5 + matrix_tdata_abs_x6 + matrix_tdata_abs_x15 + matrix_tdata_abs_x20
                + matrix_tdata_abs_x24 + matrix_tdata_abs_x30 + matrix_tdata_abs_x60 + matrix_tdata_abs_x75 + matrix_tdata_abs_x80 + matrix_tdata_abs_x100;
                
        Gy_out <= matrix_tdata_abs_y1 + matrix_tdata_abs_y4 + matrix_tdata_abs_y5 + matrix_tdata_abs_y6 + matrix_tdata_abs_y15 + matrix_tdata_abs_y20
                        + matrix_tdata_abs_y24 + matrix_tdata_abs_y30 + matrix_tdata_abs_y60 + matrix_tdata_abs_y75 + matrix_tdata_abs_y80 + matrix_tdata_abs_y100;
        
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
            if(s_axis_tlast_dly7 == 1'b1)
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
        if(s_axis_tlast_dly7 == 1'b1)
        begin
            pixel_count <= 12'd0;
        end
        else
        begin
            if(s_axis_tvalid_dly7 == 1'b1)
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
        if(((line_count > 10'd2) && (line_count < (IMG_HEIGHT - 10'd3)))
         &&((pixel_count > 10'd2) && (pixel_count < (IMG_WIDTH - 10'd3))))
        begin
            Gx_out_reg <= Gx_out;
            Gy_out_reg <= Gy_out;  
            tdata_out_reg <= Gx_out + Gy_out;      
        end
        else
        begin
            Gx_out_reg      <= 22'd0;
            Gy_out_reg      <= 22'd0;  
            tdata_out_reg   <= 22'd0;  
        end
    end
 
    always@(posedge pixel_clk)
    begin
        tlast_out_reg      <= s_axis_tlast_dly7 ; 
        tuser_out_reg      <= s_axis_tuser_dly7 ; 
        tvalid_out_reg     <= s_axis_tvalid_dly7; 
        tdata_raw_out_reg  <= matrix3_tdata_dly7;  
    end   

endmodule
