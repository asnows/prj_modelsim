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
      .INJECTSBITERR(1'b1),
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




//  <-----Cut code below this line---->

   // FIFO_SYNC_MACRO: Synchronous First-In, First-Out (FIFO) RAM Buffer
   //                  Artix-7
   // Xilinx HDL Language Template, version 2018.2

   /////////////////////////////////////////////////////////////////
   // DATA_WIDTH | FIFO_SIZE | FIFO Depth | RDCOUNT/WRCOUNT Width //
   // ===========|===========|============|=======================//
   //   37-72    |  "36Kb"   |     512    |         9-bit         //
   //   19-36    |  "36Kb"   |    1024    |        10-bit         //
   //   19-36    |  "18Kb"   |     512    |         9-bit         //
   //   10-18    |  "36Kb"   |    2048    |        11-bit         //
   //   10-18    |  "18Kb"   |    1024    |        10-bit         //
   //    5-9     |  "36Kb"   |    4096    |        12-bit         //
   //    5-9     |  "18Kb"   |    2048    |        11-bit         //
   //    1-4     |  "36Kb"   |    8192    |        13-bit         //
   //    1-4     |  "18Kb"   |    4096    |        12-bit         //
   /////////////////////////////////////////////////////////////////

   // FIFO_SYNC_MACRO  #(
      // .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      // .ALMOST_EMPTY_OFFSET(9'h080), // Sets the almost empty threshold
      // .ALMOST_FULL_OFFSET(9'h080),  // Sets almost full threshold
      // .DATA_WIDTH(DATA_WIDTH), // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      // .DO_REG(0),     // Optional output register (0 or 1)
      // .FIFO_SIZE ("36Kb")  // Target BRAM: "18Kb" or "36Kb" 
   // ) FIFO_SYNC_MACRO_inst (
      // .ALMOSTEMPTY(), // 1-bit output almost empty
      // .ALMOSTFULL(),   // 1-bit output almost full
      // .DO(dout),                   // Output data, width defined by DATA_WIDTH parameter
      // .EMPTY(empty),             // 1-bit output empty
      // .FULL(full),               // 1-bit output full
      // .RDCOUNT(),         // Output read count, width determined by FIFO depth
      // .RDERR(),             // 1-bit output read error
      // .WRCOUNT(),         // Output write count, width determined by FIFO depth
      // .WRERR(),             // 1-bit output write error
      // .CLK(clk),                 // 1-bit input clock
      // .DI(din),                   // Input data, width defined by DATA_WIDTH parameter
      // .RDEN(rd_en),               // 1-bit input read enable
      // .RST(srst),                 // 1-bit input reset
      // .WREN(wr_en)                // 1-bit input write enable
    // );

   // End of FIFO_SYNC_MACRO_inst instantiation







endmodule