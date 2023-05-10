# RISC-V assembler
# Python code for converting RISC-V ASM into Machine code
# Encodes parsed machine codes using SEC-DED algorithm for instruction memory

# SEC-DED encoding
def encode(hex_str):
    p = 6
    msg = format(int(hex_str, 16), '032b')
    m = msg[-1::-1]
    mptr = 0
    pptr = 1
    a = []
    extra_parity=0
    for i in range(1, len(m) + p+1):
        if i == pow(2, pptr - 1):
            a.append(str(0))
            pptr += 1
        else:
            extra_parity=extra_parity^int(m[mptr])
            a.append(m[mptr])
            mptr += 1
    for i in range(1, p + 1):
        b = 0
        for j in range(1, len(m) + p+1):
            if pow(2, i - 1) & j:
                b = b ^ int(a[j - 1])
        extra_parity=extra_parity^b
        a[pow(2, i - 1) - 1] = str(b)
    a.append(str(extra_parity))
    res = ""
    for i in reversed(a):
        res = res + i
    h = hex(int(res, 2))[2:].zfill((len(res)+1) // 4).upper()
    return h

from riscv_assembler.convert import *

# File paths
asm_file = 'memory/program.asm'
hex_file = 'memory/instructions.hex'

cnv = AssemblyConverter(output_mode = 'a', nibble_mode = False, hex_mode = True)
addr_count = 0
f_asm = open(asm_file,'r')
f_hex = open(hex_file,'w')
for line in f_asm:
    f_hex.write("@"+str(hex(addr_count))[2:]+"\n")
    temp = cnv(line)
    result=temp[0][:2]+encode(temp[0][2:])
    f_hex.write(result+"\n")
    addr_count += 4

f_asm.close()
f_hex.close()
