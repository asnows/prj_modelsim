// 地址自动加1模式
module TM1640_cfg
(
input clk,
input[7:0] dispData,
output SCL,
output SDA


);
						//13  |  12  | 11  | 10  | 9  |  8  | 7   |  6  |  5  |  4  |  3  |  2   |  1 |  0  
reg[111:0] disp0_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'hff,8'h81,8'h81,8'h81,8'h81,8'hff,8'h00,8'h00,8'h00};
reg[111:0] disp1_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hff,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};
reg[111:0] disp2_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h4f,8'h49,8'h49,8'h49,8'h49,8'h79,8'h00,8'h00,8'h00};
reg[111:0] disp3_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h7f,8'h49,8'h49,8'h49,8'h49,8'h49,8'h00,8'h00,8'h00};
reg[111:0] disp4_mem = {8'h00,8'h00,8'h00,8'h00,8'h08,8'h08,8'h08,8'h7f,8'h08,8'h08,8'h0f,8'h00,8'h00,8'h00};
reg[111:0] disp5_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h79,8'h49,8'h49,8'h49,8'h49,8'h4f,8'h00,8'h00,8'h00};
reg[111:0] disp6_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h79,8'h49,8'h49,8'h49,8'h49,8'h7f,8'h00,8'h00,8'h00};
reg[111:0] disp7_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h7f,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h00};
reg[111:0] disp8_mem = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h7f,8'h49,8'h49,8'h49,8'h49,8'h7f,8'h00,8'h00,8'h00};
//reg[111:0] disp9_mem = {8'h00,8'h00,8'h00,8'h00,8'h06,8'h09,8'h19,8'h29,8'h49,8'h86,8'h00,8'h00,8'h00,8'h00};
reg[111:0] disp9_mem = {8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff};
reg[111:0] dispv_mem = {8'h00,8'h00,8'h3c,8'h24,8'h24,8'h3c,8'h00,8'h04,8'h08,8'h10,8'h20,8'h10,8'h08,8'h04};





reg[7:0] tdata = 8'd0;
reg[7:0] dispData_dly = 8'd0;


reg[7:0] counts = 8'd00;
reg tvaild_plus = 1'b0;
reg [7:0] bits = 8'd0;


always@(posedge clk)
begin
	dispData_dly <= dispData;
end


always@(posedge clk)
begin

   counts <= counts + 1'b1;
	
	
end


always@(posedge clk)
begin
	if(counts < 8'd13)
	begin
		tvaild_plus <= 1'b1;
	end
	else 
	begin
		tvaild_plus <= 1'b0;
	end
end




always@(posedge clk)
begin

	if(tvaild_plus == 1'b1)
	begin
		bits <= bits+ 8'd8;
		case(dispData_dly)
			8'd0:
			begin
				
				tdata <= (disp0_mem >> bits);
			end
			8'd1:
			begin
				tdata <= (disp1_mem >> bits);
			end
			8'd2:
			begin
				tdata <= (disp2_mem >> bits);
			end		
			8'd3:
			begin
				tdata <= (disp3_mem >> bits);
			end		
			8'd4:
			begin
				tdata <= (disp4_mem >> bits);
			end		
			8'd5:
			begin
				tdata <= (disp5_mem >> bits);
			end	
			8'd6:
			begin
				tdata <= (disp6_mem >> bits);
			end
			8'd7:
			begin
				tdata <= (disp7_mem >> bits);
			end
			8'd8:
			begin
				tdata <= (disp8_mem >> bits);
			end	
			8'd9:
			begin
				tdata <= (disp9_mem >> bits);
			end
			
			8'd10:
			begin
				tdata <= (dispv_mem >> bits);
			end

			
			
			
			default:
			begin
				tdata <= 8'h00;
			end
				
		endcase
	end 
	
	else
	begin
		bits <= 8'd0;
	end
end



TM1640_driver TM1640_drive_i
(
	.clk(clk),
	.tvalid(tvaild_plus),
	.sendBytes(8'd14),
	.cmd1(8'h40),
	.cmd2(8'hc0),
	.tdata(tdata),
	.cmd3(8'h8a),
	.done(),
	.SCL(SCL),
	.SDA(SDA)

);
  




  
  
  







endmodule
