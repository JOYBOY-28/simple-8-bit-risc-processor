// Testbench for simple_8bit_cpu

module tb_simple_8bit_cpu();

  reg clk;
  reg reset;

  // Instantiate the processor
  simple_8bit_cpu uut (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test sequence
  initial begin
    // Initialize
    $display("Starting simulation...");
    reset = 1;
    #10;
    reset = 0;

    // Run simulation for some cycles
    #200;
    $display("Simulation done.");
    $finish;
  end

  // Dump waveform data
  initial begin
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, uut);         // Dump all variables from the uut (Unit Under Test)
  end

endmodule
