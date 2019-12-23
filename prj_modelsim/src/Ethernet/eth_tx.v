module eth_tx
(
	input clk,
	input tvalid,
	input[7:0] tdata,
	output tx_en,
	output[3:0] txd
)



genvar i;
generate
	for(i=0,i<3,i=i+1)
	begin:TX
	   ODDR 
	   #(
		  .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
		  .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
		  .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	   ) 
	   ODDR_txd 
	   (
		  .Q(txd[i]),   // 1-bit DDR output
		  .C(clk),   // 1-bit clock input
		  .CE(1'b1), // 1-bit clock enable input
		  .D1(tdata[i]), // 1-bit data input (positive edge)
		  .D2(tdata[i+4]), // 1-bit data input (negative edge)
		  .R(1'b0),   // 1-bit reset
		  .S(1'b0)    // 1-bit set
	   );
							
	end
endgenerate


	   ODDR 
	   #(
		  .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
		  .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
		  .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	   ) 
	   ODDR_tx_ener 
	   (
		  .Q(tx_en),   // 1-bit DDR output
		  .C(clk),   // 1-bit clock input
		  .CE(1'b1), // 1-bit clock enable input
		  .D1(tvalid), // 1-bit data input (positive edge)
		  .D2(1'b0), // 1-bit data input (negative edge)
		  .R(1'b0),   // 1-bit reset
		  .S(1'b0)    // 1-bit set
	   );


endmodule