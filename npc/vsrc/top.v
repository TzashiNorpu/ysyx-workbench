module top (
    input clk,
    input rst,
    input [15:0] sw,
    input btnc,
    input btnu,
    input btnd,
    input btnl,
    input btnr,
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
    .sw({sw[7:0]}),
    .enable({sw[8]}),
    .pilot({ledr[4]}),
    .ledr({ledr[2:0]}),
    .o_seg0(seg0)
); 
alu alu1(
    .num1({sw[3:0]}),
    .num2({sw[8:5]}),
    .op({btn[2:0]}),
    .overflow({ledr[15]}),
    .cf({ledr[14]}),
    .result({ledr[3:0]})
);

timer1 t1(
    .clk(clk),
    .en({sw[0]}),
    .stop({sw[1]}),
    .reset({sw[2]}),
    .o_seg1(seg1),
    .o_seg0(seg0)
);

shifter shifter1(
    .data(sw[7:0]),
    .sw_edge(sw[15]),
    .o_seg1(seg1),
    .o_seg0(seg0)
);
*/
keyboard my_keyboard(
    .clk(clk),
    .resetn(~rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .o_seg0(seg0),
    .o_seg1(seg1),
    .o_seg2(seg2),
    .o_seg3(seg3),
    .o_seg4(seg4),
    .o_seg5(seg5)
);

endmodule