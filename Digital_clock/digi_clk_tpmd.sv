`timescale 1s/1ms

module clock_tb;

    logic clk;

    // Clock generation (1 Hz)
    initial clk = 0;
    always #0.5 clk = ~clk;

    // Interface
    clock_if cif (clk);

    // DUT
    digital_clock dut (
        .clk     (clk),
        .reset   (cif.reset),
        .seconds (cif.seconds),
        .minutes (cif.minutes)
    );

    // Program block
    clock_test test (cif);

    // Dump waves
    initial begin
        $dumpfile("digi_clk_vcd.vcd");
        $dumpvars(0, clock_tb);
    end

endmodule
