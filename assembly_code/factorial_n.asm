.text
main:
	auipc a0, 0x0fc10
	addi a0, a0, 0x30 #RX address
	addi t2, zero, 1
	add s2, zero, zero
	li t3, 10400
	
	addi s8, zero, 8
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
	srli s2, s2, 8
	lw t0, -4(a0)
	andi t0, t0, 0xff
	or s2, s2, t0
	addi t2, zero, 4
	jal Factorial
Transmision:
	addi t3, t3, -1
	bne t3, zero, Transmision
	
	addi t4, t2, -1
	mul t5, t4, s8
	srl t6 , a2, t5
	andi t6, t6, 0xff
	sw t6, (a0)
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
	li t3, 10400
	
	addi t2, t2, -1
	
	bne t2, zero, Transmision
	jal main
Factorial:
	bne s2, zero, recursion		# Si n es mayor que 1. entonces brinca a recursion.
	addi a2, zero, 1		# En la ultima iteracion se suma 1 al resultado
	jalr zero, ra, 0		# Brincara a la intruccion 18
recursion:
	addi sp, sp, -4 		# Apunantar a la direccion anterior del stack
	sw ra, 0(sp)			# Guardar la direccion de retorno en el stack
	addi sp, sp, -4
	sw s2, 0(sp)
	addi s2, s2, -1			# Disminuir en 1 el contador n
	jal Factorial
	lw s2, 0(sp)
	mul a2, s2, a2			# Multimplicamos el resultado por la base
	lw ra, 4(sp)			# Recuperamos la direccion anterior del stack
	addi sp, sp, 8			# Nos movemos a la posiscion siguinte en memoria del stack
	jalr zero, ra, 0		# Brincara a donde apunte ra
exit:
nop
nop
nop
nop
nop
nop
nop
nop