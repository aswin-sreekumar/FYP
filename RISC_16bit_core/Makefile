# Makefile for RISC 16bit_core

CC = iverilog
library_input: ./src/Risc_16_bit.v
	$(CC) -s Risc_16_bit -o ./output/Risc_16_bit.vvp ./src/Risc_16_bit.v
	vvp ./output/Risc_16_bit.vvp
# gtkwave alu_tb.vcd config.gtkw