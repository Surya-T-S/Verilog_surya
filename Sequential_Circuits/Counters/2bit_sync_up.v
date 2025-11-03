module t_ff(
    input wire T,clk,reset,
    output reg Q
);

always @(posedge clk or posedge reset) begin
    if(reset == 1'b1) begin
        Q <= 1'b0;
    end
    else begin
        if(T == 1'b1) begin
            Q <= ~Q;
        end
        else begin
            Q <= Q;
        end
    end
end

endmodule

module sync_up_2bit(
    input wire clk,reset,
    output wire [1:0]Q
);
    wire T_A;
    wire T_B;

    assign T_A = 1'b1;
    assign T_B = ~Q[0];

    t_ff uut(.T(T_A),.clk(clk),.reset(reset),.Q(Q[0]));
    t_ff uuf(.T(T_B),.clk(clk),.reset(reset),.Q(Q[1]));
endmodule