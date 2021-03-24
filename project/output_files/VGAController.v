module VGAController(vga_clk, hs_out, vs_out, vga_r, vga_g, vga_b);
input vga_clk;

wire [9:0] hsp, vsp;
wire disparea;
output hs_out, vs_out;
output reg [3:0] vga_r, vga_g, vga_b;

reg [23:0] bgr_data;

//module VHSYNC (clk,hsp,vsp,disparea,hsync, vsync);
VHSYNC vh1(vga_clk,hsp,vsp,disparea, hs_out, vs_out);

always @(posedge vga_clk)
begin	
	
	if (disparea == 1'b1)
	begin
	
		if (vsp > 10'd50 && vsp < 10'd80)
		begin
		vga_r <= 4'b1111;
		vga_g <= 4'b0;
		vga_b <= 4'b0;
		end
		else if (vsp > 10'd150 && vsp < 10'd180)
		begin
		vga_r <= 4'b0;
		vga_g <= 4'b1111;
		vga_b <= 4'b0;
		end
		else if (vsp > 10'd220 && vsp < 10'd250)
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
