.data
prompt_a: .asciiz "Podaj liczbe a: "
prompt_b: .asciiz "Podaj liczbe b: "
result_lt: .asciiz "a<b"
result_gt: .asciiz "a>b"
result_eq: .asciiz "a=b"
newline: .asciiz "\n"

.text
.globl main
main:
    # Wczytanie liczby a
    li $v0, 4
    la $a0, prompt_a
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Wczytanie liczby b
    li $v0, 4
    la $a0, prompt_b
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Porównanie a i b
    beq $t0, $t1, equal
    bgt $t0, $t1, greater_than
    
    # Wyświetlenie wyniku a<b
    li $v0, 4
    la $a0, result_lt
    syscall
    j exit
    
equal:
    # Wyświetlenie wyniku a=b
    li $v0, 4
    la $a0, result_eq
    syscall
    j exit
    
greater_than:
    # Wyświetlenie wyniku a>b
    li $v0, 4
    la $a0, result_gt
    syscall
    
exit:
    # Zakończenie programu
    li $v0, 10
    syscall
