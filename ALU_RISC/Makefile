# Makefile for ALU

CC = iverilog
library_input: ALU.v ALU_tb.v
	$(CC) -o ALU.vvp ALU.v ALU_tb.v
	vvp ALU.vvp
# gtkwave dumpfile.vcd config.gtkw