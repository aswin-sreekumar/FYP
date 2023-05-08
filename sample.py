# def encode(hex_str):
#     p = 6
#     msg = format(int(hex_str, 16), '032b')
#     m = msg[-1::-1]
#     mptr = 0
#     pptr = 1
#     a = []
#     for i in range(1, len(m) + p + 1):
#         if i == pow(2, pptr - 1):
#             a.append(str(0))
#             pptr += 1
#         else:
#             a.append(str(m[mptr]))
#             mptr += 1

#     for i in range(1, p + 1):
#         b = 0
#         for j in range(1, len(m) + p + 1):
#             if pow(2, i - 1) & j:
#                 b = b ^ int(a[j - 1])
#         a[pow(2, i - 1) - 1] = str(b)
#     res = ""
#     for i in reversed(a):
#         res = res + i
#     # print(res, type(res))
#     h = hex(int(res, 2))[2:].zfill(len(res) // 4).upper()
#     print(h)
#     print("hi")

# # res="00000000000000000000000000001100000011"
# # a=hex(int(res, 2))[2:].zfill(len(res)//4).upper()
# # print(a,type(res))

a=[1, 2, 3, 4 ,5 ,6]
print(a[:2])