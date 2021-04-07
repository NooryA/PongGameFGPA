module Score(clk,rst, p1_win, p2_win, p1_score, p2_score, done);
input clk,rst;
input p1_win, p2_win;
output logic [3:0] p1_score, p2_score;
output logic done = 1'b0;
logic [3:0] p1_score_reg, p2_score_reg;
typedef enum logic [2:0] {A,B,C,D,E,F,G,H} state; 
state pr_state = A;
state nx_state;
always_ff @(posedge clk, posedge rst)
begin
	if (rst) pr_state <= A;
	else pr_state <= nx_state;
end
always_ff @(posedge clk, posedge rst)
begin
	if (rst) begin
		p1_score_reg <= 4'd0;
		p1_score_reg <= 4'd0;
	end
	else begin
		p1_score_reg <= p1_score;
		p2_score_reg <= p2_score;
	end
end
always_comb
case (pr_state)
	A : begin
		p1_score <= p1_score_reg;
		p2_score <= p2_score_reg;
		done <= 1'b0;
		if (p1_win)
			nx_state <= B;
		else if (p2_win)
			nx_state <= C;
		else
			nx_state <= A;
	end
	B : begin
		p1_score <= p1_score_reg + 4'd1;
		p2_score <= p2_score_reg;
		done <= 1'b0;
		nx_state <= D;
	end
	C : begin
		p1_score <= p1_score_reg;
		p2_score <= p2_score_reg + 4'd1;
		done <= 1'b0;
		nx_state <= D;
	end
	D : begin
		p1_score <= p1_score_reg;
		p2_score <= p2_score_reg;
		done <= 1'b0;
		if (p1_win == 1'b0 && p2_win == 1'b0)
			nx_state <= E;
		else if (p1_score == 4'd4 || p2_score == 4'd4)
			nx_state <= F;
		else
			nx_state <= D;
	end
	E : begin
		p1_score <= p1_score_reg;
		p2_score <= p2_score_reg;
		done <= 1'b0;
		if (p1_win)
			nx_state <= B;
		else if (p2_win)
			nx_state <= C;
		else
			nx_state <= E;
	end
	F : begin
		done <= 1'b1;
		p1_score <= p1_score_reg;
		p2_score <= p2_score_reg;
		nx_state <= F;
	end

endcase


endmodule
