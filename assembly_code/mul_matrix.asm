.text
main:
	auipc a0, 0x0fc10
	addi a0, a0, 0x30 #RX address
	addi t2, zero, 20
Wait:
	lw t0, -4(a0)
	andi t0, t0, 0x100
	srli t0, t0, 8
	beq t0, zero, Wait	
Wait2:
	lw t0, -4(a0)
	andi t0, t0, 0x100
	srli t0, t0, 8
	bne t0, zero, Wait2
Retreive:	
	addi t2, t2, -1
	lw t0, -4(a0)
	sw t0, 0(sp)
	addi sp, sp, -4
	bne t2, zero, Wait
