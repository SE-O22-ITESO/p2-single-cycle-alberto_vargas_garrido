auipc a1, 0xfc10
addi a1, a1, 0x30
lw t4, -4(a1)
andi t4, t4, 0xff 
slli a0, a0, 8
or a0, a0, t4 
addi t2, t2, -1