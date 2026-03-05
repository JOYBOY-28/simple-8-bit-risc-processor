// Testbench for register_file
module tb_register_file();

  reg clk;
  reg write_enable;
  reg [2:0] read_reg1;
  reg [2:0] read_reg2;
  reg [2:0] write_reg;
  reg [7:0] write_data;
  wire [7:0] read_data1;
  wire [7:0] reg_out;

  // Instantiate the register file
  register_file uut (
    .clk(clk),
    .write_enable(write_enable),
    .read_reg1(read_reg1),
    .read_reg2(read_reg2),
    .write_reg(write_reg),
    .write_data(write_data),
    .read_data1(read_data1),
    .reg_out(reg_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test procedure
  initial begin
    $display("Starting register_file test...");
    // Initialize
    write_enable = 0;
    write_reg = 3'b000;
    write_data = 8'hAA;
    read_reg1 = 3'b000;
    read_reg2 = 3'b000;
    
    // Write 0xAA into R0
    #10;
    write_enable = 1;
    #10;
    write_enable = 0;

    // Read R0 back
    #10;
    $display("Read R0: %h (expected AA)", read_data1);

    // Write 0x77 into R7
    write_reg = 3'b111;
    write_data = 8'h77;
    write_enable = 1;
    #10;
    write_enable = 0;

    // Check reg_out (should be R7)
    #10;
    $display("reg_out (R7): %h (expected 77)", reg_out);

    $finish;
  end
   initial begin
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, uut);         // Dump all variables from the uut (Unit Under Test)
   
  end

endmodule
