




module bit_alignment
#(
	parameter DATA_WIDTH = 10 
)

(
	input clk			,
	input reset			,
	input enable		,
	input idelayCtrl_rdy,
	input[DATA_WIDTH - 1:0] master_data	,
	input[DATA_WIDTH - 1:0] slave_data	,
	output[4:0] tap_value	,
	output bit_align_done
);

	localparam STATE_IDLE = 2'b00,STATE_MATCH0 = 2'b01,STATE_MATCH1 = 2'b10,STATE_CONTINUE = 3'b11;
	localparam TAP_NUMS = 32;
	reg[1:0] state = STATE_IDLE;
	reg match = 1'b0;
	reg[4:0] tapValue = 5'd0;
	reg[5:0] tapCount = 6'd0;
	reg[5:0] tapValueReg = 6'd0;
	reg[5:0] match0_tap = 6'd0;
	reg[5:0] match1_tap = 6'd0;
	reg align_done_reg = 1'b0;
	reg[1:0] align_done = 2'd0;


	assign  tap_value = (enable == 1'b1)? tapValue : 5'd0;
	//assign  tap_value = tapValue;
	assign bit_align_done = align_done[1];

	always@(posedge clk)
	begin
		match <= (master_data == (~slave_data))? 1'b1:1'b0;
		
		align_done <= {align_done[0],align_done_reg};
	end

	always@(posedge clk)
	begin
		if(reset == 1'b1)
		begin
			tapCount <= 6'd0;
		end
		else
		begin
			if((idelayCtrl_rdy == 1'b1) &&(tapCount < TAP_NUMS))
			begin
				tapCount <= tapCount + 1'b1;
			end
		end
		
	end



	always@(posedge clk)
	begin
		if(reset == 1'b1)
		begin
			state <= STATE_IDLE;
			tapValue <= 5'd0;
			align_done_reg <= 1'b0;
		end
		else
		begin
			case(state)
			STATE_IDLE:
			begin
				if((idelayCtrl_rdy == 1'b1) && (match == 1'b0)) //第一次不匹配的第�?�?
				begin
					state <= STATE_MATCH0;
					match0_tap <= tapCount - 6'd2;
				end
				else
				begin
					state <= STATE_IDLE;
				end			
				tapValue <= tapCount;

			end
			STATE_MATCH0:
			begin
				if(match == 1'b1)
				begin
					state <= STATE_MATCH1;
				end
				else
				begin
					state <= STATE_MATCH0;
				end
				tapValue <= tapCount;			
			end
			STATE_MATCH1:
			begin
				if(match == 1'b0)//第二次不配陪的第�?�?
				begin
					state <= STATE_CONTINUE;
					match1_tap <= tapCount - 6'd2;
				end
				else
				begin
					state <= STATE_MATCH1;
				end
				tapValue <= tapCount;
			end
			
			STATE_CONTINUE: 
			begin
				align_done_reg <= 1'b1;
				//tapValueReg <= match0_tap + match1_tap;
				tapValue <= ((match0_tap + match1_tap) >> 1); 
			end
			default:
			begin
			end
			
			endcase
		end
		
	end

endmodule