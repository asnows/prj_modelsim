module fifo_axis
#(
    parameter DATA_WIDTH = 10,
    parameter IMG_HEIGHT = 480
)
(
    input          wr_clk,
    input[DATA_WIDTH-1 : 0 ]  wr_data ,
    input          s_axis_tlast ,
    input          s_axis_tuser ,
    input          s_axis_tvalid ,
    
	input          m_axis_aclk,
    output         m_axis_tlast ,
    output         m_axis_tuser ,
    output         m_axis_tvalid ,   
    output[DATA_WIDTH-1:0]m_axis_tdata
);

//  <-----Cut code below this line---->

   // FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
   //           Artix-7
   // Xilinx HDL Language Template, version 2018.2

   FIFO36E1 #(
      .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
      .ALMOST_FULL_OFFSET(13'h0080),     // Sets almost full threshold
      .DATA_WIDTH(DATA_WIDTH),           // Sets data width to 4-72
      .DO_REG(1),                        // Enable output register (1-0) Must be 1 if EN_SYN = FALSE
      .EN_ECC_READ("FALSE"),             // Enable ECC decoder, FALSE, TRUE
      .EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, FALSE, TRUE
      .EN_SYN("FALSE"),                  // Specifies FIFO as Asynchronous (FALSE) or Synchronous (TRUE)
      .FIFO_MODE("FIFO36"),              // Sets mode to "FIFO36" or "FIFO36_72" 
      .FIRST_WORD_FALL_THROUGH("FALSE"), // Sets the FIFO FWFT to FALSE, TRUE
      .INIT(72'h000000000000000000),     // Initial values on output port
      .SIM_DEVICE("7SERIES"),            // Must be set to "7SERIES" for simulation behavior
      .SRVAL(72'h000000000000000000)     // Set/Reset value for output port
   )
   FIFO36E1_inst (
      // ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
      .DBITERR(DBITERR),             // 1-bit output: Double bit error status
      .ECCPARITY(ECCPARITY),         // 8-bit output: Generated error correction parity
      .SBITERR(SBITERR),             // 1-bit output: Single bit error status
      // Read Data: 64-bit (each) output: Read output data
      .DO(DO),                       // 64-bit output: Data output
      .DOP(DOP),                     // 8-bit output: Parity data output
      // Status: 1-bit (each) output: Flags and other FIFO status outputs
      .ALMOSTEMPTY(ALMOSTEMPTY),     // 1-bit output: Almost empty flag
      .ALMOSTFULL(ALMOSTFULL),       // 1-bit output: Almost full flag
      .EMPTY(EMPTY),                 // 1-bit output: Empty flag
      .FULL(FULL),                   // 1-bit output: Full flag
      .RDCOUNT(RDCOUNT),             // 13-bit output: Read count
      .RDERR(RDERR),                 // 1-bit output: Read error
      .WRCOUNT(WRCOUNT),             // 13-bit output: Write count
      .WRERR(WRERR),                 // 1-bit output: Write error
      // ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
      .INJECTDBITERR(INJECTDBITERR), // 1-bit input: Inject a double bit error input
      .INJECTSBITERR(INJECTSBITERR),
      // Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
      .RDCLK(RDCLK),                 // 1-bit input: Read clock
      .RDEN(RDEN),                   // 1-bit input: Read enable
      .REGCE(REGCE),                 // 1-bit input: Clock enable
      .RST(RST),                     // 1-bit input: Reset
      .RSTREG(RSTREG),               // 1-bit input: Output register set/reset
      // Write Control Signals: 1-bit (each) input: Write clock and enable input signals
      .WRCLK(WRCLK),                 // 1-bit input: Rising edge write clock.
      .WREN(WREN),                   // 1-bit input: Write enable
      // Write Data: 64-bit (each) input: Write input data
      .DI(DI),                       // 64-bit input: Data input
      .DIP(DIP)                      // 8-bit input: Parity input
   );

   // End of FIFO36E1_inst instantiation
					



endmodule