module VGAController(vga_clk, hs_out, vs_out, vga_r, vga_g, vga_b);
input vga_clk;

logic [9:0] hsp, vsp;
logic disparea;
output logic hs_out, vs_out;
output logic [3:0] vga_r, vga_g, vga_b;

logic [23:0] bgr_data;

//module VHSYNC (clk,hsp,vsp,disparea,hsync, vsync);
VHSYNC vh1(vga_clk,hsp,vsp,disparea, hs_out, vs_out);

always_ff @(posedge vga_clk)
begin
	
	if (disparea == 1'b0)
	begin
		vga_r <= 4'b1111;
		vga_g <= 4'b0;
		vga_b <= 4'b0;
	end

end

endmodule
