module alu(
  num1,
  num2,
  op,
  overflow,
  cf,
  result
);
  input [3:0] num1;
  input [3:0] num2
  input [2:0] op;
  output overflow;
  output cf;
  output [3:0] result;

  always @ (*)
    case (op)
      // add
      3'b000: 
        begin 
          {cf,result} = (num1 + num2);
          overflow = (num1[3]==nums2[3])&&(result[3]!=num1[3]);
        end;   
      // sub
      3'b001: 
        begin 
          num2 = ~num2 + 1;
          {cf,result} = (num1 + num2);

        end;  
      // not
      3'b010: result = !num1;   
      // and
      3'b011: result = (num1 & num2);   
      // or
      3'b100: result = (num1 | num2);   
      // xor
      3'b101: result = (num1 ^ num2);   
      // compare
      3'b110: result = (num1 < num2) ? 4'b0001 : 4'b0000;   
      // equal
      3'b111: result = (num1 == num2) ? 4'b0001 : 4'b0000; ;   
      default: result = 4'b0000;
    endcase
endmodule

