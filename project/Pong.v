module Pong(clk, pb, rst, hs_out, vs_out, vga_r, vga_g, vga_b, ssd0, ssd2);

input clk; //50Mhz
input [3:0] pb;
input rst;
output hs_out, vs_out;
output [3:0] vga_r, vga_g, vga_b;
wire vga_clk;
wire p1_win, p2_win;
wire [3:0] p1_score, p2_score;
output [7:0] ssd0, ssd2;
						 
vga_pll u1(
	.areset(),
	.inclk0(clk),
	.c0(vga_clk),
	.locked());


//module VGAController(vga_clk, hs_out, vs_out, vga_r, vga_g, vga_r);
VGAController(vga_clk,pb,rst,hs_out,vs_out,vga_r, vga_g, vga_b, p1_win, p2_win);

//module Score(clk,rst, p1_win, p2_win, p1_score, p2_score);
Score sc1(clk,rst,p1_win, p2_win,p1_score, p2_score);

//module ssd_display(in, e, dot);
ssd_display sd0(p1_score, ssd0, 1'b0);
ssd_display sd1(p2_score, ssd2, 1'b0);

endmodule
