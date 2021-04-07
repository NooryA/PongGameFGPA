module VGAController(vga_clk, pb,rst, done, hs_out, vs_out, vga_r, vga_g, vga_b, p1_win, p2_win);
input vga_clk;
input [3:0] pb;
input rst, done;
wire [9:0] hsp, vsp;
wire disparea;
output hs_out, vs_out;
output reg [3:0] vga_r, vga_g, vga_b;

wire ball_intersect, p1_intersect, p2_intersect;
wire [9:0] p1_y, p2_y;
output p1_win, p2_win;
wire either_win;
//module VHSYNC (clk,hsp,vsp,disparea,hsync, vsync);
VHSYNC vh1(vga_clk,hsp,vsp,disparea, hs_out, vs_out);

//module Ball(rst,clk,done, hsp, vsp, p1_y,p2_y ,intersect, p1_win, p2_win);

Ball b1(rst,vga_clk,done, hsp, vsp,p1_y,p2_y,ball_intersect, p1_win, p2_win);
assign either_win = p1_win || p2_win || done;
//module Paddle(rst,clk,done,x,pb0, pb1, vsp, hsp , intersect, y);
Paddle p1(rst,vga_clk, either_win ,10'd50,pb[0], pb[1],vsp,hsp, p1_intersect, p1_y);
Paddle p2(rst,vga_clk, either_win, 10'd590,pb[2], pb[3],vsp,hsp, p2_intersect, p2_y);

always @(posedge vga_clk)
begin	
	
	if (disparea == 1'b1)
	begin
		if (ball_intersect)
		begin
			vga_r <= 4'b1111;
			vga_g <= 4'b0;
			vga_b <= 4'b0;
		end
		else if (p1_intersect)
		begin
				vga_r <= 4'b0;
				vga_g <= 4'b1111;
				vga_b <= 4'b0;
		end
		else if (p2_intersect)
		begin
				vga_r <= 4'b0;
				vga_g <= 4'b0;
				vga_b <= 4'b1111;
		end
		else
		begin
			vga_r <= 4'b0;
			vga_g <= 4'b0;
			vga_b <= 4'b0;
		end
		end
	else
	begin
		vga_r <= 4'b0;
		vga_g <= 4'b0;
		vga_b <= 4'b0;
	end
end

endmodule
