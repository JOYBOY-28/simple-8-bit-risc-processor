module instruction_memory (
  input  wire        clk,
  input  wire [3:0]  addr,       
  output reg  [15:0] instruction 
);

  always @(posedge clk) begin
    case (addr)
      4'h0: instruction <= 16'h1003; 
      4'h1: instruction <= 16'h2200;  
      4'h2: instruction <= 16'h100A;  
      4'h3: instruction <= 16'h5401;  
      4'h5: instruction <= 16'h2200;
      4'h6: instruction <= 16'h2E00;
      4'h7: instruction <= 16'h0000;
      4'h8: instruction <= 16'h0000;
      4'h9: instruction <= 16'h0000;
      4'hA: instruction <= 16'h0000;
      4'hB: instruction <= 16'h0000;
      4'hC: instruction <= 16'h0000;
      4'hD: instruction <= 16'h0000;
      4'hE: instruction <= 16'h0000;
      4'hF: instruction <= 16'h0000;
      default: instruction <= 16'h0000;
    endcase
  end

endmodule
