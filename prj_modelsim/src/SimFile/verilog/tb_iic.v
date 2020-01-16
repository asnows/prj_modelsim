module tb_iic
(
	input clk_50m,
	input resetn

);

    wire clk;
	wire tready;
	reg tvalid = 1'b0;
	reg[7:0]tdata;
	

	always@(posedge clk)
	begin
		if(tvalid & tready)
		begin
			tdata <= tdata + 1'b1;
		end		
	end
	  
	assign clk = clk_50m;
	

	
	
	always@(posedge clk)
	begin
		if(resetn == 1'b1)
		begin
			tvalid <= 1'b1;
		end
		
	end
	


	iic_opr iic_opr_I
	(
		.clk      	(clk),
		.sendBytes	(8'd1),
		.tvalid		(tvalid),
		.tdata		(tdata),
		.tready(tready),
		.SCL   (),
		.SDA   () 
	);




endmodule