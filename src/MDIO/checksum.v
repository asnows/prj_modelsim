`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/14 11:14:22
// Design Name: 
// Module Name: checksum
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


module checksum
    (
        input [3:0]ver,                //�汾
        input [3:0]hdr_len,            //�ײ�����
        input [7:0]tos,                //��������
        input [15:0]total_len,         //IP�����ܳ�
        input [15:0]id,                //�ֶα�ʶ
        input [15:0]offset,            //ƫ��
        input [7:0]ttl,                //��������
        input [7:0]protocol,           //�ϲ�Э������
        input [31:0]src_ip,            //ԴIP��ַ
        input [31:0]dst_ip,            //Ŀ��IP��ַ
        
        output [15:0]checksum_result    //У���
    );
    
        
        wire [31:0]sum;
    
        assign sum = {ver,hdr_len,tos} + total_len + id 
                     + offset + {ttl,protocol} + src_ip[31:16]
                     + src_ip[15:0] + dst_ip[31:16] + dst_ip[15:0];
        
        assign checksum_result = ~(sum[31:16] + sum[15:0]);
    
    endmodule
