module Ball(rst,clk,done, hsp, vsp, p1_y,p2_y ,intersect, p1_win, p2_win);

input clk,rst,done;
input [9:0] p1_y,p2_y;
input [9:0] hsp, vsp;

reg [9:0] x = 10'd320;
reg [9:0] y = 10'd240;
reg [9:0] speedX = 10'd8;
reg [9:0] speedY = 10'd2;
output reg intersect = 1'b0;
output reg p1_win = 1'b0; //need to generate this as a pulse maybe
output reg p2_win = 1'b0; //need to generate this as a pulse maybe

reg [24:0] counter = 25'd0;
parameter MAX = 25'd2517500;
wire d_rst;

debouncer rs0(clk,rst,d_rst);

always @(posedge clk, posedge d_rst)
begin
	if (d_rst)
	begin
		x<= 320;
		y <= 240;
		speedX <= 10'd8;
		speedY <= 2;
	end
	else if (done == 1'b1)
	begin
		x<= 320;
		y <= 240;
		speedX <= 0;
		speedY <= 0;
	end
	else
	begin
		counter <= counter + 25'd1;
		if (counter >= MAX - 25'd1)
		begin
			counter <= 25'd0;
			x <= x + speedX;
			y <= y + speedY;
			p1_win <= 1'b0;
			p2_win <= 1'b0;
			//This is the main Branch
		end
		else
		begin
			if (x >= 10'd580 && y >= (p2_y - 10'd50) && y <= (p2_y + 10'd50)) // bounces off the paddle
			begin
				speedX <= -10'd8;
			end
			//left paddle
			else if (x <= 10'd70 && y >= (p1_y - 10'd50) && y <= (p1_y + 10'd50)) // bounces off the paddle
			begin
				speedX <= 10'd8;
			end
			else if(y>= 10'd480) // bounces off screen
			begin
				speedY <= -10'd2;
			end
			else if(y<= 10'd10) // bounces off screen
			begin
				speedY <=  10'd2;
			end
			else if(x >= 10'd620)// resets ball in the middle
			begin
				x<= 10'd320;
				y <= 10'd240;
				speedX <= -10'd8;
				speedY <= -10'd2;
				p1_win <= 1'b1;

			end
			else if( x <= 10'd30)// resets ball in the middle
			begin
				x<= 10'd320;
				y <= 10'd240;
				speedX <= 10'd8;
				speedY <= 10'd2;
				p2_win <= 1'b1;
			end
		end
	end
	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd5 && vsp < y + 10'd5);
	
end

endmodule
