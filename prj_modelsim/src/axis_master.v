module axis_master
#(
	parameter DATA_NUM = 1024
)
(
	input clk,
	input reset,
	output[7:0]  m_axis_tdata    ,
	output       m_axis_tlast    ,
	input        m_axis_tready   ,
	output       m_axis_tuser    ,
	output       m_axis_tvalid   

);

	reg [7:0] data_reg;
	reg tvaild_reg = 1'b0;
	reg tuser_reg = 1'b0;
	reg tlast_reg = 1'b0;
	reg[31:0] nums = 32'hffffffff;
	
	
	assign m_axis_tdata = nums;
	assign m_axis_tlast = tlast_reg;
	assign m_axis_tuser = tuser_reg;
	assign m_axis_tvalid = tvaild_reg;
	
	always@(posedge clk)
	begin
		if(reset)
		begin
			nums <= 32'hffffffff;
		end
		else
		begin
			if(m_axis_tready)
			begin
				if(nums < (DATA_NUM + 16))
				begin
					nums <= nums + 1'b1;
				end
				else
				begin
					nums <= 32'd0;
				end
			end
		end
		
	end
	
	always@(posedge clk)
	begin
		if(nums == 1'b0)
		begin
			tuser_reg <= 1'b1;
		end
		else
		begin
			tuser_reg <= 1'b0;
		end
		
	end
	
	
	always@(posedge clk)
	begin
		if(nums == (DATA_NUM - 1'b1))
		begin
			tlast_reg <= 1'b1;
		end
		else
		begin
			tlast_reg <= 1'b0;
		end
	end
	
	always@(posedge clk)
	begin
		if(nums < DATA_NUM)
		begin
			tvaild_reg <= 1'b1;
		end
		else
		begin
			tvaild_reg <= 1'b0;
		end
		
	end
			
endmodule