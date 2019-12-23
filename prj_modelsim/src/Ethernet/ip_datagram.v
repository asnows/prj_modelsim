module ip_datagram
(
	input[15:0] IP_TotLen;//Total Length
	input[31:0] IP_SrcAddr;
	input[31:0] IP_DestAddr;
	

)

localparam STATE_IDLE = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;
localparam IP_Version = 4'd4;
localparam IP_HeaderLen = 4'd5;
localparam IP_TOS = 8'd0;//Type of Service
localparam IP_ID = 16'D0;
localparam IP_Flags = 3'b010;
localparam IP_FraOff = 13'd0;
localparam IP_TTL = 8'd64;
localparam IP_Protocol = 8'd17;//UDP	

wire[159:0] IP_header;

wire[23:0]  ip_Check;
wire[15:0]  ip_headCheck;


assign IP_header = {IP_Version,IP_HeaderLen,IP_TOS,IP_TotLen,IP_ID,IP_Flags,IP_FraOff,,IP_TTL,IP_Protocol,ip_headCheck,IP_SrcAddr,IP_DestAddr}
assign ip_Check  =  {4'd0,IP_Version,IP_HeaderLen,IP_TOS} + {4'd0,IP_TotLen} + {4'd0,IP_ID} + {4'd0,IP_Flags,IP_FraOff} + {4'd0,IP_TTL,IP_Protocol}
				 +  {4'd0,IP_SrcAddr[31:16]} + {4'd0,IP_SrcAddr[15:0]}+ {4'd0,IP_DestAddr[31:16]} + {4'd0,IP_DestAddr[15:0]};

assign ip_headCheck = ~(ip_Check[15:0] + ip_Check[23:16]);




endmodule
