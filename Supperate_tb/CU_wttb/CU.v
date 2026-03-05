
module control_unit (
  input wire [15:0] instr,     
  output reg [2:0] alu_op,       
  output reg reg_write_en,     
  output reg [2:0] dest_reg,    
  output reg [2:0] src_reg,      
  output reg [7:0] immediate_val,
  output reg load_acc,           
  output reg pc_write_en,        
  output reg [1:0] pc_sel        
);

  wire [3:0] opcode;
  assign opcode = instr[15:12];

  always @(*) begin
    
    alu_op = 3'b000;
    reg_write_en = 0;
    pc_write_en = 1;
    pc_sel = 2'b00;
    load_acc = 0;
    dest_reg = instr[11:9];
    src_reg  = instr[2:0];
    immediate_val = instr[7:0];

    case (opcode)
      4'b0001: begin 
        reg_write_en = 1;
        load_acc = 1;
      end

      4'b0010: begin 
        reg_write_en = 1;
      end

      4'b0100: begin 
        alu_op = 3'b001; 
        load_acc = 1;
      end

      4'b0101: begin 
        alu_op = 3'b010; 
        load_acc = 1;
      end

      4'b1100: begin 
        pc_write_en = 0;
      end

      4'b1110: begin 
        pc_sel = 2'b01;
      end

      4'b1111: begin 
        pc_sel = 2'b10;
      end

      default: begin
 
      end
    endcase
  end

endmodule
