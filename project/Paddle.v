module Paddle(clk,x,pb0, pb1, vsp, hsp , intersect);
input clk;
input pb0; //to move up
input pb1; // to move down
input [9:0] hsp, vsp;
input [9:0] x;

reg [9:0] y = 10'd240; //paddle position
wire pb0_d, pb1_d;

//module debouncer(clk,val, d_val);
debouncer db0(clk,pb0,pb0_d);
debouncer db1(clk,pb1,pb1_d);

wire paddle_c;
parameter speed= 25'd1000; // speed of paddle
output reg intersect = 1'b0;

assign paddle_c = pb0_d ^ pb1_d; // only 1 button can be pushed at once


always @(posedge clk)
begin

	if (paddle_c == 1'b1)
	begin
		if (pb0_d == 1'b1)
			y <= y - 10'd5;
		else
		begin
			if (pb1_d == 1'b1)
				y <= y + 10'd5;
		end
	end




	//move paddle
//	if(paddle_c == 1'b1)
//	begin 
//		if (y == speed)
//			y <=0;
//		else
//			y <= y +1;
//	end
//	//the limit to how far the push button can move the paddle vertically
//	if (pb0_d == 1'b1 && y == speed && y !== 0)
//		y <= y -1;
//	else if (pb1_d == 1'b1 && paddle_c == speed && y !== 480 - 60 - 1)
//		y <=y +1;	
	
	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd50 && vsp < y + 10'd50);
end


endmodule
