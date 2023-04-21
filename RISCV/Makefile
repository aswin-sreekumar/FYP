# Makefile for RISCV processor

CC = iverilog
library_input: Top_module.v Top_module_tb.v
	$(CC) -o Top_module.vvp Top_module.v Top_module_tb.v
	vvp Top_module.vvp
#gtkwave dumpfile.vcd config.gtkw