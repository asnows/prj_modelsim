module lvds_rx
#(
	 parameter GROUP = "group_0",
	 parameter DIFF_TERM = "FALSE",
	 parameter IDELAY_OFFSET = 2,
	 parameter DATA_RATE = "DDR",
	 parameter DATA_WIDTH = 10 

)
(
	input clk			,
	input clkdiv		,
	input reset 		,
	input[DATA_WIDTH - 1 :0] pattern,
	input bit_align_en	,
	input idelayCtrl_rdy,
	input datain_p		,
	input datain_n		,
	output[DATA_WIDTH - 1 :0] tdata,
	output bitslip_done 
	

);





	wire idelay_m_tdata;
	wire idelay_s_tdata ;
	wire[4:0] tap_value ;
	reg[4:0] master_tapValue ;
	reg[4:0] slave_tapValue ;
	
	wire[DATA_WIDTH - 1 :0] iser_m_tdata;
	wire[DATA_WIDTH - 1 :0] iser_s_tdata;
	wire bitslip;

	wire ibufds_out_p;
	wire ibufds_out_n;
	wire align_done ;

	assign tdata = iser_m_tdata;



	IBUFDS_DIFF_OUT 
	#(
		.DIFF_TERM		(DIFF_TERM	), // Differential Termination, "TRUE"/"FALSE" 
		.IBUF_LOW_PWR	("TRUE"		), // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD		("DEFAULT"	)  // Specify the input I/O standard
	) 
	IBUFDS_DIFF_OUT_inst 
	(
		.O	(ibufds_out_p	), // Buffer diff_p output
		.OB	(ibufds_out_n	), // Buffer diff_n output
		.I	(datain_p		), // Diff_p buffer input (connect directly to top-level port)
		.IB	(datain_n		)  // Diff_n buffer input (connect directly to top-level port)
	);



	(* IODELAY_GROUP = GROUP *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL 指定综合属�??
	IDELAYE2 
	#(
		.CINVCTRL_SEL			("FALSE"	), // Enable dynamic clock inversion (FALSE, TRUE)
		.DELAY_SRC				("IDATAIN"	), // Delay input (IDATAIN, DATAIN)
		.HIGH_PERFORMANCE_MODE	("FALSE"	), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
		.IDELAY_TYPE			("VAR_LOAD"	), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		.IDELAY_VALUE			(0			), // Input delay tap setting (0-31)
		.PIPE_SEL				("FALSE"	), // Select pipelined mode, FALSE, TRUE
		.REFCLK_FREQUENCY		(200.0		), // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		.SIGNAL_PATTERN			("DATA"		)  // DATA, CLOCK input signal
	)
	IDELAYE2_master 
	(
		.CNTVALUEOUT	(				), // 5-bit output: Counter value output
		.DATAOUT		(idelay_m_tdata	), // 1-bit output: Delayed data output
		.C				(clk			), // 1-bit input: Clock input
		.CE				(1'b0			), // 1-bit input: Active high enable increment/decrement input
		.CINVCTRL		(1'b0			), // 1-bit input: Dynamic clock inversion input
		.CNTVALUEIN		(master_tapValue), // 5-bit input: Counter value input
		.DATAIN			(1'b0			), // 1-bit input: Internal delay data input
		.IDATAIN		(ibufds_out_p	), // 1-bit input: Data input from the I/O
		.INC			(1'b0			), // 1-bit input: Increment / Decrement tap delay input
		.LD				(1'b1			), // 1-bit input: Load IDELAY_VALUE input
		.LDPIPEEN		(1'b0			), // 1-bit input: Enable PIPELINE register to load data input
		.REGRST			(reset			)  // 1-bit input: Active-high reset tap-delay input		
	);



	lvds_iserdese
	#(
		.DATA_RATE (DATA_RATE ),
		.DATA_WIDTH(DATA_WIDTH)

	)
	lvds_iserdese_master
	(
		.clk		(clk			),
		.clkdiv		(clkdiv			),
		.reset		(reset			),
		.d			(1'b0			),
		.ddly		(idelay_m_tdata	),
		.bitslip	(bitslip		),
		.data_out	(iser_m_tdata	)

	);



	(* IODELAY_GROUP = GROUP *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL 指定综合属�??
	IDELAYE2 
	#(
		.CINVCTRL_SEL			("FALSE"	), // Enable dynamic clock inversion (FALSE, TRUE)
		.DELAY_SRC				("IDATAIN"	), // Delay input (IDATAIN, DATAIN)
		.HIGH_PERFORMANCE_MODE	("FALSE"	), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
		.IDELAY_TYPE			("VAR_LOAD"	), // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
		.IDELAY_VALUE			(0			), // Input delay tap setting (0-31)
		.PIPE_SEL				("FALSE"	), // Select pipelined mode, FALSE, TRUE
		.REFCLK_FREQUENCY		(200.0		), // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
		.SIGNAL_PATTERN			("DATA"		)  // DATA, CLOCK input signal
	)
	IDELAYE2_slave
	(
		.CNTVALUEOUT	(				), // 5-bit output: Counter value output
		.DATAOUT		(idelay_s_tdata	), // 1-bit output: Delayed data output
		.C				(clk			), // 1-bit input: Clock input
		.CE				(1'b0			), // 1-bit input: Active high enable increment/decrement input
		.CINVCTRL		(1'b0			), // 1-bit input: Dynamic clock inversion input
		.CNTVALUEIN		(slave_tapValue ), // 5-bit input: Counter value input
		.DATAIN			(1'b0			), // 1-bit input: Internal delay data input
		.IDATAIN		(ibufds_out_n	), // 1-bit input: Data input from the I/O
		.INC			(1'b0			), // 1-bit input: Increment / Decrement tap delay input
		.LD				(1'b1			), // 1-bit input: Load IDELAY_VALUE input
		.LDPIPEEN		(1'b0			), // 1-bit input: Enable PIPELINE register to load data input
		.REGRST			(reset			)  // 1-bit input: Active-high reset tap-delay input
	);
			
			
	lvds_iserdese
	#(
		.DATA_RATE (DATA_RATE ),
		.DATA_WIDTH(DATA_WIDTH)

	)
	lvds_iserdese_slave
	(
		.clk		(clk			),
		.clkdiv		(clkdiv			),
		.reset		(reset			),
		.d			(1'b0			),
		.ddly		(idelay_s_tdata	),
		.bitslip	(bitslip		),
		.data_out	(iser_s_tdata	)

	);
		
			

	bit_alignment 
	#(
		.DATA_WIDTH(DATA_WIDTH) 
	)
	bit_alignment_i
	(
		.clk			(clkdiv			),
		.reset			(reset			),
		.enable			(bit_align_en	),
		.idelayCtrl_rdy	(idelayCtrl_rdy	),
		.master_data	(iser_m_tdata	),
		.slave_data		(iser_s_tdata	),
		.tap_value		(tap_value		),
		.bit_align_done (align_done		)
	);
		

	lvds_bitslip
	#(
		.DATA_WIDTH(DATA_WIDTH) 
	)
	lvds_bitslip_i
	(
		.clk(clkdiv),
		.bitslip_en(align_done),
		.pattern(pattern),
		.data_in(iser_m_tdata),

		.bitslip(bitslip),
		.bitslip_done(bitslip_done)
	);
		
	always@(posedge clkdiv)
	begin
		master_tapValue <= tap_value;
		slave_tapValue  <= tap_value + IDELAY_OFFSET;
	end	
				


endmodule