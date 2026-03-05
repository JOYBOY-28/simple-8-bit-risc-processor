module tb_instruction_register();
  reg clk, load_ir;
  reg [15:0] instr_in;
  wire [15:0] instr_out;

  instruction_register dut (.clk(clk), .load_ir(load_ir), .instr_in(instr_in), .instr_out(instr_out));

  initial begin clk = 0; forever #5 clk = ~clk; end

  initial begin
    load_ir = 0; instr_in = 16'hABCD;
    #10 load_ir = 1;
    #10 load_ir = 0; instr_in = 16'h1234;
    #10 $finish;
  end
   initial begin
  #10
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, dut);         // Dump all variables from the uut (Unit Under Test)
   
  end
endmodule