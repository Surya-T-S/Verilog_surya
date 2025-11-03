`timescale 1ns/1ps

module tb_sync_tff_counter;
    reg clk;
    reg reset;
    wire [2:0]Q;

    sync_tff_up_3bit uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );
    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #15;

        reset = 1'b0;
        #100;

        reset = 1'b1;
        #20;

        reset = 1'b0;
        #20;
        $finish;

    end
    // ----------------------------------------------------
    // 4. Monitoring
    // ----------------------------------------------------
    initial begin
        $display("-----------------------------------------------------------------");
        $display("Time (ns) | Reset | Counter Output (Q[2] Q[1] Q[0]) | Decimal");
        $display("-----------------------------------------------------------------");
        $monitor("%8t | %5b | %3b                     | %0d", $time, reset, Q, Q);
    end

endmodule