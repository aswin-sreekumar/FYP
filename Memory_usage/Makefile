# Makefile for ALU

CC = iverilog
library_input: Memory.v Memory_tb.v
	$(CC) -o Memory.vvp Memory.v Memory_tb.v
	vvp Memory.vvp
	gtkwave dumpfile.vcd config.gtkw