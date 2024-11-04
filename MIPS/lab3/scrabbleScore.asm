.data
letterScores:   .word   1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10
word:   .space 20

.text
.globl main

main:
    li $v0, 8
    la $a0, word
    li $a1, 20
    syscall
    
    li $t0, 0
    li $t1, 0
    
loop:
    lb $t2, word($t1)
    
    beqz $t2, exit
    
    sub $t2, $t2, 65
    
    sll $t2, $t2, 2     # Multiply index by 4 to get the offset
    
    lw $t3, letterScores($t2)
    
    add $t0, $t0, $t3
    
    addi $t1, $t1, 1
    
    j loop
    
exit:
    move $a0, $t0 
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall


