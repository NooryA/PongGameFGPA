module Paddle(clk,x,pb0, pb1, vsp, hsp , intersect);
input clk, pb0, pb1;
input [9:0] hsp, vsp;
input [9:0] x;
reg [9:0] y = 10'd240;
output reg intersect = 1'b0;

always @(posedge clk)
begin
	
	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd50 && vsp < y + 10'd50);

end


endmodule
