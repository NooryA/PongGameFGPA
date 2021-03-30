module Ball(clk, hsp, vsp, intersect);

input clk;
input [9:0] hsp, vsp;

reg [9:0] x = 10'd320;
reg [9:0] y = 10'd240;
reg [9:0] speedX = 10'd1;
reg [9:0] speedY = 10'd1;
output reg intersect = 1'b0;

reg [24:0] counter = 25'd0;
parameter MAX = 25'd100000;

always @(posedge clk)
begin
	counter <= counter + 25'd1;
	if (counter >= MAX - 25'd1)
	begin
		counter <= 25'd0;
		x <= x + speedX;
		y <= y + speedY;

		if(y>= 480)
		begin
		speedY <= -1;
		end

		if(y<=10)
		begin
		speedY <=  10'd1;
		end

		if(x>= 580)
		begin
		speedX <= -1;
		end

		if(x<=70)
		begin
		speedX <= 10'd1;
		end

		//This is the ball bouncing 




	end



	intersect <= (hsp >= x - 10'd5 && hsp < x + 10'd5) && (vsp >= y - 10'd5 && vsp < y + 10'd5);

end

endmodule
