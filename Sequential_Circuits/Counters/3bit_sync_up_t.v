module t_ff(
    input wire T,clk,reset, 
    output reg Q
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        Q <= 1'b0;
    end
    else begin
        // synchronous toggle operation
        if(T == 1'b1) begin
            Q <= ~Q;
        end
        else begin
            Q <= Q;
        end
    end
end
endmodule

module sync_tff_up_3bit(
    input wire clk,reset,
    output wire [2:0]Q
);

    wire T_A;
    wire T_B;
    wire T_C;
    // wire Q_B_AND_Q_A;

    assign T_A = 1'b1;
    assign T_B = Q[0];
    // assign Q_B_AND_Q_A = 
    assign T_C = Q[1] & Q[0];

    t_ff uut (.T(T_A),.clk(clk),.reset(reset),.Q(Q[0]));
    t_ff dut (.T(T_B),.clk(clk),.reset(reset),.Q(Q[1]));
    t_ff kut (.T(T_C),.clk(clk),.reset(reset),.Q(Q[2]));

endmodule