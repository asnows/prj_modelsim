module fifo_maxtrix
(
    input clk ,
    input srst ,
    input[10:0] din ,
    input wr_en ,
    input rd_en ,
    output[10:0] dout ,
    output full ,
    output empty 

);


localparam DATA_WIDTH = 11;


   FIFO36E1 #(
      .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
      .ALMOST_FULL_OFFSET(13'h0080),     // Sets almost full threshold
      .DATA_WIDTH(18),           // Sets data width to 4-72
      .DO_REG(1),                        // Enable output register (1-0) Must be 1 if EN_SYN = FALSE
      .EN_ECC_READ("FALSE"),             // Enable ECC decoder, FALSE, TRUE
      .EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, FALSE, TRUE
      .EN_SYN("TRUE"),                  // Specifies FIFO as Asynchronous (FALSE) or Synchronous (TRUE)
      .FIFO_MODE("FIFO36"),              // Sets mode to "FIFO36" or "FIFO36_72" 
      .FIRST_WORD_FALL_THROUGH("FALSE"), // Sets the FIFO FWFT to FALSE, TRUE
      .INIT(72'h000000000000000000),     // Initial values on output port
      .SIM_DEVICE("7SERIES"),            // Must be set to "7SERIES" for simulation behavior
      .SRVAL(72'h000000000000000000)     // Set/Reset value for output port
   )
   FIFO36E1_inst (
      // ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
      .DBITERR(),             // 1-bit output: Double bit error status
      .ECCPARITY(),         // 8-bit output: Generated error correction parity
      .SBITERR(),             // 1-bit output: Single bit error status
      // Read Data: 64-bit (each) output: Read output data
      .DO(dout),                       // 64-bit output: Data output
      .DOP(),                     // 8-bit output: Parity data output
      // Status: 1-bit (each) output: Flags and other FIFO status outputs
      .ALMOSTEMPTY(),     // 1-bit output: Almost empty flag
      .ALMOSTFULL(),       // 1-bit output: Almost full flag
      .EMPTY(empty),                 // 1-bit output: Empty flag
      .FULL(full),                   // 1-bit output: Full flag
      .RDCOUNT(),             // 13-bit output: Read count
      .RDERR(),                 // 1-bit output: Read error
      .WRCOUNT(),             // 13-bit output: Write count
      .WRERR(),                 // 1-bit output: Write error
      // ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
      .INJECTDBITERR(1'b0), // 1-bit input: Inject a double bit error input
      .INJECTSBITERR(1'b0),
      // Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
      .RDCLK(clk),                 // 1-bit input: Read clock
      .RDEN(rd_en),                   // 1-bit input: Read enable
      .REGCE(1'b1),                 // 1-bit input: Clock enable
      .RST(srst),                     // 1-bit input: Reset
      .RSTREG(srst),               // 1-bit input: Output register set/reset
      // Write Control Signals: 1-bit (each) input: Write clock and enable input signals
      .WRCLK(clk),                 // 1-bit input: Rising edge write clock.
      .WREN(wr_en),                   // 1-bit input: Write enable
      // Write Data: 64-bit (each) input: Write input data
      .DI(din),                       // 64-bit input: Data input
      .DIP(8'd0)                      // 8-bit input: Parity input
   );











endmodule