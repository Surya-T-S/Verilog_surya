//==============================================================================
// Testbench: t_ff_tb
// Description: Comprehensive testbench for T flip-flop verification
//
// Tests all operating modes:
//   - Reset functionality
//   - Toggle operation (t=1)
//   - Hold operation (t=0)
//   - Frequency division behavior
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

`timescale 1ns/1ps

module t_ff_tb;

    // Test signals
    reg  clk;
    reg  reset;
    reg  t;
    wire q;
    wire q_bar;

    // Instantiate the T flip-flop
    t_ff dut (
        .clk   (clk),
        .reset (reset),
        .t     (t),
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
        $display("  T Flip-Flop Testbench");
        $display("========================================");
        $display("Time\tReset\tT\tQ\tQ_bar\tOperation");
        $display("--------------------------------------------------------");

        // Initialize
        reset = 1;
        t = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tReset", $time, reset, t, q, q_bar);

        // Release reset
        reset = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tHold", $time, reset, t, q, q_bar);

        // Test Case 1: Hold at 0 (t=0)
        t = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tHold", $time, reset, t, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Hold at 0 failed");

        // Test Case 2: Toggle (t=1) - should go from 0 to 1
        t = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tToggle (0->1)", $time, reset, t, q, q_bar);
        if (q !== 1 || q_bar !== 0) 
            $display("ERROR: Toggle 0->1 failed");

        // Test Case 3: Hold at 1 (t=0)
        t = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tHold", $time, reset, t, q, q_bar);
        if (q !== 1) 
            $display("ERROR: Hold at 1 failed");

        // Test Case 4: Toggle (t=1) - should go from 1 to 0
        t = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tToggle (1->0)", $time, reset, t, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Toggle 1->0 failed");

        // Test Case 5: Continuous toggle - frequency divider behavior
        $display("\n--- Frequency Divider Test (8 clock cycles) ---");
        t = 1;
        repeat(8) begin
            @(posedge clk);
            #1;
            $display("%0t\t%b\t%b\t%b\t%b\tContinuous Toggle", $time, reset, t, q, q_bar);
        end

        // Test Case 6: Synchronous reset during toggle
        reset = 1;
        t = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\tReset Override", $time, reset, t, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Reset override failed");

        // Test Case 7: Resume operation after reset
        reset = 0;
        t = 1;
        repeat(4) begin
            @(posedge clk);
            #1;
            $display("%0t\t%b\t%b\t%b\t%b\tToggle", $time, reset, t, q, q_bar);
        end

        #20;
        $display("========================================");
        $display("  Test Complete");
        $display("========================================");
        $finish;
    end

endmodule
