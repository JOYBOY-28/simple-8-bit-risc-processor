module tb_control_unit();
  reg [15:0] instr;
  wire [2:0] alu_op;
  wire reg_write_en, load_acc, pc_write_en;
  wire [2:0] dest_reg, src_reg;
  wire [7:0] immediate_val;
  wire [1:0] pc_sel;

  control_unit dut (
    .instr(instr), .alu_op(alu_op), .reg_write_en(reg_write_en),
    .dest_reg(dest_reg), .src_reg(src_reg), .immediate_val(immediate_val),
    .load_acc(load_acc), .pc_write_en(pc_write_en), .pc_sel(pc_sel)
  );

  initial begin
    instr = 16'h100A; #10; // MOVI A, 0x0A
    instr = 16'h2200; #10; // MOV R1, A
    instr = 16'h3001; #10; // MOV A, R1
    instr = 16'h5002; #10; // SUB A, R2
    $finish;
  end
    initial begin
    $dumpfile("my_sim.vcd");   // Specify the VCD file
    $dumpvars(0, dut);         // Dump all variables from the uut (Unit Under Test)
   
  end
endmodule