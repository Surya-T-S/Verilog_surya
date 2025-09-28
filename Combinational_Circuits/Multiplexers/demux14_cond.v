module demux14_cond (
	input d,
	input [1:0] s,
	output [3:0] y
);
	assign y = (s == 2'd0) ? 4'b0001 & {4{d}} : 
			   (s == 2'd1) ? 4'b0010 & {4{d}} :
			   (s == 2'd2) ? 4'b0100 & {4{d}} : 4'b1000 & {4{d}};
endmodule
