`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/30 13:58:45
// Design Name: 
// Module Name: sobel3x3_algorithm
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
//      -1   0   1            -1  -2  -1
// Gx = -2   0   2      Gy =  0   0   0
//      -1   0   1            1   2   1

//////////////////////////////////////////////////////////////////////////////////


module sobel3x3_algorithm
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk       ,
        input       edge_selelct    ,
        input[7:0]  threshold       ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        
        input[DATA_WIDTH-1:0]  matrix0_tdata    ,
        input[DATA_WIDTH-1:0]  matrix1_tdata    ,
        input[DATA_WIDTH-1:0]  matrix2_tdata    ,
        
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[DATA_WIDTH-1:0] m_axis_Gxdata,
        output[DATA_WIDTH-1:0] m_axis_Gydata,
        output[DATA_WIDTH-1:0] m_axis_tdata,

        output[DATA_WIDTH-1:0] m_axis_raw_tdata      
     );
     
//     localparam X1 = 2'd1,X2 = 2'd2,X3 = 2'd1;
//     localparam Y1 = 2'd1,Y2 = 2'd2,Y3 = 2'd1;
     
     reg                    s_axis_tlast_dly1 ,s_axis_tlast_dly2 ,s_axis_tlast_dly3 ,s_axis_tlast_dly4 ,s_axis_tlast_dly5 ,s_axis_tlast_dly6 ;
     reg                    s_axis_tuser_dly1 ,s_axis_tuser_dly2 ,s_axis_tuser_dly3 ,s_axis_tuser_dly4 ,s_axis_tuser_dly5 ,s_axis_tuser_dly6 ;
     reg                    s_axis_tvalid_dly1,s_axis_tvalid_dly2,s_axis_tvalid_dly3,s_axis_tvalid_dly4,s_axis_tvalid_dly5,s_axis_tvalid_dly6;
     reg[DATA_WIDTH-1:0]    matrix0_tdata_dly1,matrix0_tdata_dly2,matrix0_tdata_dly3 ;
     reg[DATA_WIDTH-1:0]    matrix1_tdata_dly1,matrix1_tdata_dly2,matrix1_tdata_dly3,matrix1_tdata_dly4,matrix1_tdata_dly5,matrix1_tdata_dly6 ;
     reg[DATA_WIDTH-1:0]    matrix2_tdata_dly1,matrix2_tdata_dly2,matrix2_tdata_dly3 ;
     
     reg[DATA_WIDTH+1:0]    G_out,Gx_out,Gy_out,Gx_abs,Gx1,Gx2,Gy_abs,Gy1,Gy2;
     reg                    tlast_out_reg,tuser_out_reg,tvalid_out_reg;
     reg[DATA_WIDTH+2:0]    tdata_out_reg,Gxdata_out_reg,Gydata_out_reg;
    
     reg[DATA_WIDTH-1:0]    tdata_raw_out_reg;
     
     reg[11:0] pixel_count = 12'd0;
     reg[11:0] line_count  = 12'd0;  
     
     reg    edge_sel;
      
     
     assign m_axis_tlast  = tlast_out_reg  ;
     assign m_axis_tuser  = tuser_out_reg  ;
     assign m_axis_tvalid = tvalid_out_reg ;
     assign m_axis_raw_tdata = tdata_raw_out_reg ;
//     assign m_axis_tdata      =  (tdata_out_reg  > 10'd1023 )? 10'd1023:tdata_out_reg;
     assign m_axis_Gxdata     =  (Gxdata_out_reg > 10'd255 )? 10'd255:Gxdata_out_reg;
     assign m_axis_Gydata     =  (Gydata_out_reg > 10'd255 )? 10'd255:Gydata_out_reg;
     assign m_axis_tdata      =  (tdata_out_reg  > 10'd255 )? 10'd255:tdata_out_reg;
     
     always@(posedge pixel_clk)
     begin
        edge_sel  <= edge_selelct;
        
        s_axis_tlast_dly1 <= s_axis_tlast  ;
        s_axis_tlast_dly2 <= s_axis_tlast_dly1  ;
        s_axis_tlast_dly3 <= s_axis_tlast_dly2  ;
        s_axis_tlast_dly4 <= s_axis_tlast_dly3  ;
        s_axis_tlast_dly5 <= s_axis_tlast_dly4  ;
        s_axis_tlast_dly6 <= s_axis_tlast_dly5  ;
        
        s_axis_tuser_dly1 <= s_axis_tuser  ;
        s_axis_tuser_dly2 <= s_axis_tuser_dly1  ;
        s_axis_tuser_dly3 <= s_axis_tuser_dly2  ;
        s_axis_tuser_dly4 <= s_axis_tuser_dly3  ;
        s_axis_tuser_dly5 <= s_axis_tuser_dly4  ;
        s_axis_tuser_dly6 <= s_axis_tuser_dly5  ;
        
        s_axis_tvalid_dly1<= s_axis_tvalid ;
        s_axis_tvalid_dly2<= s_axis_tvalid_dly1 ;
        s_axis_tvalid_dly3<= s_axis_tvalid_dly2 ;
        s_axis_tvalid_dly4<= s_axis_tvalid_dly3 ;
        s_axis_tvalid_dly5<= s_axis_tvalid_dly4 ;
        s_axis_tvalid_dly6<= s_axis_tvalid_dly5 ;
        
        matrix0_tdata_dly1<= matrix0_tdata ;
        matrix0_tdata_dly2<= matrix0_tdata_dly1 ;
        matrix0_tdata_dly3<= matrix0_tdata_dly2 ;
        
        matrix1_tdata_dly1<= matrix1_tdata ;
        matrix1_tdata_dly2<= matrix1_tdata_dly1 ;
        matrix1_tdata_dly3<= matrix1_tdata_dly2 ;
        matrix1_tdata_dly4<= matrix1_tdata_dly3 ;
        matrix1_tdata_dly5<= matrix1_tdata_dly4 ;
        matrix1_tdata_dly6<= matrix1_tdata_dly5 ;
        
        matrix2_tdata_dly1<= matrix2_tdata ;
        matrix2_tdata_dly2<= matrix2_tdata_dly1 ;        
        matrix2_tdata_dly3<= matrix2_tdata_dly2 ;        
        
     end
     
     always@(posedge pixel_clk)
     begin
        if(s_axis_tuser_dly1 == 1'b1)
        begin
            line_count <= 10'd0;    
        end
        else
        begin
            if(s_axis_tlast_dly5 == 1'b1)
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
        if(s_axis_tlast_dly5 == 1'b1)
        begin
            pixel_count <= 12'd0;
        end
        else
        begin
            if(s_axis_tvalid_dly5 == 1'b1)
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
        Gx1 <=  matrix0_tdata_dly1 + (matrix1_tdata_dly1<<1) + matrix2_tdata_dly1;
        Gx2 <=  matrix0_tdata_dly3 + (matrix1_tdata_dly3<<1) + matrix2_tdata_dly3;
        Gy1 <=  matrix0_tdata_dly1 + (matrix0_tdata_dly2<<1) + matrix0_tdata_dly3;
        Gy2 <=  matrix2_tdata_dly1 + (matrix2_tdata_dly2<<1) + matrix2_tdata_dly3;
     end
     
     always@(posedge pixel_clk)
     begin
     
//        if(Gx1 > Gx2)
//        begin
//            //Gx_abs <= Gx1 - Gx2;     
//            if(edge_sel == 1'b1)
//            begin
//                Gx_abs <= 11'd0;     
//            end
//            else
//            begin
//                Gx_abs <= Gx1 - Gx2;     
//            end
//        end
//        else
//        begin
//            Gx_abs <= Gx2 - Gx1;     
//        end
        
        if(Gx1 < Gx2)
        begin
            //Gx_abs <= Gx1 - Gx2;     
            if(edge_sel == 1'b1)
            begin
                Gx_abs <= 11'd0;     
            end
            else
            begin
                Gx_abs <= Gx2 - Gx1;     
            end
        end
        else
        begin
            Gx_abs <= Gx1 - Gx2;     
        end
        
        
     end
     
     always@(posedge pixel_clk)
     begin
        if(Gy1 > Gy2)
        begin
//            Gy_abs <= Gy1 - Gy2;
            if(edge_sel == 1'b1)
            begin
                Gy_abs <= 11'd0;     
            end
            else
            begin
                Gy_abs <= Gy1 - Gy2;     
            end

        end
        else
        begin
            Gy_abs <= Gy2 - Gy1;
        end
     end
     
     always@(posedge pixel_clk)
     begin
        Gx_out <= Gx_abs;
        Gy_out <= Gy_abs;
        G_out  <= Gy_abs + Gx_abs;
     end
     
    
    always@(posedge pixel_clk)
    begin
        if((line_count > 0) && (line_count < (IMG_HEIGHT - 1)) 
        && (pixel_count >0) && (pixel_count < (IMG_WIDTH - 1)))
        begin
             tdata_out_reg  <= G_out;
             Gxdata_out_reg <= Gx_out;
             Gydata_out_reg <= Gy_out;
        end
        else
        begin
             tdata_out_reg  <= 10'd0;
             Gxdata_out_reg <= 10'd0;
             Gydata_out_reg <= 10'd0;

        end
    end
    
    always@(posedge pixel_clk)
    begin
        tlast_out_reg <= s_axis_tlast_dly5 ;
        tuser_out_reg <= s_axis_tuser_dly5 ;
        tvalid_out_reg<= s_axis_tvalid_dly5;
        tdata_raw_out_reg <= matrix1_tdata_dly5; 
    end
     
     
endmodule
