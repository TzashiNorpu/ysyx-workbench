module example(
  input clk,
  input rst,
  output reg [15:10] ledr
);
  reg [31:0] count;
  always @(posedge clk) begin
    if (rst) begin ledr <= 1; count <= 0; end
    else begin
      if (count % 10 == 0) ledr <= {ledr[14:10], ledr[15]};
      count <= (count >= 500 ? 32'b0 : count + 1);
    end
  end
endmodule