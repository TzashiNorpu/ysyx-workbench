module assign1(
  input [9:0] sw,
  output [1:0] ledr
);

  reg [1:0] F;
  always @ (*)
    case ({sw[1],sw[0]})
      2'b00: F = {sw[3],sw[2]};   
      2'b01: F = {sw[5],sw[4]};  
      2'b10: F = {sw[7],sw[6]};  
      2'b11: F = {sw[9],sw[8]};  
      default: F = 2'b00;
    endcase
    assign ledr = F;
endmodule