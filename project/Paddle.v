module Paddle(rst,clk, either_win,x,pb0, pb1, vsp, hsp , intersect, y);
input clk,rst, either_win;
input pb0; //to move up
input pb1; // to move down
input [9:0] hsp, vsp;
input [9:0] x;

output reg [9:0] y = 10'd240; //paddle position
wire pb0_d, pb1_d, rst_d;

//module debouncer(clk,val, d_val);
debouncer db0(clk,pb0,pb0_d);
debouncer db1(clk,pb1,pb1_d);
debouncer db3(clk,rst,rst_d);

wire paddle_c;
parameter speed= 25'd1000; // speed of paddle
output reg intersect = 1'b0;

assign paddle_c = pb0_d ^ pb1_d; // only 1 button can be pushed at once


always @(posedge clk, posedge rst_d)
begin
	if (rst_d)
	begin
		y <= 10'd240;
	end
	else if (either_win)
	begin
		y <= 10'd240;
	end
	else if (paddle_c == 1'b1)
	begin
		if (pb0_d == 1'b1)
			y <= y - 10'd15;
		else
		begin
			if (pb1_d == 1'b1)
				y <= y + 10'd15;
		end
	end

	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd50 && vsp < y + 10'd50);

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
	
end


endmodule
