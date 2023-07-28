module top (
    input clk,
    input rst,
    input [15:0] sw,
    input ps2_clk,
    input ps2_data,
    output [15:0] ledr,
    output VGA_CLK,
    output VGA_HSYNC,
    output VGA_VSYNC,
    output VGA_BLANK_N,
    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B,
    output [7:0] seg0,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] seg3,
    output [7:0] seg4,
    output [7:0] seg5,
    output [7:0] seg6,
    output [7:0] seg7
);

/*
example led1(
    .clk(clk),
    .rst(rst),
    .ledr({ledr[15:10]})
);

assign1 switch1(
    .sw({sw[9:0]}),
    .ledr({ledr[1:0]})
);
*/

assign2 ass2(
    .sw({sw[7:0]}),
    .enable({sw[8]}),
    .pilot({ledr[4]}),
    .ledr({ledr[2:0]}),
    .o_seg0(seg0)
);

endmodule