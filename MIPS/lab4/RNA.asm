.data
    dna_sequence: .space 50       
    rna_sequence: .space 50       
    newline: .asciiz "\n"         

.text
    main:
        li $v0, 8                   
        la $a0, dna_sequence        
        li $a1, 50
        syscall

        la $t0, dna_sequence        # Load address of DNA sequence
        la $t1, rna_sequence        # Load address of RNA sequence
        li $t2, 0                   # Initialize loop index to 0

    loop:
        lbu $t3, ($t0)              # Load a byte from DNA sequence
        beqz $t3, end_loop          # If the byte is zero, jump to end_loop

        # Determine the RNA complement for each nucleotide
        beq $t3, 71, set_C          # G -> C
        beq $t3, 67, set_G          # C -> G
        beq $t3, 84, set_A          # T -> A
        beq $t3, 65, set_U          # A -> U
        j next_iteration

    set_C:
        sb $zero, ($t1)             # Store 'C' in RNA sequence
        j next_iteration

    set_G:
        sb $t3, ($t1)               # Store 'G' in RNA sequence
        j next_iteration

    set_A:
        sb $zero, ($t1)             # Store 'A' in RNA sequence
        j next_iteration

    set_U:
        li $t3, 85                  # Set $t3 to ASCII value of 'U'
        sb $t3, ($t1)               # Store 'U' in RNA sequence
        j next_iteration

    next_iteration:
        addi $t0, $t0, 1            # Increment DNA sequence pointer
        addi $t1, $t1, 1            # Increment RNA sequence pointer
        addi $t2, $t2, 1            # Increment loop index
        j loop

    end_loop:
        sb $zero, ($t1)             # Store null terminator in RNA sequence

        # Print the RNA sequence
        li $v0, 4                   # Print string system call
        la $a0, rna_sequence        # Load address of RNA sequence
        syscall

        # Print a newline character
        li $v0, 4                   # Print string system call
        la $a0, newline             # Load address of newline character
        syscall

        li $v0, 10                  # Exit program
        syscall
