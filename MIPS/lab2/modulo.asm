.data
	a: .word 75
	z: .word 4	
.text
main:
	lw $t0, a
	lw $t1, z
	div $t2, $t0, $t1
	mul $t3, $t2, $t1
	sub $t4, $t0, $t3
	li $v0, 1
	add $a0, $zero, $t4
	syscall