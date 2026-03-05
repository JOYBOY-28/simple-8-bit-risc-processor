module alu_accumulator (
  input wire clk,
  input wire [7:0] acc_data,   
  input wire [7:0] reg_data,   
  input wire [7:0] immediate,  
  input wire [2:0] alu_op,     
  input wire load_acc,         
  output reg [7:0] acc_out,    
  output reg [7:0] result,     
  output reg zero_flag           
);

  reg [7:0] alu_out;

  always @(*) begin
    case (alu_op)
      3'b000: alu_out = immediate;           
      3'b001: alu_out = acc_data + reg_data;
      3'b010: alu_out = acc_data - reg_data; 
      3'b011: alu_out = acc_data & reg_data; 
      3'b100: alu_out = acc_data | reg_data;
      3'b101: alu_out = ~acc_data;           
      default: alu_out = 8'b0;
    endcase
  end

  always @(posedge clk) begin
    if (load_acc)
      acc_out <= alu_out;
    result <= alu_out;
    zero_flag <= (alu_out == 8'b0);
  end

endmodule
