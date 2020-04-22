`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 15:39:59
// Design Name: 
// Module Name: bayer2rgb
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


module bayer2rgb    
    #(
        parameter DATA_WIDTH = 10,
        parameter RGB_WIDTH  = 10,
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        (*mark_debug="true"*)input       pixel_clk    ,
        (*mark_debug="true"*)input       s_axis_tlast ,
        (*mark_debug="true"*)input       s_axis_tuser ,
        (*mark_debug="true"*)input       s_axis_tvalid,   
        (*mark_debug="true"*)input[DATA_WIDTH - 1:0]  matrix_data01, 
        (*mark_debug="true"*)input[DATA_WIDTH - 1:0]  matrix_data11, 
        (*mark_debug="true"*)input[DATA_WIDTH - 1:0]  matrix_data21,
        (*mark_debug="true"*)input[1:0]  bayerType      ,
        
        (*mark_debug="true"*)output      m_axis_tlast ,
        (*mark_debug="true"*)output      m_axis_tuser ,
        (*mark_debug="true"*)output      m_axis_tvalid ,   
        (*mark_debug="true"*)output[RGB_WIDTH - 1:0] m_axis_tdata  // R= m_axis_tdata[7:0],G= m_axis_tdata[15:8],B= m_axis_tdata[23:16],
        
    );
    localparam BGGR = 2'b00,GBRG = 2'b01,GRBG = 2'b10,RGGB = 2'b11;
    reg[1:0] bayer_type = BGGR;
    reg       s_axis_tlast_dly1 ,s_axis_tlast_dly2 ,s_axis_tlast_dly3 ,s_axis_tlast_dly4 ,s_axis_tlast_dly5 ,s_axis_tlast_dly6 ,s_axis_tlast_dly7 ;
    reg       s_axis_tuser_dly1 ,s_axis_tuser_dly2 ,s_axis_tuser_dly3 ,s_axis_tuser_dly4 ,s_axis_tuser_dly5 ,s_axis_tuser_dly6 ,s_axis_tuser_dly7 ;
    reg       s_axis_tvalid_dly1,s_axis_tvalid_dly2,s_axis_tvalid_dly3,s_axis_tvalid_dly4,s_axis_tvalid_dly5,s_axis_tvalid_dly6,s_axis_tvalid_dly7;   
    reg[DATA_WIDTH - 1:0]  matrix_data01_dly1, matrix_data01_dly2, matrix_data01_dly3; 
    reg[DATA_WIDTH - 1:0]  matrix_data11_dly1, matrix_data11_dly2, matrix_data11_dly3; 
    reg[DATA_WIDTH - 1:0]  matrix_data21_dly1, matrix_data21_dly2, matrix_data21_dly3;
    
    reg[DATA_WIDTH - 1:0]    matrix0_data00,matrix0_data01,matrix0_data02,
                             matrix0_data10,matrix0_data11,matrix0_data12,
                             matrix0_data20,matrix0_data21,matrix0_data22; 
                             
    reg[DATA_WIDTH - 1:0]    matrix1_data00,matrix1_data01,matrix1_data02,
                             matrix1_data10,matrix1_data11,matrix1_data12,
                             matrix1_data20,matrix1_data21,matrix1_data22;    
    
    reg[DATA_WIDTH + 1:0]    data00,data01,data02,
                             data10,data11,data12,
                             data20,data21,data22;
    reg[RGB_WIDTH-1:0] dataout; 
    
    reg[RGB_WIDTH-1:0] RGB_reg; // 按RGB 顺序放
    reg G_odd = 1'b0,G_even= 1'b0;
    reg[11:0] line_cout = 12'd0;
    reg[11:0] pixels_cout = 12'd0;
    reg tmp_odd  = 1'b0;
    reg line_odd = 1'b0;
    reg tvalid = 1'b0;
    reg[DATA_WIDTH - 1:0] data_reg0,data_reg1,data_reg2;
    reg G_flg;
    
    assign m_axis_tlast  = s_axis_tlast_dly7 ;
    assign m_axis_tuser  = s_axis_tuser_dly7 ;
    assign m_axis_tvalid = s_axis_tvalid_dly7;   
    assign m_axis_tdata  = RGB_reg           ;// R= m_axis_tdata[7:0],G= m_axis_tdata[15:8],B= m_axis_tdata[23:16],
    
    always@(posedge pixel_clk)
    begin

       {s_axis_tlast_dly7 ,s_axis_tlast_dly6 ,s_axis_tlast_dly5 ,s_axis_tlast_dly4 ,s_axis_tlast_dly3 ,s_axis_tlast_dly2 ,s_axis_tlast_dly1}   
       <={s_axis_tlast_dly6 ,s_axis_tlast_dly5 ,s_axis_tlast_dly4 ,s_axis_tlast_dly3 ,s_axis_tlast_dly2 ,s_axis_tlast_dly1,s_axis_tlast};
       
       {s_axis_tuser_dly7 ,s_axis_tuser_dly6 ,s_axis_tuser_dly5 ,s_axis_tuser_dly4 ,s_axis_tuser_dly3 ,s_axis_tuser_dly2 ,s_axis_tuser_dly1}   
       <={s_axis_tuser_dly6 ,s_axis_tuser_dly5 ,s_axis_tuser_dly4 ,s_axis_tuser_dly3 ,s_axis_tuser_dly2 ,s_axis_tuser_dly1,s_axis_tuser};
       
       {s_axis_tvalid_dly7,s_axis_tvalid_dly6 ,s_axis_tvalid_dly5 ,s_axis_tvalid_dly4,s_axis_tvalid_dly3 ,s_axis_tvalid_dly2 ,s_axis_tvalid_dly1}
       <={s_axis_tvalid_dly6 ,s_axis_tvalid_dly5 ,s_axis_tvalid_dly4,s_axis_tvalid_dly3,s_axis_tvalid_dly2 ,s_axis_tvalid_dly1,s_axis_tvalid};

       {matrix_data01_dly3 ,matrix_data01_dly2 ,matrix_data01_dly1}<={matrix_data01_dly2 ,matrix_data01_dly1,matrix_data01};
       {matrix_data11_dly3 ,matrix_data11_dly2 ,matrix_data11_dly1}<={matrix_data11_dly2 ,matrix_data11_dly1,matrix_data11};
       {matrix_data21_dly3 ,matrix_data21_dly2 ,matrix_data21_dly1}<={matrix_data21_dly2 ,matrix_data21_dly1,matrix_data21};
        
        bayer_type <= bayerType;
        
    end
    
                                    
    
    //行计数
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser_dly1 == 1'b1)
        begin
            line_cout <= 12'd1;
        end
        else
        begin
            if(s_axis_tlast_dly3 == 1'b1)
            begin
                line_cout <= line_cout + 1'b1;
            end
            else
            begin
                line_cout <= line_cout;
            end
        end
    end
    
    //列计数
    always@(posedge pixel_clk)
    begin
        if(s_axis_tvalid_dly3 == 1'b1)
        begin
            pixels_cout <= pixels_cout + 1'b1;
        end
        else
        begin
            pixels_cout <= 12'd0;
        end
    end
    
    //边界处理之行复制
    always@(posedge pixel_clk)
    begin
        if(line_cout == 12'b1)
        begin
            {matrix0_data00,matrix0_data01,matrix0_data02} <= {matrix_data21_dly3 ,matrix_data21_dly2 ,matrix_data21_dly1};
            {matrix0_data10,matrix0_data11,matrix0_data12} <= {matrix_data11_dly3 ,matrix_data11_dly2 ,matrix_data11_dly1};
            {matrix0_data20,matrix0_data21,matrix0_data22} <= {matrix_data21_dly3 ,matrix_data21_dly2 ,matrix_data21_dly1};
        end
        else if(line_cout == IMG_HEIGHT)
        begin
            {matrix0_data00,matrix0_data01,matrix0_data02} <= {matrix_data01_dly3 ,matrix_data01_dly2 ,matrix_data01_dly1};
            {matrix0_data10,matrix0_data11,matrix0_data12} <= {matrix_data11_dly3 ,matrix_data11_dly2 ,matrix_data11_dly1};
            {matrix0_data20,matrix0_data21,matrix0_data22} <= {matrix_data01_dly3 ,matrix_data01_dly2 ,matrix_data01_dly1};
        end
        else
        begin
            {matrix0_data00,matrix0_data01,matrix0_data02} <= {matrix_data01_dly3 ,matrix_data01_dly2 ,matrix_data01_dly1};
            {matrix0_data10,matrix0_data11,matrix0_data12} <= {matrix_data11_dly3 ,matrix_data11_dly2 ,matrix_data11_dly1};
            {matrix0_data20,matrix0_data21,matrix0_data22} <= {matrix_data21_dly3 ,matrix_data21_dly2 ,matrix_data21_dly1};
        end
    end    
    
    //边界处理之列复制
    always@(posedge pixel_clk)
    begin
        if(pixels_cout == 12'd0)
        begin
            {matrix1_data00,matrix1_data01,matrix1_data02} <= {matrix0_data02,matrix0_data01,matrix0_data02};
            {matrix1_data10,matrix1_data11,matrix1_data12} <= {matrix0_data12,matrix0_data11,matrix0_data12};
            {matrix1_data20,matrix1_data21,matrix1_data22} <= {matrix0_data22,matrix0_data21,matrix0_data22};
        
        end
        else if(pixels_cout == IMG_WIDTH - 1'b1)
        begin
            {matrix1_data00,matrix1_data01,matrix1_data02} <= {matrix0_data00,matrix0_data01,matrix0_data00};
            {matrix1_data10,matrix1_data11,matrix1_data12} <= {matrix0_data10,matrix0_data11,matrix0_data10};
            {matrix1_data20,matrix1_data21,matrix1_data22} <= {matrix0_data20,matrix0_data21,matrix0_data20};
        
        end
        else
        begin
            {matrix1_data00,matrix1_data01,matrix1_data02} <= {matrix0_data00,matrix0_data01,matrix0_data02};
            {matrix1_data10,matrix1_data11,matrix1_data12} <= {matrix0_data10,matrix0_data11,matrix0_data12};
            {matrix1_data20,matrix1_data21,matrix1_data22} <= {matrix0_data20,matrix0_data21,matrix0_data22};
        
        end
    end
    
    //bayer2rgb 数据输入控制
    always@(posedge pixel_clk)
    begin
        {data00,data01,data02} <= {2'b00,matrix1_data00,2'b00,matrix1_data01,2'b00,matrix1_data02};
        {data10,data11,data12} <= {2'b00,matrix1_data10,2'b00,matrix1_data11,2'b00,matrix1_data12};
        {data20,data21,data22} <= {2'b00,matrix1_data20,2'b00,matrix1_data21,2'b00,matrix1_data22};
        
        tmp_odd  <= line_cout%2;  //奇偶行判断 
        line_odd <= tmp_odd;
        tvalid   <= s_axis_tvalid_dly4;        
        
    end


    
    always@(posedge pixel_clk)
    begin
        case(bayer_type)
            BGGR:
            begin
                G_odd <= 1'b0;
                G_even<= 1'b1;
                bayer2rgb;
                RGB_reg <= (line_odd == 1'b1)?{data_reg2,data_reg1,data_reg0}
                                             :{data_reg0,data_reg1,data_reg2}; 
            end
            GBRG:
            begin
                G_odd <= 1'b1;
                G_even<= 1'b0;
                bayer2rgb;
                RGB_reg <= (line_odd == 1'b1)?{data_reg2,data_reg1,data_reg0}
                                             :{data_reg0,data_reg1,data_reg2}; 

            end
            GRBG:
            begin
                G_odd <= 1'b1;
                G_even<= 1'b0;
                bayer2rgb;
                RGB_reg <= (line_odd == 1'b0)?{data_reg2,data_reg1,data_reg0}
                                             :{data_reg0,data_reg1,data_reg2}; 
                                            
            end
            
            RGGB:
            begin
                G_odd <= 1'b0;
                G_even<= 1'b1;
                bayer2rgb;
                RGB_reg <= (line_odd == 1'b0)?{data_reg2,data_reg1,data_reg0}
                                             :{data_reg0,data_reg1,data_reg2}; 
            end
            default:;    
        endcase
    end
    
    
//根据data10,data11,data12,中R,G,B排列方式来计算输出
//G_flg = 1：当前bayer 为G;
//G_flg = 0：当前bayer 为或者B;
//G_odd 是G_flg奇数行初始值
//G_even 是G_flg偶数行初始值
 task bayer2rgb; 
     begin
        case(tvalid)
            1'b0:
            begin
                case(line_odd)
                    1'b0:
                    begin
                        G_flg <= G_even;    
                    end
                    
                    1'b1:
                    begin
                        G_flg <= G_odd; 
                    end
                    default:;
                endcase
            end
            
            1'b1:
            begin
                G_flg <= ~G_flg;
                case(G_flg)
                    1'b0:
                    begin
                        data_reg0 <=   data11;                                 
                        data_reg1 <=  (data01 + data10 + data21 + data12) >> 2;
                        data_reg2 <=  (data00 + data02 + data20 + data22) >> 2;
                    end
                    
                    1'b1:
                    begin
                        data_reg0 <=  (data10 + data12)>> 1;  
                        data_reg1 <=  data11;                 
                        data_reg2 <=  (data01 + data21)>> 1;  
                    end
                    default:;
                endcase 
            end
            default:;
        endcase
     end
 endtask
    
    
endmodule
