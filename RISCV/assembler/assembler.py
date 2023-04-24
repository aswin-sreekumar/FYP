# RISC-V assembler
# Python code for converting RISC-V ASM into Machine code

from riscv_assembler.convert import *

asm_file = 'memory/simple.asm'
bin_file = 'memory/new.bin'
txt_file = 'memory/new.txt'

cnv = AssemblyConverter(output_mode = 'f', nibble_mode = False, hex_mode = True)
# cnv(asm_file,bin_file) 
cnv(asm_file,txt_file)
# cnv = AssemblyConverter(output_mode = 'f', nibble_mode = False, hex_mode = False)
# cnv(asm_file,'memory/new1.txt')
# cnv_string = "sw x1, 0(x0)"
# result = cnv.convert(cnv_string) 
# result = cnv.convert(asm_file)
# print(result)