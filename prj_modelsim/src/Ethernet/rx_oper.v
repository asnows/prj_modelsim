module rx_oper
(
	input rx_clk,
	input rx_en,
	input[3:0] rxd,
	output tvalid,
	output[7:0] tdata

);


wire[3:0] rxd_q1,rxd_q2;
wire rx_en_q1,rx_en_q2;

reg tvalid_reg;
reg[7:0] tdata_reg;

assign tdata = tdata_reg;
assign tvalid = tvalid_reg;





genvar i;
generate
	for(i = 0; i < 4; i = i+1)
	begin:RX
	
	   IDDR 
	   #(
		  .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
										  //    or "SAME_EDGE_PIPELINED" 
		  .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		  .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		  .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	   ) 
	   IDDR_rxd
	   (
		  .Q1(rxd_q1[i]), // 1-bit output for positive edge of clock
		  .Q2(rxd_q2[i]), // 1-bit output for negative edge of clock
		  .C(rx_clk),   // 1-bit clock input
		  .CE(1'b1), // 1-bit clock enable input
		  .D(rxd[i]),   // 1-bit DDR data input
		  .R(1'b0),   // 1-bit reset
		  .S(1'b0)    // 1-bit set
	   );
		
	end

endgenerate


	   IDDR 
	   #(
		  .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
										  //    or "SAME_EDGE_PIPELINED" 
		  .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		  .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		  .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	   ) 
	   IDDR_rxd
	   (
		  .Q1(rx_en_q1), // 1-bit output for positive edge of clock
		  .Q2(rx_en_q2), // 1-bit output for negative edge of clock
		  .C(rx_clk),   // 1-bit clock input
		  .CE(1'b1), // 1-bit clock enable input
		  .D(rx_en),   // 1-bit DDR data input
		  .R(1'b0),   // 1-bit reset
		  .S(1'b0)    // 1-bit set
	   );





always@(posedge rx_clk)
begin
	tvalid_reg <= rx_en_q1;
	tdata_reg <= {rxd_q2,rxd_q1};
end










endmodule