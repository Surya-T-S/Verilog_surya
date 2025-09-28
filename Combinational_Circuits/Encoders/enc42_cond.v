module enc42_cond (
	input [3:0] in,
	output [1:0] code,
	output valid
);

	assign code = (in[3]) ? 2'd3 :
				  (in[2]) ? 2'd2 :
				  (in[1]) ? 2'd1 :
				  (in[0]) ? 2'd0 : 2'd0;
	assign valid = |in;
endmodule
