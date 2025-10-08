module jk_ff (
    input  wire clk,
    input  wire reset,   // synchronous, active-high
    input  wire j,
    input  wire k,
    output reg  q,
    output wire q_bar
);

    assign q_bar = ~q;

    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b10: q <= 1'b1;   // set
                2'b01: q <= 1'b0;   // reset
                2'b11: q <= ~q;     // toggle
                default: q <= q;    // hold
            endcase
        end
    end

endmodule


