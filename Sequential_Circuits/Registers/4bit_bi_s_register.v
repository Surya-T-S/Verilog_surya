module shift_reg(
    input wire clk,reset,mode,sin_r,sin_l,
    output reg [3:0] Q
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            Q <= 4'b0000;
        end
        else begin
            Q <= mode ? {sin_r,Q[3:1]} : {Q[2:0],sin_l};
        end
    end
endmodule