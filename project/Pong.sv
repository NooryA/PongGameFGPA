module Pong(clk, hs_out, vs_out, vga_r, vga_g, vga_b);

input clk; //50Mhz

output hs_out, vs_out;
output [3:0] vga_r, vga_g, vga_b;
logic vga_clk;



						 
vga_pll u1(
	.areset(),
	.inclk0(clk),
	.c0(vga_clk),
	.locked());


//module VGAController(vga_clk, hs_out, vs_out, vga_r, vga_g, vga_r);
VGAController(vga_clk,hs_out,vs_out,vga_r, vga_g, vga_b);


endmodule
