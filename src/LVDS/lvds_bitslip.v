module lvds_bitslip
#(
	parameter DATA_WIDTH = 10 
)
(
	input clk,
	input bitslip_en,
	input[DATA_WIDTH - 1 :0] pattern,
	input[DATA_WIDTH - 1 :0] data_in,
	
	output bitslip,
	output bitslip_done

);

	localparam STATE_IDLE = 2'b00,STATE_COMPARE = 2'b01,STATE_WAITE = 2'b10,STATE_COMPELET = 2'b11;
	wire clk_n;

	reg[1:0] state = STATE_IDLE;

	reg bitslip_reg = 1'b0;
	reg bitslip_reg1 = 1'b0;
	reg bitslip_done_reg = 1'b0;

	reg[2:0] counts = 3'd0;
	reg [DATA_WIDTH - 1 :0] data_in_dly;


	assign clk_n = ~clk;
	assign bitslip = bitslip_reg;
	assign bitslip_done = bitslip_done_reg;

	always@(posedge clk)
	begin
		data_in_dly <= data_in;
	end

	always@(posedge clk)
	begin
		if(!bitslip_en)
		begin
			state <= STATE_IDLE;
			bitslip_done_reg <= 1'b0;
			bitslip_reg1 <= 1'b0;
		end
		else
		begin
			case(state)
				STATE_IDLE:
				begin
					if(bitslip_en == 1'b1)
					begin
						state <= STATE_COMPARE;
					end
				end
				STATE_COMPARE:
				begin
					if(data_in == pattern)
					begin
						state <= STATE_COMPELET;
					end
					else
					begin
						state <= STATE_WAITE;
						bitslip_reg1 <= 1'b1;
					end
					counts <= 3'd0;
					
				end
				STATE_WAITE:
				begin
					if(counts < 3'd3)
					begin
						counts <= counts + 1'b1;
					end
					else
					begin
						state <= STATE_COMPARE;
					end	
						bitslip_reg1 <= 1'b0;
				end
				STATE_COMPELET:
				begin
					bitslip_done_reg <= 1'b1;
					
				end
				
			endcase
		end
		
	end

	always@(posedge clk_n)
	begin
		bitslip_reg <= bitslip_reg1;
	end







endmodule