# RISC-V assembler
# Python code for converting RISC-V ASM into Machine code

import pytest
from riscv_assembler.convert import AssemblyConverter as AC

asm_file = 'instr/simple.asm'
bin_file = 'instr/new.bin'
txt_file = 'instr/new.txt'

cnv = AC(output_mode = 'f', nibble_mode = False, hex_mode = False)
cnv(asm_file,bin_file) 
cnv(asm_file,txt_file) 
# result = cnv(asm_file)
# print(result)