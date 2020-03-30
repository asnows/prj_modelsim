module genClk
(
input rst,
input sys_clk,
input[6:0]f1_freq,
output f1 ,
output f2 ,
output rs ,
output cp ,
output shp,
output shd,
output clk_locked
);

wire clk_fb;

   MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(2.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(10.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(f1_freq),
      .CLKOUT2_DIVIDE(f1_freq),
      .CLKOUT3_DIVIDE(f1_freq),
      .CLKOUT4_DIVIDE(f1_freq),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(f1_freq),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.15),
      .CLKOUT2_DUTY_CYCLE(0.15),
      .CLKOUT3_DUTY_CYCLE(0.15),
      .CLKOUT4_DUTY_CYCLE(0.15),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(270.0),   //shd
      .CLKOUT2_PHASE(90.0),  //shp
      .CLKOUT3_PHASE(90.0),  //cp
      .CLKOUT4_PHASE(0.0), //rs
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(4),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0 (f2	),     // 1-bit output: CLKOUT0
      .CLKOUT0B(f1	),   // 1-bit output: Inverted CLKOUT0
      .CLKOUT1 (	),     // 1-bit output: CLKOUT1
      .CLKOUT1B(shd ),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2 (	),     // 1-bit output: CLKOUT2
      .CLKOUT2B(shp ),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3 (rs  ),     // 1-bit output: CLKOUT3
      .CLKOUT3B(    ),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4 (cp  ),     // 1-bit output: CLKOUT4
      .CLKOUT5 (),     // 1-bit output: CLKOUT5
      .CLKOUT6 (),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clk_fb),   // 1-bit output: Feedback clock
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(clk_locked),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(sys_clk),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down
      .RST(rst),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk_fb)      // 1-bit input: Feedback clock
   );

endmodule