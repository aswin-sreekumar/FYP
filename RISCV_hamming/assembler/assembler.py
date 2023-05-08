# RISC-V assembler
# Python code for converting RISC-V ASM into Machine code

from riscv_assembler.convert import *

asm_file = 'memory/program.asm'
hex_file = 'memory/instructions.hex'

cnv = AssemblyConverter(output_mode = 'a', nibble_mode = False, hex_mode = True)
addr_count = 0
f_asm = open(asm_file,'r')
f_hex = open(hex_file,'w')
for line in f_asm:
    f_hex.write("@"+str(hex(addr_count))[2:]+"\n")
    # print(str(hex(addr_count))[2:])
    result = cnv(line)
    f_hex.write(result[0]+"\n")
    addr_count += 4

f_asm.close()
f_hex.close()