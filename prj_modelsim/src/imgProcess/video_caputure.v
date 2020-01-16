`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/08 15:06:46
// Design Name: 
// Module Name: video_caputure
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


    module video_caputure 
    #(
        parameter DATA_WIDTH = 64,
		parameter IMG_WIDTH = 640
    )

    (

        input   vsync     ,
        input   s_axis_aclk,
        output  s_axis_tready,
        input  [DATA_WIDTH-1 : 0] s_axis_tdata,
        input  [(DATA_WIDTH/8)-1 : 0] s_axis_tkeep,
        input   s_axis_tlast,
        input   s_axis_tvalid,		
		
		
	
        output  [DATA_WIDTH - 1 : 0 ] m_axis_tdata ,
        output           m_axis_tlast ,
        output           m_axis_tuser ,
        output           m_axis_tvalid,
        input            m_axis_tready   
    );
        reg[11:0]     row_pixels_count = 12'd0;
        reg           tlast_tmp;
        reg           tuser_tmp ;
        wire          tuser;

        
        assign s_axis_tready = m_axis_tready;
        assign m_axis_tdata = s_axis_tdata; 
        assign m_axis_tlast = tlast_tmp; 
        assign m_axis_tuser =(tuser_tmp & s_axis_tvalid); 
        assign m_axis_tvalid = s_axis_tvalid;   
        
        //generate tuser
        always @(posedge s_axis_aclk)
        begin
            if(vsync == 1)
                begin
                    tuser_tmp <= 1'b1;    
                end
            else if(s_axis_tvalid == 1)
                begin
                    tuser_tmp <= 1'b0;
                end
            else
                begin
                    tuser_tmp <= tuser_tmp;
                end
                 
        end
         
        //count row pixels
        always @(posedge s_axis_aclk)
        begin
            if(vsync == 1 )
                begin
                    row_pixels_count <= 12'd0;
                end
            else if((s_axis_tvalid == 1) && (m_axis_tready == 1))
                begin
                    if(row_pixels_count < (IMG_WIDTH - 1))
                    begin
                        row_pixels_count <= row_pixels_count + 1; 
                    end
                    else
                    begin
                        row_pixels_count <= 12'd0;
                    end
                    //row_pixels_count <= row_pixels_count + 1; 
                end
            else
                begin
                    //row_pixels_count <= 12'd0;
                    row_pixels_count <= row_pixels_count;
                end
        end
        
        //genrate tlast
        always @(posedge s_axis_aclk)
        begin
            if(row_pixels_count == (IMG_WIDTH - 2))//(reg_img_width - 2)
                begin
                    tlast_tmp <= 1'b1;
                end
            else
                begin
                    tlast_tmp <= 1'b0;
                end
        end
                      
endmodule
