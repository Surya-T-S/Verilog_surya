module t_ff (
    input  wire clk,
    input  wire reset,   // synchronous, active-high
    input  wire t,
    output reg  q,
    output wire q_bar
);

    assign q_bar = ~q;

    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            if (t) begin
                q <= ~q;            // toggle
            end else begin
                q <= q;             // hold
            end
        end
    end

endmodule


