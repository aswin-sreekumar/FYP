# Makefile for RISC 16bit_core

CC = iverilog
library_input: ./src/Risc_16_bit.v ./tb/main_tb.v
	$(CC) -o ./output/Risc_16_bit.vvp ./src/Risc_16_bit.v ./tb/main_tb.v
	vvp ./output/Risc_16_bit.vvp
	gtkwave alu_tb.vcd config.gtkw