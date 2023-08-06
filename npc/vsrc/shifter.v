module shifter(
  input [7:0] data,
  input sw_edge,
  output [7:0] o_seg1,
  output [7:0] o_seg0
);

  reg random;
  reg [7:0] shift_data;
  initial begin
    assign shift_data = 8'b0010_1100;
  end
  always @(posedge sw_edge)
    begin
      random <= shift_data[4] ^ shift_data[3] ^ shift_data[2] ^ shift_data[0];
      shift_data <= {random,shift_data[7:1]};
    end


  shift_display d1(shift_data[3:0],o_seg0);
  shift_display d2(shift_data[7:4],o_seg1);

endmodule

/*
          7
       -------
    2 |       |  6
      |   1   |
       -------
    3 |       |  5
      |   4   |
       -------   - 0

*/

module shift_display(num,seg);
  input  [3:0] num;
  output [7:0] seg;

  wire [7:0] segs [15:0];
  assign segs[0] = 8'b1111_1101;
  assign segs[1] = 8'b0110_0000;
  assign segs[2] = 8'b1101_1010;
  assign segs[3] = 8'b1111_0010;
  assign segs[4] = 8'b0110_0110;
  assign segs[5] = 8'b1011_0110;
  assign segs[6] = 8'b1011_1110;
  assign segs[7] = 8'b1110_0000;
  assign segs[8] = 8'b1111_1110;
  assign segs[9] = 8'b1111_0110;
  assign segs[10] = 8'b1110_1110; // A
  assign segs[11] = 8'b1111_1110; // B
  assign segs[12] = 8'b1001_1100; // C
  assign segs[13] = 8'b1111_1100; // D
  assign segs[14] = 8'b1001_1110; // E
  assign segs[15] = 8'b1000_1110; // F

  assign seg = ~segs[num];
endmodule