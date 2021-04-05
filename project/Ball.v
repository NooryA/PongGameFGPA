module Ball(rst,clk, hsp, vsp, p1_y,p2_y ,intersect, p1_win, p2_win);

input clk,rst;
input [9:0] p1_y,p2_y;
input [9:0] hsp, vsp;

reg [9:0] x = 10'd320;
reg [9:0] y = 10'd240;
reg [9:0] speedX = 10'd5;
reg [9:0] speedY = 10'd1;
output reg intersect = 1'b0;
output reg p1_win = 1'b0; //need to generate this as a pulse maybe
output reg p2_win = 1'b0; //need to generate this as a pulse maybe

reg [24:0] counter = 25'd0;
parameter MAX = 25'd1000000;
wire d_rst;

debouncer rs0(clk,rst,d_rst);

always @(posedge clk, posedge d_rst)
begin
	if (d_rst)
	begin
		x<= 320;
		y <= 240;
		speedX <= 10'd5;
		speedY <= 1;
	end
	else
	begin
		counter <= counter + 25'd1;
		if (counter >= MAX - 25'd1)
		begin
			counter <= 25'd0;
			x <= x + speedX;
			y <= y + speedY;
			//This is the main Branch
		end
		else
		begin
		//right paddle
			if (x >= 580 && y >= (p1_y - 10'd50) && y < (p1_y + 10'd50)) // bounces off the paddle
			begin
				speedX <= -5;
			end
			//left paddle
			else if (x< 70 && y >= (p2_y - 10'd50) && y < (p2_y + 10'd50)) // bounces off the paddle
			begin
				speedX <= 5;
			end
			else if(y>= 480) // bounces off screen
			begin
				speedY <= -1;
			end
			else if(y<=10) // bounces off screen
			begin
				speedY <=  10'd1;
			end
			else if(x>= 620)// resets ball in the middle
			begin
				x<= 10'd320;
				y <= 10'd240;
				speedX <= -5;
				speedY <= -1;
			end
			else if(x<=30)// resets ball in the middle
			begin
				x<= 10'd320;
				y <= 10'd240;
				speedX <= 10'd5;
				speedY <= 1;
			end
		end
	end
	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd5 && vsp < y + 10'd5);
	
end

endmodule
