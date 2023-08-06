module alu(
  input [3:0] num1,
  input [3:0] num2,
  input [2:0] op,
  output reg overflow,
  output reg cf,
  output [3:0] result
);

  reg [1:0] en;
  reg [3:0] tmp;

  always @ (*)
    begin
      en = 2'b00;
      tmp = num2;
      // add | sub | equal | compare
      // if(op==3'b000 | op == 3'b001 || 3'b111 || 3'b110)
      //   begin
      if(op == 3'b001) 
        tmp = ~num2 + 1;
        // end
      else if(op == 3'b111) 
        tmp = ~num2 + 1;
      else if(op == 3'b110) 
        tmp = ~num2 + 1;
      else if(op== 3'b010)  // not
        begin
          en = 2'b01;
          tmp = {4{1'b1}};
        end
      else if(op==3'b011) // and
        en = 2'b10;
      else if(op==3'b100) // or
        en = 2'b11;
      else if(op==3'b101) // xor
        en = 2'b01;
    end

    adder adder_1(en,num1,tmp,overflow,cf,result);
    xorx xor_1(en,num1,tmp,result);
    anda and_1(en,num1,tmp,result);
    oro or_1(en,num1,tmp,result);

endmodule

module adder(
  input [1:0] en,
  input [3:0] num1,
  input [3:0] num2,
  output reg overflow,
  output reg cf,
  output reg [3:0] result
);
  always @ (*) 
    begin
      if(en==2'b00)
        begin
          {cf,result} = num1 + num2;
          overflow = (num1[3] & num2[3] & ~result[3]) | (~num1[3] & ~num2[3] & result[3]);
        end
    end
endmodule

module xorx(
  input [1:0] en,
  input [3:0] num1,
  input [3:0] num2,
  output reg [3:0] result
);
  always @(*)
    begin
      if(en==2'b01)
        {result} = {num1[3] ^ num1[3],num1[2] ^ num1[2],num1[1]^num1[1],num1[0]^num1[0]};
    end
endmodule

module anda(
  input [1:0] en,
  input [3:0] num1,
  input [3:0] num2,
  output reg [3:0] result
);
  always @(*)
    begin
      if(en==2'b10)
        {result} = {num1[3] & num1[3],num1[2] & num1[2],num1[1] & num1[1],num1[0] & num1[0]};
    end
endmodule

module oro(
  input [1:0] en,
  input [3:0] num1,
  input [3:0] num2,
  output reg [3:0] result
);
  always @(*)
    begin
      if(en==2'b11)
        {result} = {num1[3] | num1[3],num1[2] | num1[2],num1[1] | num1[1],num1[0] | num1[0]};
    end
endmodule

