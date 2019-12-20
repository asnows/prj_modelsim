module lvds_oserdese
#(
	parameter DATA_RATE = "DDR",
	parameter DATA_WIDTH = 10

)
(
	input clk,
	input clkdiv,
	input reset,
	input[DATA_WIDTH - 1:0]data_in,
	output data_out
);

	wire SHIFTIN1,SHIFTIN2;
	wire oce_master;
	wire oce_slave;


	OSERDESE2 
	#(
		.DATA_RATE_OQ	(DATA_RATE	), // DDR, SDR
		.DATA_RATE_TQ	(DATA_RATE	), // DDR, BUF, SDR
		.DATA_WIDTH		(DATA_WIDTH	), // Parallel data width (2-8,10,14)
		.INIT_OQ		(1'b0		), // Initial value of OQ output (1'b0,1'b1)
		.INIT_TQ		(1'b0		), // Initial value of TQ output (1'b0,1'b1)
		.SERDES_MODE	("MASTER"	), // MASTER, SLAVE
		.SRVAL_OQ		(1'b0		), // OQ output value when SR is used (1'b0,1'b1)
		.SRVAL_TQ		(1'b0		), // TQ output value when SR is used (1'b0,1'b1)
		.TBYTE_CTL		("FALSE"	), // Enable tristate byte operation (FALSE, TRUE)
		.TBYTE_SRC		("FALSE"	), // Tristate byte source (FALSE, TRUE)
		.TRISTATE_WIDTH	(4			)  // 3-state converter width (1,4)
	)
	OSERDESE2_master 
	(
		.OFB		(			),// 1-bit output: Feedback path for data
		.OQ			(data_out	),// 1-bit output: Data path output
		// SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
		.SHIFTOUT1	(			),
		.SHIFTOUT2	(			),
		.TBYTEOUT	(			),// 1-bit output: Byte group tristate
		.TFB		(			),// 1-bit output: 3-state control
		.TQ			(			),// 1-bit output: 3-state control
		.CLK		(clk		),// 1-bit input: High speed clock
		.CLKDIV		(clkdiv		),// 1-bit input: Divided clock
		// D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
		.D1			(data_in[0]	),
		.D2			(data_in[1]	),
		.D3			(data_in[2]	),
		.D4			(data_in[3]	),
		.D5			(data_in[4]	),
		.D6			(data_in[5]	),
		.D7			(data_in[6]	),
		.D8			(data_in[7]	),
		.OCE		(1'b1		),// 1-bit input: Output data clock enable
		.RST		(reset		),// 1-bit input: Reset
		// SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
		.SHIFTIN1	(SHIFTIN1	),
		.SHIFTIN2	(SHIFTIN2	),
		// T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		.T1			(1'b0		),
		.T2			(1'b0		),
		.T3			(1'b0		),
		.T4			(1'b0		),
		.TBYTEIN	(1'b0		),// 1-bit input: Byte group tristate
		.TCE		(1'b0		) // 1-bit input: 3-state clock enable
	);


	// OSERDESE2 
	// #(
		// .DATA_RATE_OQ	(DATA_RATE	), // DDR, SDR
		// .DATA_RATE_TQ	(DATA_RATE	), // DDR, BUF, SDR
		// .DATA_WIDTH		(DATA_WIDTH	), // Parallel data width (2-8,10,14)
		// .INIT_OQ		(1'b0		), // Initial value of OQ output (1'b0,1'b1)
		// .INIT_TQ		(1'b0		), // Initial value of TQ output (1'b0,1'b1)
		// .SERDES_MODE	("SLAVE"	), // MASTER, SLAVE
		// .SRVAL_OQ		(1'b0		), // OQ output value when SR is used (1'b0,1'b1)
		// .SRVAL_TQ		(1'b0		), // TQ output value when SR is used (1'b0,1'b1)
		// .TBYTE_CTL		("FALSE"	), // Enable tristate byte operation (FALSE, TRUE)
		// .TBYTE_SRC		("FALSE"	), // Tristate byte source (FALSE, TRUE)
		// .TRISTATE_WIDTH	(4			)  // 3-state converter width (1,4)
	// )
	// OSERDESE2_slave 
	// (
		// .OFB		(			),// 1-bit output: Feedback path for data
		// .OQ			(     		),// 1-bit output: Data path output
		// // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
		// .SHIFTOUT1	(SHIFTIN1	),
		// .SHIFTOUT2	(SHIFTIN2	),
		// .TBYTEOUT	(			),// 1-bit output: Byte group tristate
		// .TFB		(			),// 1-bit output: 3-state control
		// .TQ			(			),// 1-bit output: 3-state control
		// .CLK		(clk		),// 1-bit input: High speed clock
		// .CLKDIV		(clkdiv		),// 1-bit input: Divided clock
		// // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
		// .D1			(	),
		// .D2			(	),
		// .D3			(data_in[8]	),
		// .D4			(data_in[9]	),
		// .D5			(	),
		// .D6			(	),
		// .D7			(	),
		// .D8			(	),
		// .OCE		(1'b1	),// 1-bit input: Output data clock enable
		// .RST		(reset		),// 1-bit input: Reset
		// // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
		// .SHIFTIN1	(			),
		// .SHIFTIN2	(			),
		// // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
		// .T1			(1'b0		),
		// .T2			(1'b0		),
		// .T3			(1'b0		),
		// .T4			(1'b0		),
		// .TBYTEIN	(1'b0		),// 1-bit input: Byte group tristate
		// .TCE		(1'b0		) // 1-bit input: 3-state clock enable
	// );





endmodule