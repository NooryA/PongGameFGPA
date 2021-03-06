module ssd_display(in, e, dot);
	input [3:0] in;
	input dot;
	output [7:0] e;
	assign e[0] = (~in[3] & ~in[2] & ~in[1] & in[0]) | (~in[3] & in[2] & ~in[1] & ~in[0]) | (in[3] & ~in[2] & in[1] & in[0]) |(in[3] & in[2] & ~in[1] & in[0]);
	assign e[1] = (in[3] & in[1] & in[0]) |(in[3] & in[2] & in[1] ) |(in[3] & in[2] & ~in[0]) |(in[2] & in[1] & ~in[0]) |(~in[3] & in[2] & ~in[1] & in[0]);
	assign e[2] = (in[3] & in[2] & in[1] ) |(in[3] & in[2] & ~in[0]) |(~in[3] & ~in[2] & in[1] & ~in[0]);
	assign e[3] = (~in[3] & ~in[2] & ~in[1] & in[0]) |(~in[3] & in[2] & ~in[1] & ~in[0]) |(~in[3] & in[2] & in[1] & in[0]) |(in[3] & ~in[2] & in[1] & ~in[0]) |(in[3] & in[2] & in[1] & in[0]);
	assign e[4] = (~in[3] & ~in[2] & ~in[1] & in[0]) |(~in[3] & ~in[2] & in[1] & in[0]) |(~in[3] & in[2] & ~in[1] & ~in[0]) |(~in[3] & in[2] & ~in[1] & in[0]) |(~in[3] & in[2] & in[1] & in[0]) |(in[3] & ~in[2] & ~in[1] & in[0]);	
	assign e[5] = (~in[3] & ~in[2] & ~in[1] & in[0]) |(~in[3] & ~in[2] & in[1] & ~in[0]) |(~in[3] & ~in[2] & in[1] & in[0]) |(~in[3] & in[2] & in[1]& in[0]) |(in[3] & in[2] & ~in[1] & in[0]) ;
	assign e[6] = (~in[3] & ~in[2] & ~in[1] & ~in[0]) |(~in[3] & ~in[2] & ~in[1] & in[0]) |(~in[3] & in[2] & in[1] & in[0]) |(in[3] & in[2] & ~in[1] & ~in[0]) ;
	assign e[7] = ~dot;
endmodule
