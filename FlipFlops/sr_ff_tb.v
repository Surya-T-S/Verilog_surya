//==============================================================================
// Testbench: sr_ff_tb
// Description: Comprehensive testbench for SR flip-flop verification
//
// Tests all operating modes:
//   - Reset functionality
//   - Set operation (s=1, r=0)
//   - Reset operation (s=0, r=1)
//   - Hold operation (s=0, r=0)
//   - Invalid/undefined state handling (s=1, r=1)
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

`timescale 1ns/1ps

module sr_ff_tb;

    // Test signals
    reg  clk;
    reg  reset;
    reg  s;
    reg  r;
    wire q;
    wire q_bar;

    // Instantiate the SR flip-flop
    sr_ff dut (
        .clk   (clk),
        .reset (reset),
        .s     (s),
        .r     (r),
        .q     (q),
        .q_bar (q_bar)
    );

    // Clock generation: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $display("========================================");
        $display("  SR Flip-Flop Testbench");
        $display("========================================");
        $display("Time\tReset\tS\tR\tQ\tQ_bar\tOperation");
        $display("--------------------------------------------------------");

        // Initialize
        reset = 1;
        s = 0;
        r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset", $time, reset, s, r, q, q_bar);

        // Release reset
        reset = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tHold", $time, reset, s, r, q, q_bar);

        // Test Case 1: Set operation (s=1, r=0)
        s = 1; r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tSet", $time, reset, s, r, q, q_bar);
        if (q !== 1 || q_bar !== 0) 
            $display("ERROR: Set operation failed");

        // Test Case 2: Hold operation (s=0, r=0)
        s = 0; r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tHold", $time, reset, s, r, q, q_bar);
        if (q !== 1) 
            $display("ERROR: Hold operation failed");

        // Test Case 3: Reset operation (s=0, r=1)
        s = 0; r = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset", $time, reset, s, r, q, q_bar);
        if (q !== 0 || q_bar !== 1) 
            $display("ERROR: Reset operation failed");

        // Test Case 4: Hold at 0 (s=0, r=0)
        s = 0; r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tHold", $time, reset, s, r, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Hold at 0 failed");

        // Test Case 5: Set again
        s = 1; r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tSet", $time, reset, s, r, q, q_bar);

        // Test Case 6: Invalid state (s=1, r=1) - implementation treats as hold
        s = 1; r = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tInvalid (Hold)", $time, reset, s, r, q, q_bar);

        // Test Case 7: Synchronous reset override
        reset = 1;
        s = 1; r = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset Override", $time, reset, s, r, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Reset override failed");

        #20;
        $display("========================================");
        $display("  Test Complete");
        $display("========================================");
        $finish;
    end

endmodule
