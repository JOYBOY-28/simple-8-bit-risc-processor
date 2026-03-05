module tb_instruction_memory();
  reg clk;
  reg [3:0] addr;
  wire [15:0] instruction;

  instruction_memory dut (.clk(clk), .addr(addr), .instruction(instruction));

  initial begin clk = 0; forever #5 clk = ~clk; end

  initial begin
    for (addr = 0; addr < 16; addr = addr + 1) begin
      #1;
    end
    $finish;
  end
  initial begin
  #10
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, dut);         // Dump all variables from the uut (Unit Under Test)
   
  end
endmodule