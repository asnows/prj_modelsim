module lvds_tx
#(
	parameter DATA_RATE = "DDR",
	parameter DATA_WIDTH = 10

)
(
	input clk,
	input clkdiv,
	input reset,
	input[DATA_WIDTH - 1:0]tx_data,
	output dataout_p,
	output dataout_n

);

	wire data_out;
	assign dataout_p = data_out;
	assign dataout_n = ~data_out;
	

	lvds_oserdese
	#(
		.DATA_RATE (DATA_RATE	),
		.DATA_WIDTH(DATA_WIDTH	)

	)
	lvds_oserdese_i
	(
		.clk		(clk		),
		.clkdiv		(clkdiv		),
		.reset		(reset		),
		.data_in	(tx_data	),
		.data_out	(data_out	)
	);


endmodule