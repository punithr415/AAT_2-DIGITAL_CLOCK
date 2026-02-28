`timescale 1s/1ms 
program clock_test (clock_if.TB cif);

    initial begin
        // INITIALIZE SIGNALS 
        cif.reset = 1'b1;

        // Hold reset for few clocks
        repeat (3) @(posedge cif.clk);

        // Release reset synchronously
        cif.reset = 1'b0;

        // Let clock run
        repeat (2000) @(posedge cif.clk);

        $display("Simulation completed successfully");
        $finish;
    end

    // Assertions 
    always @(posedge cif.clk) begin
        assert (cif.seconds <= 59);
        assert (cif.minutes <= 59);
    end

endprogram
