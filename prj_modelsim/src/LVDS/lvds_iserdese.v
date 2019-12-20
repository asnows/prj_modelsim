//`define CASCADING 
module lvds_iserdese
#(
	parameter DATA_RATE = "DDR",
	parameter DATA_WIDTH = 10 

)
(
	input clk,
	input clkdiv,
	input reset,
	input d,
	input ddly,
	input bitslip,
	output Comb_Out,
	output[DATA_WIDTH - 1 :0] data_out

);
	localparam NUM_CE = 2;
	wire [DATA_WIDTH - 1:0] data_q;
	reg [DATA_WIDTH - 1:0] data_out_reg;
	wire shift_out1,shift_out2;
	//reg bitslip = 1'b0;
	reg CE1 = 1'b1;
	reg CE2 = 1'b1;
	wire clkb;

	assign clkb = ~clk;







	ISERDESE2 
	#(
		.DATA_RATE			(DATA_RATE	),// DDR, SDR
		.DATA_WIDTH			(DATA_WIDTH	),// Parallel data width (2-8,10,14)
		.DYN_CLKDIV_INV_EN	("FALSE"	),// Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
		.DYN_CLK_INV_EN		("FALSE"	),// Enable DYNCLKINVSEL inversion (FALSE, TRUE)
		// INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
		.INIT_Q1			(1'b0		),
		.INIT_Q2			(1'b0		),
		.INIT_Q3			(1'b0		),
		.INIT_Q4			(1'b0		),
		.INTERFACE_TYPE		("NETWORKING"),// MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
		.IOBDELAY			("IFD"		),// NONE, BOTH, IBUF, IFD
		.NUM_CE				(NUM_CE		),// Number of clock enables (1,2)
		.OFB_USED			("FALSE"	),// Select OFB path (FALSE, TRUE)
		.SERDES_MODE		("MASTER"	),// MASTER, SLAVE
		// SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
		.SRVAL_Q1			(1'b0		),
		.SRVAL_Q2			(1'b0		),
		.SRVAL_Q3			(1'b0		),
		.SRVAL_Q4			(1'b0		)
	)
	ISERDESE2_master 
	(
		.O			(Comb_Out ),// 1-bit output: Combinatorial output
		// Q1 - Q8: 1-bit (each) output: Registered data outputs
		.Q1			(data_q[0]	),
		.Q2			(data_q[1]	),
		.Q3			(data_q[2]	),
		.Q4			(data_q[3]	),
		.Q5			(data_q[4]	),
		.Q6			(data_q[5]	),
		.Q7			(data_q[6]	),
		.Q8			(data_q[7]	),
		// SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1	(shift_out1	),
		.SHIFTOUT2	(shift_out2	),
		.BITSLIP  	(bitslip	),// 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to

		// CE1, CE2: 1-bit (each) input: Data register clock enable inputs
		.CE1		(CE1		),
		.CE2		(CE2		),
		.CLKDIVP	(1'b0		),// 1-bit input: TBD
		// Clocks: 1-bit (each) input: ISERDESE2 clock input ports
		.CLK		(clk		),// 1-bit input: High-speed clock
		.CLKB		(clkb		),// 1-bit input: High-speed secondary clock
		.CLKDIV		(clkdiv		),// 1-bit input: Divided clock
		.OCLK		(1'b0		),// 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
		// Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
		.DYNCLKDIVSEL(1'b0		),// 1-bit input: Dynamic CLKDIV inversion
		.DYNCLKSEL	(1'b0		),// 1-bit input: Dynamic CLK/CLKB inversion
		// Input Data: 1-bit (each) input: ISERDESE2 data input ports
		.D			(d			),// 1-bit input: Data input
		.DDLY		(ddly		),// 1-bit input: Serial data from IDELAYE2
		.OFB		(1'b0		),// 1-bit input: Data feedback from OSERDESE2
		.OCLKB		(1'b0		),// 1-bit input: High speed negative edge output clock
		.RST		(reset		),// 1-bit input: Active high asynchronous reset
		// SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1	(1'b0		),
		.SHIFTIN2	(1'b0		)
	);
	
`ifdef 	CASCADING
	ISERDESE2 
	#(
		.DATA_RATE			(DATA_RATE	),// DDR, SDR
		.DATA_WIDTH			(DATA_WIDTH	),// Parallel data width (2-8,10,14)
		.DYN_CLKDIV_INV_EN	("FALSE"	),// Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
		.DYN_CLK_INV_EN		("FALSE"	),// Enable DYNCLKINVSEL inversion (FALSE, TRUE)
		// INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
		.INIT_Q1			(1'b0		),
		.INIT_Q2			(1'b0		),
		.INIT_Q3			(1'b0		),
		.INIT_Q4			(1'b0		),
		.INTERFACE_TYPE		("NETWORKING"),// MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
		.IOBDELAY			("IFD"		),// NONE, BOTH, IBUF, IFD
		.NUM_CE				(NUM_CE		),// Number of clock enables (1,2)
		.OFB_USED			("FALSE"	),// Select OFB path (FALSE, TRUE)
		.SERDES_MODE		("SLAVE"	),// MASTER, SLAVE
		// SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
		.SRVAL_Q1			(1'b0		),
		.SRVAL_Q2			(1'b0		),
		.SRVAL_Q3			(1'b0		),
		.SRVAL_Q4			(1'b0		)
	)
	ISERDESE2_slave
	(
		.O			(			),// 1-bit output: Combinatorial output
		// Q1 - Q8: 1-bit (each) output: Registered data outputs
		.Q1			(			),
		.Q2			(			),
		.Q3			(data_q[8]	),
		.Q4			(data_q[9]	),
		.Q5			(			),
		.Q6			(			),
		.Q7			(			),
		.Q8			(			),
		// SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
		.SHIFTOUT1	(			),
		.SHIFTOUT2	(			),
		.BITSLIP  	(bitslip	),// 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to

		// CE1, CE2: 1-bit (each) input: Data register clock enable inputs
		.CE1		(CE1		),
		.CE2		(CE2		),
		.CLKDIVP	(1'b0		),// 1-bit input: TBD
		// Clocks: 1-bit (each) input: ISERDESE2 clock input ports
		.CLK		(clk		),// 1-bit input: High-speed clock
		.CLKB		(clkb		),// 1-bit input: High-speed secondary clock
		.CLKDIV		(clkdiv		),// 1-bit input: Divided clock
		.OCLK		(1'b0		),// 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
		// Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
		.DYNCLKDIVSEL(1'b0		),// 1-bit input: Dynamic CLKDIV inversion
		.DYNCLKSEL	(1'b0		),// 1-bit input: Dynamic CLK/CLKB inversion
		// Input Data: 1-bit (each) input: ISERDESE2 data input ports
		.D			(d			),// 1-bit input: Data input
		.DDLY		(ddly		),// 1-bit input: Serial data from IDELAYE2
		.OFB		(1'b0		),// 1-bit input: Data feedback from OSERDESE2
		.OCLKB		(1'b0		),// 1-bit input: High speed negative edge output clock
		.RST		(reset		),// 1-bit input: Active high asynchronous reset
		// SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
		.SHIFTIN1	(shift_out1	),
		.SHIFTIN2	(shift_out2	)
	);
	
`endif	

    genvar i;
    generate
        for(i = 0;i < DATA_WIDTH;i= i + 1)
        begin:loop
            assign data_out[i] = data_q[DATA_WIDTH - 1 - i];
        end
    endgenerate


endmodule