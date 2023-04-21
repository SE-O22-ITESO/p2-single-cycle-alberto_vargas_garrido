auipc a0, 0x0fc10
addi a0, a0, 0x30 #RX address
lw t0, -4(a0)
jal jump
addi t0, t0, 3
add t0, t0, t0
addi t3, zero, 4
jump:
addi t0, t0, 6
add t0, t0, t0
addi t3, zero, 5
