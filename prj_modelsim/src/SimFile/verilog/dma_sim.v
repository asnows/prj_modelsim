`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/16 09:30:53
// Design Name: 
// Module Name: dma_sim
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


module dma_sim
#(
    parameter integer S_AXIS_MM2S_TDATA_WIDTH    = 32,
    parameter integer S_AXIS_CNTRL_TDATA_WIDTH    = 32,
    parameter integer M_AXIS_S2MM_TDATA_WIDTH    = 32,
    parameter integer M_AXIS_STS_TDATA_WIDTH    = 32
)
(

    input   m_axis_mm2s_aclk,
    input   m_axis_mm2s_aresetn,
    input   [M_AXIS_S2MM_TDATA_WIDTH-1 : 0] sim_dataIn,
    
//    input  s_axis_s2mm_tvalid,
//    input  [M_AXIS_S2MM_TDATA_WIDTH-1 : 0] s_axis_s2mm_tdata,
//    input  [(M_AXIS_S2MM_TDATA_WIDTH/8)-1 : 0] s_axis_s2mm_tkeep,
//    input  s_axis_s2mm_tlast,
//    output s_axis_s2mm_tready,
    

//    input  s_axis_sts_tvalid,
//    input  [M_AXIS_STS_TDATA_WIDTH-1 : 0] s_axis_sts_tdata,
//    input  [(M_AXIS_STS_TDATA_WIDTH/8)-1 : 0] s_axis_sts_tkeep,
//    input  s_axis_sts_tlast,
//    output s_axis_sts_tready,
    
    input  m_axis_mm2s_tready,
    output  [S_AXIS_MM2S_TDATA_WIDTH-1 : 0] m_axis_mm2s_tdata,
    output  [(S_AXIS_MM2S_TDATA_WIDTH/8)-1 : 0] m_axis_mm2s_tkeep,
    output   m_axis_mm2s_tlast,
    output   m_axis_mm2s_tvalid,
    
    input  m_axis_cntrl_tready,
    output  [S_AXIS_CNTRL_TDATA_WIDTH-1 : 0] m_axis_cntrl_tdata,
    output  [(S_AXIS_CNTRL_TDATA_WIDTH/8)-1 : 0] m_axis_cntrl_tkeep,
    output   m_axis_cntrl_tlast,
    output   m_axis_cntrl_tvalid

);
    
    
    localparam STATE_cntrl = 2'd0,STATE_mm2s = 2'd1;//STATE_mm2s = 2'd2;
    localparam DATA64_NUM = 250;
    
    localparam IMG_HEIGHT = 480;
    localparam IMG_WIDTH =640;
    localparam FUNSEL = 0;
    localparam IMG_BYTES = IMG_HEIGHT*IMG_WIDTH;
    
    
    reg[1:0] state = 2'd0;
    reg[7:0] count = 8'd0;
    reg[31:0] count2 = 32'd0;
    

    reg  [S_AXIS_MM2S_TDATA_WIDTH-1 : 0] m_axis_mm2s_tdata_reg;
    reg   m_axis_mm2s_tvalid_reg;
    

   reg  [S_AXIS_CNTRL_TDATA_WIDTH-1 : 0] m_axis_cntrl_tdata_reg;
   reg   m_axis_cntrl_tlast_reg;
   reg   m_axis_cntrl_tvalid_reg;
   

    assign   m_axis_mm2s_tdata =  m_axis_mm2s_tdata_reg ;
    assign   m_axis_mm2s_tkeep =  8'hff ;
    assign   m_axis_mm2s_tlast =  1'b0 ;
    assign   m_axis_mm2s_tvalid=  m_axis_mm2s_tvalid_reg;
   

    assign  m_axis_cntrl_tdata = m_axis_cntrl_tdata_reg;
    assign  m_axis_cntrl_tkeep = 4'hf;
    assign  m_axis_cntrl_tlast =m_axis_cntrl_tlast_reg ;
    assign  m_axis_cntrl_tvalid=m_axis_cntrl_tvalid_reg;

   
   

        
    always@(posedge m_axis_mm2s_aclk )
    begin
        if(!m_axis_mm2s_aresetn)
        begin
            state <= STATE_cntrl;
            count <= 8'd0;
        end
        else
        begin
            case(state)
               STATE_cntrl:
               begin
                    if(count < 8'd6)
                    begin
                        count <= count + 1'b1;
                    end
                    else
                    begin
                        count <= 8'd0;
                        state <= STATE_mm2s;
                    end                                       
               end 
               STATE_mm2s:
               begin
               
//                    if(count < 128)
//                    begin
//                        count <= count + 1'b1;
//                    end
//                    else
//                    begin
//                        count <= 8'd0;
//                        state <= STATE_cntrl;
//                    end
                    if(count2 < IMG_BYTES)
                    begin 
                        count <= count + 1'b1;
                    end
                    else
                    begin
                        count <= 8'hff;
                    end
            

               end             
            endcase
        end
    end
    
    
    always@(posedge m_axis_mm2s_aclk)
    begin
    if(!m_axis_mm2s_aresetn)
    begin
        m_axis_cntrl_tvalid_reg <= 1'b0;
    end
    else
    begin
        case(state)
            STATE_cntrl:
            begin
            m_axis_cntrl_tvalid_reg <= 1'b1;
            count2 <= 32'd0;
                case(count)
                    8'd0:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b0;
                        m_axis_cntrl_tdata_reg <= 32'ha0000000;     
                    end
                    
                    8'd1:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b0;
                        m_axis_cntrl_tdata_reg <= {12'd480,12'd640,8'd0};     
                    end
                    8'd2:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b0;
                        m_axis_cntrl_tdata_reg <= 32'ha0000003;     
                    end
                    8'd3:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b0;
                        m_axis_cntrl_tdata_reg <= 32'ha0000004;     
                    end
                    8'd4:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b0;
                        m_axis_cntrl_tdata_reg <= 32'ha0000005;     
                    end
                    8'd5:
                    begin
                        m_axis_cntrl_tlast_reg <= 1'b1;
                        m_axis_cntrl_tdata_reg <= 32'ha0000006;     
                    end
                    
                endcase    
                           
            end
            STATE_mm2s:
            begin
            m_axis_cntrl_tvalid_reg <= 1'b0;
            m_axis_cntrl_tlast_reg <= 1'b0;
                if(count < DATA64_NUM)
                begin
                    m_axis_mm2s_tdata_reg <= sim_dataIn;
                    m_axis_mm2s_tvalid_reg <= 1'b1;
                    count2 <= count2 + 1'b1;
                end
                else
                begin
                    m_axis_mm2s_tdata_reg <= 64'd0;
                    m_axis_mm2s_tvalid_reg <= 1'b0;
                end
                            
            end    
        endcase
        end
    end
    
    
    



endmodule
