module VGAController(vga_clk, hs_out, vs_out, vga_r, vga_g, vga_b);
input vga_clk;

wire [9:0] hsp, vsp;
wire disparea;
output hs_out, vs_out;
output reg [3:0] vga_r, vga_g, vga_b;

wire ball_intersect, p1_intersect, p2_intersect;

//module VHSYNC (clk,hsp,vsp,disparea,hsync, vsync);
VHSYNC vh1(vga_clk,hsp,vsp,disparea, hs_out, vs_out);

//module Ball(clk, hsp, vsp, intersect);
Ball b1(vga_clk, hsp, vsp,ball_intersect);

//module Paddle(clk,x,pb0, pb1, vsp, hsp , intersect);

Paddle p1(vga_clk, 10'd50,1'b0, 1'b0,vsp,hsp, p1_intersect);
Paddle p2(vga_clk, 10'd590,1'b0, 1'b0,vsp,hsp, p2_intersect);

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
