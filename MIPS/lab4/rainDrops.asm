.data
prompt: .asciiz "Podaj N:"
result1: .asciiz "Pling3 "
result2: .asciiz "Plang5 "
result3: .asciiz "Plong7 "

.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Wczytanie liczby
    li $v0, 5
    li $t1, 0
    syscall
    move $t0, $v0
    add $t3, $t0, 0
    j cont1
    
    cont1:
    	add $t1, $zero, 3
   	div $t2, $t0, $t1
        mul $t3, $t2, $t1
        sub $t4, $t0, $t3
        beqz $t4, wyswietl1
        j cont2

    wyswietl1:
    	li $v0, 4
  	la $a0, result1
    	syscall
    	j cont2
    	
    cont2:
    	add $t1, $zero, 5
   	div $t2, $t0, $t1
        mul $t3, $t2, $t1
        sub $t4, $t0, $t3
        beqz $t4, wyswietl2
        j cont3

    wyswietl2:
    	li $v0, 4
  	la $a0, result2
    	syscall
    	j cont3
    	
    cont3:
    	add $t1, $zero, 7
   	div $t2, $t0, $t1
        mul $t3, $t2, $t1
        sub $t4, $t0, $t3
        beqz $t4, wyswietl3
        j zakoncz

    wyswietl3:
    	li $v0, 4
  	la $a0, result3
    	syscall
    	j zakoncz
    zakoncz:
    	# zakonczenie
    	li $v0, 10
   	syscall
   	