`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/13 15:54:11
// Design Name: 
// Module Name: MAC_Packet
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


module MAC_Packet#(parameter Source_Port_Num=32'd5000,Objective_Port_Num=32'd6000,

                               Source_IP_Num1=8'd192,  Objective_IP_Num1=8'd192,
                               Source_IP_Num2=8'd168,  Objective_IP_Num2=8'd168,
                               Source_IP_Num3=8'd0,    Objective_IP_Num3=8'd0,
                               Source_IP_Num4=8'd44,    Objective_IP_Num4=8'd2,

                               src_mac1=8'h00,                  des_mac1=8'h08,
                               src_mac2=8'h12,                  des_mac2=8'h1f,
                               src_mac3=8'h34,                  des_mac3=8'h71,
                               src_mac4=8'h56,                  des_mac4=8'h02,
                               src_mac5=8'h78,                  des_mac5=8'hc7,
                               src_mac6=8'h90,                  des_mac6=8'h77)
(
    input RSTn,
    input clk,
    output reg TX_EN,
    input MAC_TX_EN,
    output [7:0]MAC_Data
);

    wire[15:0]ip_total_len;
    wire[15:0]UDP_len;
    wire[15:0]ip_checksum;
    checksum checksum
    (
       .ver(4'h4),
       .hdr_len(4'h5),
       .tos(8'h0),
       .total_len(ip_total_len),
       .id(16'h0),
       .offset(16'h0),
       .ttl(8'h40),
       .protocol(8'h11),
       .src_ip({Source_IP_Num1,Source_IP_Num2,Source_IP_Num3,Source_IP_Num4}),
       .dst_ip({Objective_IP_Num1,Objective_IP_Num2,Objective_IP_Num3,Objective_IP_Num4}),
       .checksum_result(ip_checksum)
    );    
 //calculate the IP checksum, big-endian style
//parameter IPchecksum1 = 32'h0000C53F + (Source_IP_Num1<<8)+Source_IP_Num2+(Source_IP_Num3<<8)+Source_IP_Num4+
//                                                                (Objective_IP_Num1<<8)+Objective_IP_Num2+(Objective_IP_Num3<<8)+(Objective_IP_Num4);
//parameter IPchecksum2 =  ((IPchecksum1&32'h0000FFFF)+(IPchecksum1>>16));
//parameter IPchecksum3 = ~((IPchecksum2&32'h0000FFFF)+(IPchecksum2>>16));

    (*mark_debug="true"*)reg [7:0]MACData;
    reg [6:0]Cnt;
    

    always@(posedge clk )
    begin
       if(!RSTn)begin
          MACData<=8'hFF;
          Cnt<=7'd0;
          TX_EN<=1'b0;
       end
       else 
	   begin
           case(Cnt)
           7'd0:begin
                TX_EN<=1'b0;
               if(MAC_TX_EN)  Cnt<=7'd1;//7'd8
               else                                     Cnt<=7'd0;
           end
    //前导码 7个字节
           7'd1,7'd2,7'd3,7'd4,7'd5,7'd6,7'd7:begin//0x55
                MACData<=8'h55;  
                Cnt<=Cnt+7'd1;
                TX_EN<=1'b1;
           end  
   //帧开始符（SFD）1个字节
           7'd8:begin
                TX_EN<=1'b1;
                MACData<=8'hd5;  
                Cnt<=Cnt+7'd1;     
           end
   //目的MAC地址 6个字节
           7'd9:begin 
                MACData<=des_mac1;  
                Cnt<=Cnt+7'd1;
           end
           7'd10:begin
                 MACData<=des_mac2;  
                 Cnt<=Cnt+7'd1;     
           end
           7'd11:begin
                MACData<=des_mac3;  
                Cnt<=Cnt+7'd1;     
           end
           7'd12:begin
                MACData<=des_mac4;  
                Cnt<=Cnt+7'd1;     
           end
           7'd13:begin
                MACData<=des_mac5;  
                Cnt<=Cnt+7'd1;     
           end
           7'd14:begin
                MACData<=des_mac6;  
                Cnt<=Cnt+7'd1;     
           end
    //源MAC地址 6个字节
           7'd15:begin
                MACData<=src_mac1;  
                Cnt<=Cnt+7'd1;     
           end
           7'd16:begin
                MACData<=src_mac2;  
                Cnt<=Cnt+7'd1;     
           end
           7'd17:begin
                MACData<=src_mac3;  
                Cnt<=Cnt+7'd1;     
           end
           7'd18:begin
                MACData<=src_mac4;  
                Cnt<=Cnt+7'd1;     
           end
           7'd19:begin
                MACData<=src_mac5;  
                Cnt<=Cnt+7'd1;     
           end
           7'd20:begin
                MACData<=src_mac6;  
                Cnt<=Cnt+7'd1;     
           end
     //长度/类型 上一层协议类型，如0x0800代表上一层是IP协议，0x0806为arp 占用2字节
           7'd21:begin
                MACData<=8'h08;  
                Cnt<=Cnt+7'd1;     
           end
           7'd22:begin
                MACData<=8'h00;  
                Cnt<=Cnt+7'd1;     
           end
    //数据和填充  
           //IP包   版本 首部长度（5~15）
           7'd23:begin//0x45
                MACData<=8'h45;  
                Cnt<=Cnt+7'd1;
           end
           //服务类型 默认8'h00
           7'd24:begin
                MACData<=8'h00;
                Cnt<=Cnt+7'd1;  
           end
           //IP报文长度
           7'd25:begin
                MACData<=ip_total_len[15:8];
                Cnt<=Cnt+7'd1;
           end
           7'd26:begin
                MACData<=ip_total_len[7:0];
                Cnt<=Cnt+7'd1;
           end
           //16位分段标识
           7'd27:begin
                MACData<=8'h00;
                Cnt<=Cnt+7'd1;
           end
           7'd28:begin
                MACData<=8'h00;
                Cnt<=Cnt+7'd1;
           end
           //16分段偏移   
           7'd29:begin
                MACData<=8'h00;
                Cnt<=Cnt+7'd1;
           end
           7'd30:begin
                MACData<=8'h00;
                Cnt<=Cnt+7'd1;
           end
           //生存周期64 可以经过的最大路由数64
           7'd31:begin
                MACData<=8'h40;
                Cnt<=Cnt+7'd1;
           end
           //上层协议17 UDP
           7'd32:begin
                MACData<=8'h11;
                Cnt<=Cnt+7'd1;
           end
            //16位IP包头校验和
           7'd33:begin
                MACData<=ip_checksum[15:8];
                Cnt<=Cnt+7'd1;
            end
           7'd34:begin
                MACData<=ip_checksum[7:0];
                Cnt<=Cnt+7'd1;
           end
           //源IP地址
           7'd35:begin
                MACData<=Source_IP_Num1;
                Cnt<=Cnt+7'd1;
           end
           7'd36:begin
                MACData<=Source_IP_Num2;
                Cnt<=Cnt+7'd1;
           end
           7'd37:begin
                MACData<=Source_IP_Num3;
                Cnt<=Cnt+7'd1;
           end
           7'd38:begin
                MACData<=Source_IP_Num4;
                Cnt<=Cnt+7'd1;
           end
           //目的IP地址
           7'd39:begin
                MACData<=Objective_IP_Num1;
                Cnt<=Cnt+7'd1;
           end
           7'd40:begin
                MACData<=Objective_IP_Num2;
                Cnt<=Cnt+7'd1;
           end
           7'd41:begin
                MACData<=Objective_IP_Num3;
                Cnt<=Cnt+7'd1;
           end
           7'd42:begin
                MACData<=Objective_IP_Num4;
                Cnt<=Cnt+7'd1;
           end
          //16位源端口号//16'h1388
           7'd43:begin 
               MACData<=Source_Port_Num[15:8];  
               Cnt<=Cnt+7'd1; 
           end
           7'd44:begin 
               MACData<=Source_Port_Num[7:0];   
               Cnt<=Cnt+7'd1; 
           end
          //16位目的端口号
           7'd45:begin 
               MACData<=Objective_Port_Num[15:8]; 
               Cnt<=Cnt+7'd1;
           end
           7'd46:begin 
               MACData<=Objective_Port_Num[7:0];  
               Cnt<=Cnt+7'd1;
           end
           //16位UDP长度
           7'd47:begin 
               MACData<=UDP_len[15:8]; 
               Cnt<=Cnt+7'd1;
           end
           7'd48:begin 
               MACData<=UDP_len[7:0]; 
               Cnt<=Cnt+7'd1;
           end
           //16位UDP校验和（可选）
           7'd49:begin 
              MACData<=8'h00; 
              Cnt<=Cnt+7'd1;
           end
           7'd50:begin 
              MACData<=8'h00; 
              Cnt<=Cnt+7'd1;
           end
            7'd51: begin MACData <= 8'h00; Cnt<=Cnt+7'd1;end// put here the data that you want to send
            7'd52: begin MACData <= 8'h01; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd53: begin MACData <= 8'h02; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd54: begin MACData <= 8'h03; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd55: begin MACData <= 8'h04; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd56: begin MACData <= 8'h05; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd57: begin MACData <= 8'h06; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd58: begin MACData <= 8'h07; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd59: begin MACData <= 8'h08; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd60: begin MACData <= 8'h09; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd61: begin MACData <= 8'h0A; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd62: begin MACData <= 8'h0B; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd63: begin MACData <= 8'h0C; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd64: begin MACData <= 8'h0D; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd65: begin MACData <= 8'h0E; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd66: begin MACData <= 8'h0F; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd67: begin MACData <= 8'h10; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd68: begin MACData <= 8'h11; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd69: begin MACData <= 8'h12; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd70: begin MACData <= 8'h13; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd71: begin MACData <= 8'h14; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd72: begin MACData <= 8'h15; Cnt<=Cnt+7'd1;end   // put here the data that you want to send
            7'd73: begin MACData <= 8'hf7; Cnt<=Cnt+7'd1;end 
            7'd74: begin MACData <= 8'h74; Cnt<=Cnt+7'd1;end 
            7'd75: begin MACData <= 8'hcc; Cnt<=Cnt+7'd1;end
            7'd76: begin MACData <= 8'h73; Cnt<=Cnt+7'd1;end 
            7'd77,7'd78,7'd79:begin
                MACData <= 8'h00; Cnt<=Cnt+7'd1; //额外给3个时钟用于给寄生电容充电（自己理解）
            end
            7'd80,7'd81,7'd82,7'd83,7'd84,7'd85,7'd86,7'd87,7'd88,7'd89: begin  TX_EN<=1'b0;MACData <= 8'h00; Cnt<=Cnt+7'd1;end  
           default:begin
               MACData <= 8'h00;
               Cnt<=7'd0; 
               TX_EN<=1'b0;
           end
           endcase
       end
    end   

assign ip_total_len=16'h0032;
assign UDP_len=16'h001e;   
assign MAC_Data=MACData;

endmodule


  