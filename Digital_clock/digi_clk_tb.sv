`timescale 1s/1ms 
program clock_test (clock_if.TB cif);

    // Covergroup with sampling event (MANDATORY in Cadence)
    covergroup clock_cg @(posedge cif.clk);

        coverpoint cif.seconds {
            bins sec_vals[] = {[0:59]};
            bins rollover = (59 => 0);
        }

        coverpoint cif.minutes {
            bins min_vals[] = {[0:59]};
            bins rollover = (59 => 0);
        }

        cross cif.seconds, cif.minutes;

    endgroup

    clock_cg cg = new();

    initial begin
        // Reset
        cif.reset = 1;
        repeat (2) @(posedge cif.clk);
        cif.reset = 0;

        repeat (4000) begin
            @(posedge cif.clk);

            assert (cif.seconds <= 59)
                else $error("Seconds exceeded 59");

            assert (cif.minutes <= 59)
                else $error("Minutes exceeded 59");

            cg.sample();
        end

        $display("TEST PASSED");
        $finish;
    end

endprogram
