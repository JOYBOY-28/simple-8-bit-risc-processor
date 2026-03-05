module tb_program_control_unit();
  reg clk, reset, pc_write_enable;
  reg [1:0] pc_sel;
  reg [7:0] branch_addr, isr_addr;
  wire [7:0] PC;

  program_control_unit dut (
    .clk(clk), .reset(reset), .pc_write_enable(pc_write_enable),
    .pc_sel(pc_sel), .branch_addr(branch_addr), .isr_addr(isr_addr), .PC(PC)
  );

  initial begin clk = 0; forever #5 clk = ~clk; end

  initial begin
    reset = 1; pc_write_enable = 0; pc_sel = 2'b00; branch_addr = 8'hAA; isr_addr = 8'h55;
    #10 reset = 0; pc_write_enable = 1;
    #10 pc_sel = 2'b00; // Increment
    #10 pc_sel = 2'b01; // Branch
    #10 pc_sel = 2'b10; // ISR
    #10 pc_sel = 2'b11; // Return from ISR
    #10 $finish;
  end
  initial begin
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, dut);         // Dump all variables from the uut (Unit Under Test)
  end
endmodule
