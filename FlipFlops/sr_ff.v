module sr_ff (
    input  wire clk,
    input  wire reset,   // synchronous, active-high
    input  wire s,
    input  wire r,
    output reg  q,
    output wire q_bar
);

    assign q_bar = ~q;

    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            if (s && !r) begin
                q <= 1'b1;           // set
            end else if (r && !s) begin
                q <= 1'b0;           // reset
            end else begin
                q <= q;              // hold (including s==r==1)
            end
        end
    end

endmodule


