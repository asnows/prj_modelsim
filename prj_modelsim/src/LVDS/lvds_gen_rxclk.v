

module lvds_gen_rxclk
#(
	parameter GROUP = "group_0",
	parameter SERI_FACTOR = 10 ,
	parameter PIXEL_CLOCK = "BUFG_BUFG" 


)
(
	input clrl_refclk,
	input reset,
	input rx_clkin_p,
	input rx_clkin_n,

	output rx_clk,
	output rx_clkdiv,
	output idelayCtrl_rdy

);

	wire ibufds_clk_p;
	wire ibufds_clk_n;



	wire idelay_clk;
	wire pixel_clk;
	reg[4:0] clk_tapValue = 5'd0;

	wire clkdiv_buf;
	wire rdy;


	wire clk_mmcm_out0;
	wire clk_mmcm_out1;
	wire clk_mmcm_fb;
	wire clk_mmcm_locked;
	wire idelayCtrl_refclk;
	
	
	
	assign idelayCtrl_rdy = rdy & clk_mmcm_locked;
	assign rx_clk = pixel_clk;
	assign rx_clkdiv = clkdiv_buf;
	
	BUFG BUFG_idelayCtrl
    (
        .O(idelayCtrl_refclk), // 1-bit output: Clock output
        .I(clrl_refclk)  // 1-bit input: Clock input
    );
	

	IBUFDS_DIFF_OUT 
	#(
		.DIFF_TERM	("FALSE"	),   // Differential Termination, "TRUE"/"FALSE" 
		.IBUF_LOW_PWR	("TRUE"		), // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD	("DEFAULT"	) // Specify the input I/O standard
	) 
	IBUFDS_DIFF_OUT_CLK 
	(
		.O	(ibufds_clk_p), // Buffer diff_p output
		.OB	(ibufds_clk_n), // Buffer diff_n output
		.I	(rx_clkin_p	), // Diff_p buffer input (connect directly to top-level port)
		.IB	(rx_clkin_n	)  // Diff_n buffer input (connect directly to top-level port)
	);



   (* IODELAY_GROUP = GROUP *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
   IDELAYCTRL IDELAYCTRL_inst 
   (
      .RDY		(rdy	),  // 1-bit output: Ready output
      .REFCLK	(idelayCtrl_refclk	), // 1-bit input: Reference clock input
      .RST		(reset			)  // 1-bit input: Active / reset input
   );

	

  MMCME2_BASE 
  #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(2.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(2.245),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(12),
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(2.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(clk_mmcm_out0),     // 1-bit output: CLKOUT0
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1(clk_mmcm_out1),     // 1-bit output: CLKOUT1
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(),     // 1-bit output: CLKOUT2
      .CLKOUT2B(),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(),     // 1-bit output: CLKOUT3
      .CLKOUT3B(),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(),     // 1-bit output: CLKOUT4
      .CLKOUT5(),     // 1-bit output: CLKOUT5
      .CLKOUT6(),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clk_mmcm_fb),   // 1-bit output: Feedback clock
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(clk_mmcm_locked),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(ibufds_clk_p),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down
      .RST(reset),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk_mmcm_fb)      // 1-bit input: Feedback clock
   );
   
   
   
    generate
        case(PIXEL_CLOCK)
            "BUFG_BUFG":
            begin
                BUFG BUFG_pixel_clk
                (
                    .O(pixel_clk), // 1-bit output: Clock output
                    .I(clk_mmcm_out0)  // 1-bit input: Clock input
                );
                
                BUFG BUFG_clkdiv_buf
                (
                    .O(clkdiv_buf), // 1-bit output: Clock output
                    .I(clk_mmcm_out1)  // 1-bit input: Clock input
                );
            
            end
        
            "BUFR_BUFIO":
            begin
            
                BUFIO BUFIO_pixel_clk 
                (
                    .O(pixel_clk), // 1-bit output: Clock output (connect to I/O clock loads).
                    .I(clk_mmcm_out0)  // 1-bit input: Clock input (connect to an IBUF or BUFMR).
                );
                
                BUFR 
                #(
                    .BUFR_DIVIDE("BYPASS"),   // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8" 
                    .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES" 
                )
                BUFR_clkdiv_buf 
                (
                    .O(clkdiv_buf),     // 1-bit output: Clock output port
                    .CE(1'b0),   // 1-bit input: Active high, clock enable (Divided modes only)
                    .CLR(1'b0), // 1-bit input: Active high, asynchronous clear (Divided modes only)
                    .I(clk_mmcm_out1)      // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
                );
            end
        
            "BUFR_BUFR":
            begin
            
                BUFR 
                #(
                    .BUFR_DIVIDE("BYPASS"),   // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8" 
                    .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES" 
                )
                BUFR_pixel_clk 
                (
                    .O(pixel_clk),     // 1-bit output: Clock output port
                    .CE(1'b0),   // 1-bit input: Active high, clock enable (Divided modes only)
                    .CLR(1'b0), // 1-bit input: Active high, asynchronous clear (Divided modes only)
                    .I(clk_mmcm_out0)      // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
                );
                
                
                BUFR 
                #(
                    .BUFR_DIVIDE("BYPASS"),   // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8" 
                    .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES" 
                )
                BUFR_clkdiv_buf
                (
                    .O(clkdiv_buf),     // 1-bit output: Clock output port
                    .CE(1'b0),   // 1-bit input: Active high, clock enable (Divided modes only)
                    .CLR(1'b0), // 1-bit input: Active high, asynchronous clear (Divided modes only)
                    .I(clk_mmcm_out1)      // 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
                );
            end
        
            default:
            begin
                BUFG BUFG_pixel_clk
                (
                    .O(pixel_clk), // 1-bit output: Clock output
                    .I(clk_mmcm_out0)  // 1-bit input: Clock input
                );
                
                BUFG BUFG_clkdiv_buf
                (
                    .O(clkdiv_buf), // 1-bit output: Clock output
                    .I(clk_mmcm_out1)  // 1-bit input: Clock input
                );
            
            end
        
        endcase
    endgenerate	

	
	
	
	
endmodule
