module enc42_logic (
	input [3:0] in,
	output [1:0] code,
	output valid
);

	assign code[1] = in[3] | in[2];
	assign code[0] = in[3] | (in[1] & ~in[2]);
	assign valid = |in;
endmodule
