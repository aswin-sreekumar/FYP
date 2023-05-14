# Makefile for ALU

CC = iverilog
library_input: alu.v alu_tb.v
	$(CC) -o alu.vvp alu.v alu_tb.v
	vvp alu.vvp
	gtkwave alu_tb.vcd config.gtkw