module keyboard(
  input clk,
  input resetn,
  input ps2_clk,
  input ps2_data,
  output [7:0] o_seg0,
  output [7:0] o_seg1,
  output [7:0] o_seg2,
  output [7:0] o_seg3,
  output [7:0] o_seg4,
  output [7:0] o_seg5
);

    reg [9:0] buffer;        // ps2_data bits
    reg [3:0] count;  // count ps2_data bits
    reg [2:0] ps2_clk_sync;
    reg [7:0] seg_v;

    reg en;
    reg [23:0] tmp;
    reg [7:0] press_count;


    initial begin
      en = 1;
    end
    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];

    always @(posedge clk) begin
        if (resetn == 0) begin // reset
            count <= 0;
        end
        else begin
            if (sampling) begin
              if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    $display("receive %x", buffer[8:1]);

                    /* tmp <= {tmp[15:0],buffer[8:1]};
                    if(tmp[8:1]==8'HF0)
                       en <= 0;
                    else if(tmp[23:16]==8'HF0)
                      en <= 1;
                    if(en == 1) press_count <= press_count + 1; */
                end
                count <= 0;     // for next
              end else begin
                buffer[count] <= ps2_data;  // store ps2_data
                count <= count + 3'b1;
              end
            end
        end
    end
    
    /* ascii_table t(buffer[8:1],seg_v);

    // key_code
    key_display dis1(en,buffer[4:1],o_seg0);
    key_display dis2(en,buffer[8:5],o_seg1);


    // ascii
    key_display dis3(en,seg_v[3:0],o_seg2);
    key_display dis4(en,seg_v[7:4],o_seg3);

    // count
    key_display dis5(1,press_count[3:0],o_seg4);
    key_display dis6(1,press_count[7:4],o_seg5); */

endmodule

module ascii_table(
    input [7:0] key_code,
    output reg [7:0] ascii_value
);
/*
ascii:  30 -> 39 : 0 -> 9  3A -> 40 : :;<=>?@
        41 -> 5A : A -> Z  5B -> 60 : [\]^_`   61 -> 7A : a -> z
*/

/*
键盘扫描码
  a : 1c  b : 32
*/

reg [7:0] map [0:255];

initial begin
    map[8'h1c] = 8'h61; // a
    map[8'h32] = 8'h62; // b
    map[8'h21] = 8'h63; // c
    map[8'h23] = 8'h64; // d
    map[8'h24] = 8'h65; // e
    map[8'h2B] = 8'h66; // f
    map[8'h34] = 8'h67; // g
    map[8'h33] = 8'h68; // h
    map[8'h43] = 8'h69; // i
    map[8'h3B] = 8'h6A; // j
    map[8'h42] = 8'h6B; // k
    map[8'h4B] = 8'h6C; // l
    map[8'h3A] = 8'h6D; // m
    map[8'h31] = 8'h6E; // n
    map[8'h44] = 8'h6F; // o
    map[8'h4D] = 8'h70; // p
    map[8'h15] = 8'h71; // q
    map[8'h2D] = 8'h72; // r
    map[8'h1B] = 8'h73; // s
    map[8'h2C] = 8'h74; // t
    map[8'h3C] = 8'h75; // u
    map[8'h2A] = 8'h76; // v
    map[8'h1D] = 8'h77; // w
    map[8'h22] = 8'h78; // x
    map[8'h35] = 8'h79; // y
    map[8'h1A] = 8'h7A; // z
    map[8'h45] = 8'h61; // 0
    map[8'h16] = 8'h61; // 1
    map[8'h1E] = 8'h61; // 2
    map[8'h26] = 8'h61; // 3
    map[8'h25] = 8'h61; // 4
    map[8'h2E] = 8'h61; // 5
    map[8'h36] = 8'h61; // 6
    map[8'h3D] = 8'h61; // 7
    map[8'h3E] = 8'h61; // 8
    map[8'h46] = 8'h61; // 9
end

always @(*) begin
    ascii_value = map[key_code];
end

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

module key_display(en,num,seg);
  input en;
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

  assign seg = en?~segs[num]:segs[0];
endmodule