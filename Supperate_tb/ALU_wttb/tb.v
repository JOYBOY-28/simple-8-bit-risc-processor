module tb_alu_accumulator();
  reg clk, load_acc;
  reg [7:0] acc_data, reg_data, immediate;
  reg [2:0] alu_op;
  wire [7:0] acc_out, result;
  wire zero_flag;

  alu_accumulator dut (
    .clk(clk), .acc_data(acc_data), .reg_data(reg_data), .immediate(immediate),
    .alu_op(alu_op), .load_acc(load_acc), .acc_out(acc_out), .result(result), .zero_flag(zero_flag)
  );

  initial begin clk = 0; forever #5 clk = ~clk; end

  initial begin
    acc_data = 8'h0A; reg_data = 8'h03; immediate = 8'h00;
    alu_op = 3'b010; load_acc = 1; // SUB A - Rn
    #10;
    alu_op = 3'b001; // ADD A + Rn
    #10;
    load_acc = 0; // Don’t load accumulator
    alu_op = 3'b100; // AND
    #10;
    $finish;
  end
    initial begin
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, dut);         // Dump all variables from the uut (Unit Under Test)
  end
endmodule