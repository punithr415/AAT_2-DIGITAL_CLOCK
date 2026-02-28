 `timescale 1ns/1ps

program clock_test (clock_if.TB vif);

    // -------------------------------
    // Functional Coverage
    // -------------------------------
    covergroup cg @(posedge vif.clk);

        cp_seconds : coverpoint vif.seconds {
            bins sec_vals[]     = {[0:59]};
            bins sec_rollover   = (59 => 0);
        }

        cp_minutes : coverpoint vif.minutes {
            bins min_vals[]     = {[0:59]};
            bins min_rollover   = (59 => 0);
        }

        cross cp_seconds, cp_minutes;

    endgroup

    cg coverage_inst;

    // -------------------------------
    // Assertions
    // -------------------------------
    property sec_limit;
        @(posedge vif.clk) vif.seconds <= 6'd59;
    endproperty

    property min_limit;
        @(posedge vif.clk) vif.minutes <= 6'd59;
    endproperty

    assert property (sec_limit)
        else $error("Seconds exceeded 59!");

    assert property (min_limit)
        else $error("Minutes exceeded 59!");

    // -------------------------------
    // Test Sequence
    // -------------------------------
    initial begin
        // IMPORTANT: initialize signals
        vif.reset = 1'b1;

        // Create coverage object AFTER reset init
        coverage_inst = new();

        // Hold reset for few clocks
        repeat (3) @(posedge vif.clk);

        // Release reset synchronously
        vif.reset = 1'b0;

        // Run long enough for full coverage
        repeat (3700) @(posedge vif.clk);

        // Optional second reset (shows reset behavior)
        vif.reset = 1'b1;
        repeat (2) @(posedge vif.clk);
        vif.reset = 1'b0;

        repeat (200) @(posedge vif.clk);

        $display("Simulation Completed Successfully.");
        $finish;
    end

endprogram
