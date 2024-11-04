.data
a: .word 5
b: .word 6
c: .word 4
d: .word 3
.text
main:
lw $t0, a
lw $t1, b
lw $t2, c
lw $t3, d
sub $t4, $t1, $t2
add $t5, $t4, $t1
add $t6, $t5, $t3
li $v0, 1
add $a0, $zero, $t6
syscall