.data: 
	# for showing off the map
	prompt_1: .asciiz "1    |2    |3    \n"
	prompt_2: .asciiz "4    |5    |6    \n"
	prompt_3: .asciiz "7    |8    |9    \n"	
 	prompt_begin_of_line: .asciiz "  "
	prompt_between: .asciiz "  |  "
	prompt_vertical_line: .asciiz "_____|_____|_____\n"
	prompt_last: .asciiz "     |     |     \n\n"
	
	# for showing off symbols on map
	prompt_X: .asciiz "X"  
	prompt_O: .asciiz "0" 
	prompt_space: .asciiz " "
	prompt_newline: .asciiz "\n"
	
	# interactions with player
	prompt_startgame: .asciiz "Welcome players, we are going go start. \n"
	prompt_X_move: .asciiz "Your move X. Which space are you choosing??? " 
	prompt_O_move: .asciiz "Your move O. Which space are you choosing??? " 
	prompt_wrongmove: .asciiz "Wrong move, pick again\n"
	
	# ending communicates
	prompt_X_wins: .asciiz "PLAYER X WINS"
	prompt_O_wins: .asciiz "PLAYER O WINS"
	prompt_draw: .asciiz "IT'S A DRAW"
	
	# board
	board:  .word 32, 32, 32, 32, 32, 32, 32, 32, 32
	# board:  .word '1', '2', '3', '4', '5', '6', '7', '8', '9' 
	
	# $t9, $t8- temporary for cout
	# $t7-      constantly used for showing who did move   1- X, 0- O
	# $t1, $t2- temporary for move
	# $t0- board
	
	
.text
.globl main

main:
	li $v0, 4
	la $a0, prompt_startgame
	syscall
	la $t0, board
	# empty board print
	jal cout_board
	
	# move 1
	addi $t7, $zero, 1
	jal X_move
	jal cout_board
	jal check
	# move 2
	addi $t7, $zero, 0
	jal O_move
	jal cout_board
	jal check
	# move 3
	addi $t7, $zero, 1
	jal X_move
	jal cout_board
	jal check
	# move 4
	addi $t7, $zero, 0
	jal O_move
	jal cout_board
	jal check
	# move 5
	addi $t7, $zero, 1
	jal X_move
	jal cout_board
	jal check
	# move 6
	addi $t7, $zero, 0
	jal O_move
	jal cout_board
	jal check
	# move 7
	addi $t7, $zero, 1
	jal X_move
	jal cout_board
	jal check
	# move 8
	addi $t7, $zero, 0
	jal O_move
	jal cout_board
	jal check
	# move 9
	addi $t7, $zero, 1
	jal X_move
	jal cout_board
	jal check
	
	j cout_tie
	
# CHECKING IF GAME IS FINISHED
check:
	la $t0, board
	
	# horizontal check
	lw $t2, 0($t0)
	add $t1, $zero, $t2
	lw $t2, 4($t0)
	add $t1, $t1, $t2
	lw $t2, 8($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	lw $t2, 12($t0)
	add $t1, $zero, $t2
	lw $t2, 16($t0)
	add $t1, $t1, $t2
	lw $t2, 20($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
		
	lw $t2, 24($t0)
	add $t1, $zero, $t2
	lw $t2, 28($t0)
	add $t1, $t1, $t2
	lw $t2, 32($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	# vertical check
	lw $t2, 0($t0)
	add $t1, $zero, $t2
	lw $t2, 12($t0)
	add $t1, $t1, $t2
	lw $t2, 24($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	lw $t2, 4($t0)
	add $t1, $zero, $t2
	lw $t2, 16($t0)
	add $t1, $t1, $t2
	lw $t2, 28($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	lw $t2, 8($t0)
	add $t1, $zero, $t2
	lw $t2, 20($t0)
	add $t1, $t1, $t2
	lw $t2, 32($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	# diagonal check
	lw $t2, 0($t0)
	add $t1, $zero, $t2
	lw $t2, 16($t0)
	add $t1, $t1, $t2
	lw $t2, 32($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	lw $t2, 8($t0)
	add $t1, $zero, $t2
	lw $t2, 16($t0)
	add $t1, $t1, $t2
	lw $t2, 24($t0)
	add $t1, $t1, $t2
	beq $t1, 264, cout_X_wins
	beq $t1, 237, cout_O_wins
	
	jr $ra
	 	
# PLAYERS' MOVES
O_move:
	li $v0, 4
	la $a0, prompt_O_move
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, O_move
	bgt $t1, 9, O_move
	subi $t1, $t1, 1
	mul $t1, $t1, 4
	la $t0, board
	add $t0, $t0, $t1
	lw $t2, 0($t0)
	beq $t2, 'O', O_move
	beq $t2, 'X', O_move
	addi $t2, $zero, 'O'
	sw $t2, 0($t0)
	jr $ra
	
X_move:
	li $v0, 4
	la $a0, prompt_X_move
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 1, X_move
	bgt $t1, 9, X_move
	subi $t1, $t1, 1
	mul $t1, $t1, 4
	la $t0, board
	add $t0, $t0, $t1
	lw $t2, 0($t0)
	beq $t2, 'O', X_move
	beq $t2, 'X', X_move
	addi $t2, $zero, 'X'
	sw $t2, 0($t0)
	jr $ra
	

# PRINTING ENDING INFORMATIONS
cout_O_wins:
	li $v0, 4
	la $a0, prompt_O_wins
	syscall
	j exit
cout_X_wins:
	li $v0, 4
	la $a0, prompt_X_wins
	syscall
	j exit
cout_tie:
	li $v0, 4
	la $a0, prompt_draw
	syscall
	j exit
exit:
	li $v0, 10
	syscall

# PRINTING THE BOARD
cout_board:
	la $t9, board
	
	li $v0, 4
	la $a0, prompt_1
	syscall
	li $v0, 4
	la $a0, prompt_begin_of_line
	syscall
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_newline
	syscall
	li $v0, 4
	la $a0, prompt_vertical_line
	syscall
	add $t9, $t9, 4
	
	li $v0, 4
	la $a0, prompt_2
	syscall
	li $v0, 4
	la $a0, prompt_begin_of_line
	syscall
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_newline
	syscall
	li $v0, 4
	la $a0, prompt_vertical_line
	syscall
	add $t9, $t9, 4
	
	li $v0, 4
	la $a0, prompt_3
	syscall
	li $v0, 4
	la $a0, prompt_begin_of_line
	syscall
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_between
	syscall
	add $t9, $t9, 4
	lw $t8, 0($t9)
	move $a0, $t8
	li $v0, 11
	syscall
	li $v0, 4
	la $a0, prompt_newline
	syscall
	li $v0, 4
	la $a0, prompt_last
	syscall
	
	jr $ra
