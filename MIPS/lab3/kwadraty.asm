.data
prompt: .asciiz "Podaj N:"
result1: .asciiz " Wynik sumy kwadratow: "
result2: .asciiz " Wynik kwadratu sumy: "
result3: .asciiz " Wynik roznicy: "
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
    
    j result10
    
    result10:
    	mul $t2, $t0, $t0
    	add $t1, $t1, $t2
    	sub $t0, $t0, 1
    	bgtz $t0, result10
    	blez $t0, end1
    	
    end1:
    	li $v0, 4
  	la $a0, result1
    	syscall
    	add $t0, $t1, 0
    	li $v0, 1
  	move $a0, $t1
    	syscall
    	
    	j result20
    	
    result20:
    	add $t4, $t3, $t4
    	sub $t3, $t3, 1
    	bgtz $t3, result20
    	blez $t3, resultfinal
    	
    resultfinal:
    	li $v0, 4
  	la $a0, result2
    	syscall
    	li $v0, 1
    	mul $t4, $t4, $t4
    	add $t1, $t4, 0
  	move $a0, $t4
    	syscall
    	sub $t5, $t1, $t0
    	li $v0, 4
  	la $a0, result3
    	syscall
    	li $v0, 1
    	move $a0, $t5
    	syscall
    		
    	# zakonczenie
    	li $v0, 10
   	syscall
