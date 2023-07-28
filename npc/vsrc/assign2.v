module encode83(x,en,y);
  input  [7:0] x;
  input  en;
  output reg [2:0] y;
  integer i;
  always @(x or en) begin
    if (en) begin
      y = 0;
      // 高位优先编码
      for( i = 0; i <= 7; i = i+1)
          if(x[i] == 1)  y = i[2:0];
    end
    else  y = 0;
  end

endmodule

module seg_display(x,en,o_seg0);
  input  [7:0] x;
  input  en;
  output [7:0] o_seg0;

  wire [7:0] segs [7:0];
  assign segs[0] = 8'b11111101;
  assign segs[1] = 8'b01100000;
  assign segs[2] = 8'b11011010;
  assign segs[3] = 8'b11110010;
  assign segs[4] = 8'b01100110;
  assign segs[5] = 8'b10110110;
  assign segs[6] = 8'b10111110;
  assign segs[7] = 8'b11100000;

  reg [2:0] offset;
  integer i;

  always @(x or en) begin
    if (en) begin
      offset = 0;
      for( i = 0; i <=7; i = i+1)
          if(x[i] == 1)  offset = i[2:0];
    end
    else  offset = 0;
  end

  assign o_seg0 = ~segs[offset + 3'd0];
endmodule



module assign2(
  input [7:0] sw,
  input enable,
  output pilot ,
  output [2:0] ledr,
  output [7:0] o_seg0
);
  assign pilot = enable;
  encode83 encoder(sw,enable,ledr);
  seg_display seg(sw,enable,o_seg0);
 
endmodule