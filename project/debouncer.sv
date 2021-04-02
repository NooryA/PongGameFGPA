module debouncer(clk,val, d_val);
input clk, val;
output logic d_val;
//output logic [7:0] ssd0;
typedef enum logic [2:0] {A,B,C,D,E,F,G,H} state; 
state pr_state = A;
state nx_state;

logic [31:0] t = 32'd0;
parameter T_deb = 32'd1000000;
logic [3:0] c2 = 4'd0;


always_ff @(posedge clk)
begin
	if (pr_state != nx_state) t <= 0;
	else if (t != T_deb) t <= t + 32'd1;
end

always_ff @(posedge clk)
begin
	pr_state <= nx_state;
end

always_comb
case (pr_state)
	A : begin
		d_val <= 1'b0;
		if (val == 1'b0)
			nx_state <= B;
		else
			nx_state <= A;
	end
	B : begin
		d_val <= 1'b0;

		if (val == 1'b1)
			nx_state <= A;
		else if (val == 1'b0 && t >= T_deb - 32'd2)
			nx_state <= C;
		else
			nx_state <= B;
	end
	C : begin
		d_val <= 1'b1;
		nx_state <= D;
	end
	D : begin
		d_val <= 1'b0;
		if (val == 1'b1 && t >= T_deb / 5)
			nx_state <= A;
		else
			nx_state <= D;
	end

endcase
//onebSSD ob1(d_val,ssd0);



endmodule