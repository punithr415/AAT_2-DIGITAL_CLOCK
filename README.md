# AAT_2-DIGITAL_CLOCK
Designed a digital clock using System Verilog 
6-bit seconds and minutes synchronous digital clock implemented in SystemVerilog with functional coverage and assertions.

# Tools Used
Cadence Xcelium

# How to Run
cd ~/CadWorkDir/Digital
csh
source .cshrc
cd 1BM24EC415/verify/lab3
ncvlog +access+r +sv +nccoverage+all -covoverwrite digi_clk.sv digi_clk_if.sv digi_clktb.sv digi_clktpmd.sv
ncsim digi_clktb
imc -gui

# Coverage Achieved
99.8 ~ 100%
