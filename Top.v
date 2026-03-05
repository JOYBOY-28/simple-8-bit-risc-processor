module simple_8bit_cpu (
  input wire clk,
  input wire reset,
  output wire [7:0] acc_port,
  output wire [7:0] reg_port
);

  wire [7:0] pc;
  wire [15:0] instr;
  wire [15:0] ir_out;

  wire [2:0] alu_op;
  wire reg_write_en;
  wire [2:0] dest_reg;
  wire [2:0] src_reg;
  wire [7:0] immediate_val;
  wire load_acc;
  wire pc_write_en;
  wire [1:0] pc_sel;

  wire [7:0] acc_out;
  assign acc_port =acc_out;
  wire [7:0] reg_data;
  wire [7:0] alu_result;
  wire zero_flag;


  wire [7:0] branch_addr = immediate_val; 
  wire [7:0] isr_addr = 8'h10;             

  program_control_unit PCU (
    .clk(clk),
    .reset(reset),
    .pc_write_enable(pc_write_en),
    .pc_sel(pc_sel),
    .branch_addr(branch_addr),
    .isr_addr(isr_addr),
    .PC(pc)
  );
  instruction_memory IM (
    .clk(clk),
    .addr(pc[3:0]),
    .instruction(instr)
  );
  instruction_register IR (
    .clk(clk),
    .load_ir(1'b1),
    .instr_in(instr),
    .instr_out(ir_out)
  );

  control_unit CU (
    .instr(ir_out),
    .alu_op(alu_op),
    .reg_write_en(reg_write_en),
    .dest_reg(dest_reg),
    .src_reg(src_reg),
    .immediate_val(immediate_val),
    .load_acc(load_acc),
    .pc_write_en(pc_write_en),
    .pc_sel(pc_sel)
  );

  wire [7:0] rf_read_data;
  register_file RF (
    .clk(clk),
    .write_enable(reg_write_en),
    .read_reg1(src_reg),
    .read_reg2(3'b000),            
    .write_reg(dest_reg),
    .write_data(acc_out),          
    .read_data1(rf_read_data),
    .reg_out (reg_port)             
  );

  alu_accumulator ALU (
    .clk(clk),
    .acc_data(acc_out),
    .reg_data(rf_read_data),
    .immediate(immediate_val),
    .alu_op(alu_op),
    .load_acc(load_acc),
    .acc_out(acc_out),
    .result(alu_result),
    .zero_flag(zero_flag)
  );

endmodule

