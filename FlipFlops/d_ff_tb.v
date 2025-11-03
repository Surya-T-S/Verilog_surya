//==============================================================================
// Testbench: d_ff_tb
// Description: Comprehensive testbench for D flip-flop verification
//
// Tests all operating modes:
//   - Reset functionality
//   - Data capture on clock edges
//   - Hold behavior
//   - Complementary output verification
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

`timescale 1ns/1ps

module d_ff_tb;

    // Test signals
    reg  clk;
    reg  reset;
    reg  d;
    wire q;
    wire q_bar;

    // Instantiate the D flip-flop
    d_ff dut (
        .clk   (clk),
        .reset (reset),
        .d     (d),
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
        $display("  D Flip-Flop Testbench");
        $display("========================================");
        $display("Time\tReset\tD\tQ\tQ_bar");
        $display("----------------------------------------");

        // Monitor output changes
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, reset, d, q, q_bar);

        // Initialize
        reset = 1;
        d = 0;
        #10;

        // Release reset
        reset = 0;
        #10;

        // Test Case 1: Capture 0
        d = 0;
        @(posedge clk);
        #1;
        if (q !== 0 || q_bar !== 1) 
            $display("ERROR: Failed to capture 0");

        // Test Case 2: Capture 1
        d = 1;
        @(posedge clk);
        #1;
        if (q !== 1 || q_bar !== 0) 
            $display("ERROR: Failed to capture 1");

        // Test Case 3: Hold value
        d = 1;
        @(posedge clk);
        #1;
        if (q !== 1) 
            $display("ERROR: Failed to hold value");

        // Test Case 4: Transition 1 to 0
        d = 0;
        @(posedge clk);
        #1;
        if (q !== 0) 
            $display("ERROR: Failed transition 1->0");

        // Test Case 5: Reset while q=0
        reset = 1;
        @(posedge clk);
        #1;
        if (q !== 0) 
            $display("ERROR: Reset failed when q=0");

        reset = 0;
        d = 1;
        @(posedge clk);
        #1;

        // Test Case 6: Reset while q=1
        reset = 1;
        @(posedge clk);
        #1;
        if (q !== 0) 
            $display("ERROR: Reset failed when q=1");

        #20;
        $display("========================================");
        $display("  Test Complete");
        $display("========================================");
        $finish;
    end

endmodule