def encode(hex_str):
    p = 6
    msg = format(int(hex_str, 16), '032b')
    m = msg[-1::-1]
    mptr = 0
    pptr = 1
    a = []
    for i in range(1, len(m) + p + 1):
        if i == pow(2, pptr - 1):
            a.append(str(0))
            pptr += 1
        else:
            a.append(str(m[mptr]))
            mptr += 1

    for i in range(1, p + 1):
        b = 0
        for j in range(1, len(m) + p + 1):
            if pow(2, i - 1) & j:
                b = b ^ int(a[j - 1])
        a[pow(2, i - 1) - 1] = str(b)
    res = ""
    for i in reversed(a):
        res = res + i
    h = hex(int(res, 2))[2:].zfill(len(res) // 4).upper()
    return h

hex_file="memory/data.hex"
enc_hex_file="memory/enc_data.hex"
addr_count = 0
f_hex = open(hex_file,'r')
f_enc = open(enc_hex_file,'w')
for line in f_hex:
    result=encode(line)
    f_enc.write(result+"\n")

f_enc.close()
f_hex.close()