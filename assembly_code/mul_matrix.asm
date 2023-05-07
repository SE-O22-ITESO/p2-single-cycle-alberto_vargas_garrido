.text
main:
	auipc a0, 0x0fc10
	addi a0, a0, 0x30 #RX address
	addi t2, zero, 20
	addi s0, zero, 4
	addi s1, zero, 4
	li s2, 5208
	
	li a1, 0x7fffeffc
	
	addi a2, a1, -64
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
Calculate:
	lw t3, 0(a1)
	lw t4, 0(a2)
	mul t5, t4, t3
	add t6, t6, t5 
	addi a1, a1, -4
	addi a2, a2, -4
	addi s0, s0, -1	
	bne zero, s0, Calculate
	sw t6, 0(a0)
	addi t6, zero, 0
	addi s0, zero, 4
	addi s1, s1, -1
	addi a2, a2, 16
Wait3:
	lw t0, -4(a0)
	andi t0, t0, 0x400
	srli t0, t0, 10
	beq t0, zero, Wait3	
Wait4:
	lw t0, -4(a0)
	andi t0, t0, 0x400
	srli t0, t0, 10
	bne t0, zero, Wait4
Wait5:
	addi s2, s2, -1
	bne s2, zero, Wait5
	li s2, 5208
		
	bne zero, s1, Calculate
	add a1, zero, zero
	add a2, zero, zero
	li sp, 0x7fffeffc
	
	jal main
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop