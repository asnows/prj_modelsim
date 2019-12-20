module eth_frame
(
	input clk,
	input mdio_done,
	output txen,
	output[3:0] txd

);
localparam Source_Port_Num=32'd5000,Objective_Port_Num=32'd6000,
            Source_IP_Num1=8'd192,  Objective_IP_Num1=8'd192,
            Source_IP_Num2=8'd168,  Objective_IP_Num2=8'd168,
            Source_IP_Num3=8'd200,  Objective_IP_Num3=8'd200,
            Source_IP_Num4=8'd44,   Objective_IP_Num4=8'd100,
           
            src_mac1=8'h00,                  des_mac1=8'h08,
            src_mac2=8'h12,                  des_mac2=8'h57,
            src_mac3=8'h34,                  des_mac3=8'h00,
            src_mac4=8'h56,                  des_mac4=8'hf4,
            src_mac5=8'h78,                  des_mac5=8'hae,
            src_mac6=8'h90,                  des_mac6=8'he5;




localparam SEND_BYTES = 8'd128 *2;
reg[11:0] byte_count = 8'd0;
reg txen_reg = 1'b0;
reg[3:0] txd_reg = 4'd0;
wire clk_n;
wire TX_EN;
wire [7:0]MAC_Data;
reg[1:0] clk_div = 2'd0;
wire clk_2div;



assign clk_n = ~clk;
assign txen = txen_reg;
assign txd = txd_reg;
assign clk_2div =  clk_div[0];



always@(posedge clk_n)
begin
	clk_div <= clk_div + 1'b1;
end


always@(posedge clk_n)
begin
	if(clk_2div == 1'b1)
	begin
		txd_reg <= MAC_Data[7:4];
	end
	else
	begin
		txd_reg <= MAC_Data[3:0];
	end
	
	txen_reg <= TX_EN;
	
end



 MAC_Packet#
(   .Source_Port_Num(Source_Port_Num),.Objective_Port_Num(Objective_Port_Num),
	.Source_IP_Num1(Source_IP_Num1),  .Objective_IP_Num1(Objective_IP_Num1 ),
	.Source_IP_Num2(Source_IP_Num2),  .Objective_IP_Num2(Objective_IP_Num2 ),
	.Source_IP_Num3(Source_IP_Num3),  .Objective_IP_Num3(Objective_IP_Num3 ),
	.Source_IP_Num4(Source_IP_Num4),  .Objective_IP_Num4(Objective_IP_Num4 ),

	.src_mac1(src_mac1),                  .des_mac1(des_mac1),
	.src_mac2(src_mac2),                  .des_mac2(des_mac2),
	.src_mac3(src_mac3),                  .des_mac3(des_mac3),
	.src_mac4(src_mac4),                  .des_mac4(des_mac4),
	.src_mac5(src_mac5),                  .des_mac5(des_mac5),
	.src_mac6(src_mac6),                  .des_mac6(des_mac6)
)
MAC_Packet_i			
(
    .RSTn(mdio_done),
    .clk(clk_2div),
    .TX_EN(TX_EN),
    .MAC_TX_EN(mdio_done),
    .MAC_Data(MAC_Data)
);









endmodule