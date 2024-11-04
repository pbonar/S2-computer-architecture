.data
prompt: .asciiz "Podaj znak: "
digit_msg: .asciiz "To jest cyfra!"
letter_msg: .asciiz "To jest litera!"
special_msg: .asciiz "To jest znak specjalny!"
newline: .asciiz "\n"

.text
.globl main
main:
    # Wyświetlenie wiadomości zachęcającej do podania znaku
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Wczytanie znaku
    li $v0, 12
    syscall
    move $t0, $v0
    
    #Linijka przerwy zeby ladnie wygladalo
    la $a0, newline
    li $v0, 4
    syscall
	j digit_check_first
    
    digit_check_first:
        li $t1, 48  # wartość '0' w kodzie ASCII
  	li $t2, 57  # wartość '9' w kodzie ASCII
    	ble $t0, $t2, digit_check_second
    	j letter_big_check_first
    digit_check_second:
    	bge $t0, $t1, digit_final
    	j letter_big_check_first
    digit_final: 
        # Wyświetlenie informacji, że to jest cyfra
        li $v0, 4
        la $a0, digit_msg
        syscall
        j exit
        
    letter_big_check_first:
    	li $t1, 65  # 'A' w kodzie ASCII
    	li $t2, 90  # 'Z' w kodzie ASCII
    	ble $t0, $t2, letter_big_check_second
    	j letter_small_check_first
    letter_big_check_second:
    	bge $t0, $t1, letter_final
    	j letter_small_check_first
    letter_small_check_first: 
        li $t1, 97  # 'a' w kodzie ASCII
    	li $t2, 122  # 'z' w kodzie ASCII
    	ble $t0, $t2, letter_small_check_second
    	j special_sign
    letter_small_check_second:
    	bge $t0, $t1, letter_final
    	j special_sign
    letter_final:
        # Wyświetlenie informacji, że to jest litera
        li $v0, 4
        la $a0, letter_msg
        syscall
        j exit
        
    
    special_sign:
    	li $v0, 4
    	la $a0, special_msg
    	syscall
    	j exit
        
    exit:
    	# Zakończenie programu
    	li $v0, 10
    	syscall
