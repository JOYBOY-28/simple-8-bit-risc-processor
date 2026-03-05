module program_control_unit (
  input wire clk,
  input wire reset,
  input wire pc_write_enable,
  input wire [1:0] pc_sel,           
  input wire [7:0] branch_addr,     
  input wire [7:0] isr_addr,        
  output reg [7:0] PC
);

  reg [7:0] stackPC;  

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      PC <= 8'b0;
      stackPC <= 8'b0;
    end
    else if (pc_write_enable) begin
      case (pc_sel)
        2'b00: PC <= PC + 1;            
        2'b01: PC <= branch_addr;       
        2'b10: begin                      
          stackPC <= PC;
          PC <= isr_addr;
        end
        2'b11: PC <= stackPC;             
        default: PC <= PC;
      endcase
    end
  end

endmodule

