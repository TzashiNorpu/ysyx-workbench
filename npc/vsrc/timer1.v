module timer1(
  input clk,
  input en,
  input stop,
  input reset,
  output [7:0] o_seg1,
  output [7:0] o_seg0
);

  reg [24:0] count_clk; 
  reg [15:0] count_seg;
  reg cf;

initial begin
  assign count_seg = 16'b0;
end

  always @(posedge clk)
    begin
    if(reset)
      count_seg <= 16'b0;
    else if(en & ~stop) 
      begin
        // if(count_clk==24999999)
        if(count_clk==5)
          begin
            count_clk <=0;
            // out <= ~out;
            if(cf==1'b1) 
              begin
                cf <= 1'b0;
                count_seg <= 16'b0;
              end
            else
              begin
                if(count_seg[7:0]==8'b0000_1001)
                  begin
                    count_seg[7:0] <= 8'b0;
                    count_seg[15:8] <= count_seg[15:8] + 1;
                  end
                else if(count_seg[7:0]==8'b0000_1001 & count_seg[15:8]==8'b0000_1001)
                    cf <= 1'b1;
                else
                  count_seg[7:0] <= count_seg[7:0] + 1;
              end
          end
        else
          count_clk <= count_clk+1;
      end
    end

  display d1(count_seg[7:0],1,o_seg0);
  display d2(count_seg[15:8],1,o_seg1);

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

module display(num,en,seg);
  input  [7:0] num;
  input  en;
  output [7:0] seg;

  wire [7:0] segs [10:0];
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

  reg [3:0] offset;
  assign offset = num[3:0];
  assign seg = ~segs[offset + 3'd0];
endmodule