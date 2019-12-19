// 地址自动加1模式

module TM1640_driver
(
	input clk/* synthesis syn_keep = 1 */,
	input tvalid /* synthesis syn_keep = 1 */,
	input[7:0] sendBytes/* synthesis syn_keep = 1 */,
	input[7:0] cmd1/* synthesis syn_keep = 1 */,
	input[7:0] cmd2/* synthesis syn_keep = 1 */,
	input[7:0] tdata/* synthesis syn_keep = 1 */,
	input[7:0] cmd3/* synthesis syn_keep = 1 */,
	output done/* synthesis preserve = 1*/,
	output SCL/* synthesis preserve = 1*/,
	output SDA/* synthesis preserve  = 1 */

);


localparam STATE_CMD1 = 2'b00,STATE_CMD2 = 2'b01,STATE_CMD3 = 2'b10,STATE_IDEL = 2'b11;


reg[1:0]state = STATE_IDEL;
reg tvalid_dly;
reg done_reg;


reg      iic_tvaild = 1'b0;
wire     iic_tready;
reg[7:0] iic_bytes = 8'd0;
reg[7:0] iic_tdata = 8'd0;
reg[7:0] byteCount = 8'd0;

reg[7:0] CMD3Count = 8'd0;

reg[7:0] mem_wrAddr = 8'd0;
reg[7:0] mem_rdAddr = 8'd0;
reg[7:0] mem[15:0];


assign done = done_reg;


always@(posedge clk)
begin
	if(tvalid_dly)
	begin
		
	    mem_wrAddr <= mem_wrAddr + 1'b1;	
	end
	else
	begin
		mem_wrAddr <= 8'd0;	
	end
	
end

always@(posedge clk )
begin
	mem[mem_wrAddr] <= tdata;
end


always@(posedge clk)
begin
	tvalid_dly <= tvalid;
end





	

// 产生状态机
always@(posedge clk)
begin
	case(state)
		STATE_IDEL:
		begin
			if(~tvalid_dly & tvalid)
			begin
				state <= STATE_CMD1;
			    done_reg <=  1'b0;				
		
			end
			else
			begin
				state <= STATE_IDEL;
				done_reg <=  1'b1;

			end			
			
		end
		STATE_CMD1:
		begin
				byteCount <= 8'd0;
				
				if(iic_tready == 1'b1)
				begin
					state <= STATE_CMD2;					
				end
				else
				begin
					state <= STATE_CMD1;
			
				end			
				
		end
		STATE_CMD2:
		begin
			// if(byteCount < sendBytes )
			// begin
				// if(iic_tready == 1'b1)
				// begin	   	    				   
				   // byteCount <= byteCount + 1'b1;	
				// end
				// state <= STATE_CMD2;
			// end
			// else
			// begin
				// state <= STATE_CMD3;
			// end		
			
			
			if(iic_tready == 1'b1)
			begin	   	    				   
			   byteCount <= byteCount + 1'b1;	
			end
			
			if(byteCount < sendBytes + 8'd1)
			begin
				state <= STATE_CMD2;
			end
			else
			begin
				state <= STATE_CMD3;
				CMD3Count <= 8'd0;
			end		
			
						
		end
		STATE_CMD3:
		begin
		
			// if(iic_tready == 1'b1)
			// begin
				// state <= STATE_IDEL;
				// done_reg <= 1'b1;
			// end
			// else
			// begin
				// state <= STATE_CMD3;
			// end	
			
			
			if(iic_tready == 1'b1)
			begin
				CMD3Count <= CMD3Count + 1'b1;	
			end
			
			if(CMD3Count > 8'd1)
			begin
				state <= STATE_IDEL;
				done_reg <= 1'b1;
			end
			else
			begin
				state <= STATE_CMD3;
			end				
			
			
			
			
		end
		default:
		begin
			state <= STATE_IDEL;
		end
		
	endcase	
end


always@(posedge clk)
begin
	case(state)
		STATE_IDEL:
		begin
		
			iic_tvaild <= 1'b0;
			// iic_bytes  <= 8'd0;
			// iic_tdata  <= 8'd0;
		
		end
		
		STATE_CMD1:
		begin	
			iic_tvaild <= 1'b1;
			iic_bytes  <= 8'd1;
			iic_tdata  <= cmd1;
				
		end

		STATE_CMD2:
		begin
			
			if(iic_tready == 1'b1)
			begin
				iic_tvaild <= 1'b1;
				iic_bytes  <= sendBytes + 1'd1;
			end
			else
			begin
				iic_tvaild <= 1'b0;
			end
			
			if(iic_tready == 1'b1)
			begin
				if(byteCount == 0)
				begin
				   iic_tdata  <= cmd2;
				end
				else
				begin
					iic_tdata <= mem[byteCount - 1];
				end
			end
			
		end
		
		STATE_CMD3:
		begin
			if(iic_tready == 1'b1)
			begin				
				iic_tvaild <= 1'b1;
				iic_bytes  <= 8'd1;
				iic_tdata  <= cmd3;
			end
		end
		default:
		begin
		end
		
	endcase
end


iic_opr iic_opr_I
(
	.clk(clk),
	.sendBytes(iic_bytes),
	.tvalid(iic_tvaild),
	.tdata(iic_tdata),
	.tready(iic_tready),
	.SCL(SCL),
	.SDA(SDA)
);





	



endmodule