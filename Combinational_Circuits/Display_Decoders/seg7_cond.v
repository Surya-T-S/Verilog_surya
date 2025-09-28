module seg7_cond (
	input [3:0] hex,
	output reg [6:0] seg
);

	always @(*) begin
		seg = (hex == 4'd0) ? 7'b1111110 :
			  (hex == 4'd1) ? 7'b0110000 :
			  (hex == 4'd2) ? 7'b1101101 :
			  (hex == 4'd3) ? 7'b1111001 :
			  (hex == 4'd4) ? 7'b0110011 :
			  (hex == 4'd5) ? 7'b1011011 :
			  (hex == 4'd6) ? 7'b1011111 :
			  (hex == 4'd7) ? 7'b1110000 :
			  (hex == 4'd8) ? 7'b1111111 :
			  (hex == 4'd9) ? 7'b1111011 : 7'b0000000;
	end
endmodule
