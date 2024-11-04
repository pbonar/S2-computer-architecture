.data
prompt: .asciiz "Podaj liczbe (0-255): "
result: .asciiz "Wynik: "

.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Wczytanie liczby
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Wyświetlenie wyniku
    li $v0, 4
    la $a0, result
    syscall
    

    li $t1, 128  #2^7
    
    loop:
        beqz $t1, exit_loop
        
        # Porównanie i wyświetlenie bitu
        and $t2, $t0, $t1
        beqz $t2, zero_bit
        li $v0, 11
        li $a0, 49  
        syscall
        j next_iteration
        
        zero_bit:
            li $v0, 11
            li $a0, 48
            syscall
        
        next_iteration:
            srl $t1, $t1, 1
            j loop
    
    exit_loop:
    li $v0, 10
    syscall
