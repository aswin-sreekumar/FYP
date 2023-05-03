# Makefile for RISCV processor

CC = iverilog
SRC = src/Top_module.v
TB = tb/Top_module_tb.v
VVP = output/Top_module.vvp
ASSEMBLER = assembler/assembler.py
ASM_FILE = memory/program.asm
PYTHON_PATH = python

$(info Starting simulation . . . )
library_input: $(SRC) $(TB) $(ASM_FILE)
# $(PYTHON_PATH) $(ASSEMBLER)
	$(CC) -o $(VVP) $(SRC) $(TB)
	vvp $(VVP)
# gtkwave output/dumpfile.vcd output/config.gtkw
# $(info Simulation ended . . . )