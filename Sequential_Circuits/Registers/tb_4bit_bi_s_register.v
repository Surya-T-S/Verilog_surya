`timescale 1ns/1ps
module tb_shift;
    reg clk;
    reg reset;
    reg mode;
    reg sin_r;
    reg sin_l;
    wire [3:0]Q;

    // instantiate the DUT
    shift_reg dut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .sin_r(sin_r),
        .sin_l(sin_l),
        .Q(Q)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Monitoring the Signals
    initial begin
        $display("Time\t|\tReset\tMode\tSin_L\tSin_R\t|\tQ");
        $monitor("%0t\t|\t%b\t%b\t%b\t%b\t|\t%b", $time, reset, mode, sin_l, sin_r, Q);
    end

    initial begin
        // initial setup
        reset = 1'b0;
        mode = 1'b0;
        sin_r = 1'b0;
        sin_l = 1'b0;
        #5;
        #5;     // current time t = 10

        // apply the reset and release
        reset = 1'b1;
        #5;
        reset = 1'b0;
        #10;
        #10;    // t = 35

        // Test the RIGHT SHIFT MODE 1
        $display("\n--- Mode 1: RIGHT SHIFT (Loading 1010) ---");
        mode = 1'b1;
        sin_l = 1'b0; // irrevalnt for the right shift

        sin_r = 1'b0; #10;
        sin_r = 1'b1; #10;
        sin_r = 1'b0; #10;
        sin_r = 1'b1; #10;
        sin_r = 1'b0; #10;     // shift out

        
        // 4. Test LEFT SHIFT (mode=0) - Shift 1010 out
        $display("\n--- Mode 0: LEFT SHIFT (Shifting out) ---");
        mode = 1'b0;
        sin_r = 1'b0; // irrevalant for the left shift

        // now we have 0101 we have to make 1010
        sin_l = 1'b0; #10;
        sin_l = 1'b1; #10;
        sin_l = 1'b0; #10;
        sin_l = 1'b1; #10;
        sin_l = 1'b0; #10;
        $finish;

    end

endmodule