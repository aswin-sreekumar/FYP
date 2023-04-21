# Makefile for RISCV processor

CC = iverilog
SRC = src/Top_module.v
TB = tb/Top_module_tb.v
VVP = output/Top_module.vvp

library_input: $(SRC) $(TB)
	$(CC) -o $(VVP) $(SRC) $(TB)
	vvp $(VVP)
	gtkwave output/dumpfile.vcd output/config.gtkw