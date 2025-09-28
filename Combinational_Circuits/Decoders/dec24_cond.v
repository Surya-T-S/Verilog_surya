module dec24_cond (
	input [1:0] in,
	output [3:0] out
);
	assign out = (in == 2'd0) ? 4'b0001 :
				 (in == 2'd1) ? 4'b0010 :
				 (in == 2'd2) ? 4'b0100 : 4'b1000;
endmodule
