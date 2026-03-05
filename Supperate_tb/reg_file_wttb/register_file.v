module register_file (
  input wire clk,
  input wire write_enable,
  input wire [2:0] read_reg1,  
  input wire [2:0] read_reg2,  
  input wire [2:0] write_reg,  
  input wire [7:0] write_data, 
  output wire [7:0] read_data1,
  output wire [7:0] reg_out
);

    reg [7:0] reg_array[7:0];
    

    assign read_data1 = reg_array[read_reg1];

    always @(posedge clk) begin
    if (write_enable)
      reg_array[write_reg] <= write_data;
  end
  assign reg_out = reg_array[7]; // can use r7 register to store output

endmodule
