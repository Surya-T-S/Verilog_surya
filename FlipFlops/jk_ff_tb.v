//==============================================================================
// Testbench: jk_ff_tb
// Description: Comprehensive testbench for JK flip-flop verification
//
// Tests all operating modes:
//   - Reset functionality
//   - Set operation (j=1, k=0)
//   - Reset operation (j=0, k=1)
//   - Hold operation (j=0, k=0)
//   - Toggle operation (j=1, k=1)
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

`timescale 1ns/1ps

module jk_ff_tb;

    // Test signals
    reg  clk;
    reg  reset;
    reg  j;
    reg  k;
    wire q;
    wire q_bar;

    // Instantiate the JK flip-flop
    jk_ff dut (
        .clk   (clk),
        .reset (reset),
        .j     (j),
        .k     (k),
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
        $display("  JK Flip-Flop Testbench");
        $display("========================================");
        $display("Time\tReset\tJ\tK\tQ\tQ_bar\tOperation");
        $display("--------------------------------------------------------");

        // Initialize
        reset = 1;
        j = 0;
        k = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset", $time, reset, j, k, q, q_bar);

        // Release reset
        reset = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tHold", $time, reset, j, k, q, q_bar);

        // Test Case 1: Set operation (j=1, k=0)
        j = 1; k = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tSet", $time, reset, j, k, q, q_bar);
        if (q !== 1 || q_bar !== 0) 
            $display("ERROR: Set operation failed");

        // Test Case 2: Hold operation (j=0, k=0)
        j = 0; k = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tHold", $time, reset, j, k, q, q_bar);
        if (q !== 1) 
            $display("ERROR: Hold operation failed");

        // Test Case 3: Reset operation (j=0, k=1)
        j = 0; k = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset", $time, reset, j, k, q, q_bar);
        if (q !== 0 || q_bar !== 1) 
            $display("ERROR: Reset operation failed");

        // Test Case 4: Set again
        j = 1; k = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tSet", $time, reset, j, k, q, q_bar);

        // Test Case 5: Toggle operation (j=1, k=1) - should go from 1 to 0
        j = 1; k = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tToggle (1->0)", $time, reset, j, k, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Toggle 1->0 failed");

        // Test Case 6: Toggle again (j=1, k=1) - should go from 0 to 1
        j = 1; k = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tToggle (0->1)", $time, reset, j, k, q, q_bar);
        if (q !== 1) 
            $display("ERROR: Toggle 0->1 failed");

        // Test Case 7: Multiple toggles
        repeat(3) begin
            j = 1; k = 1;
            @(posedge clk);
            #1;
            $display("%0t\t%b\t%b\t%b\t%b\t%b\tToggle", $time, reset, j, k, q, q_bar);
        end

        // Test Case 8: Synchronous reset override
        reset = 1;
        j = 1; k = 0;
        @(posedge clk);
        #1;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\tReset Override", $time, reset, j, k, q, q_bar);
        if (q !== 0) 
            $display("ERROR: Reset override failed");

        #20;
        $display("========================================");
        $display("  Test Complete");
        $display("========================================");
        $finish;
    end

endmodule
