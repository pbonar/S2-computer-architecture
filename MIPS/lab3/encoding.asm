.data
plain:  .asciiz "abcdefghijklmnopqrstuvwxyz"   # Plain alphabet
cipher: .asciiz "zyxwvutsrqponmlkjihgfedcba"   # Cipher alphabet
result1: .space 256   # Buffer to store the encoded result for example 1
result2: .space 256   # Buffer to store the encoded result for example 2
newline: .asciiz "\n"   # New line character

.text
.globl main

# Function to encode a string using the Atbash cipher
encode:
    addi $sp, $sp, -4          # Make room on the stack
    sw $ra, 0($sp)             # Save the return address
    
    move $t1, $a0              # Store the address of the input string in $t1
    move $t2, $a1              # Store the address of the output string in $t2
    li $t3, 0                  # Initialize $t3 to 0 (index)
    
encode_loop:
    lbu $t4, 0($t1)            # Load a character from the input string
    beqz $t4, encode_end       # If the character is null, end the loop
    
    blt $t4, 97, skip_encode   # If the character is not a lowercase letter, skip encoding
    sub $t4, $t4, 97           # Convert the character to an index (0-25)
    lbu $t5, cipher($t4)       # Load the corresponding character from the cipher alphabet
    sb $t5, 0($t2)             # Store the encoded character in the output string
    
    addi $t1, $t1, 1           # Move to the next character in the input string
    addi $t2, $t2, 1           # Move to the next position in the output string
    addi $t3, $t3, 1           # Increment the index
    
    b encode_loop
    
encode_end:
    lbu $t4, 0($t2)            # Load the character from the output string
    beqz $t4, encode_return    # If the character is null, return
    
    blt $t4, 97, skip_encode   # If the character is not a lowercase letter, skip encoding
    sub $t4, $t4, 97           # Convert the character to an index (0-25)
    lbu $t5, cipher($t4)       # Load the corresponding character from the cipher alphabet
    sb $t5, 0($t2)             # Store the encoded character in the output string
    
    j encode_end

skip_encode:
    sb $t4, 0($t2)             # Copy the character as is (not a lowercase letter)
    j encode_end

encode_return:
    lw $ra, 0($sp)             # Restore the return address
    addi $sp, $sp, 4           # Release the stack space
    jr $ra                     # Return

main:
    # Example usage:
    
    # Encode "test" and store the result in "result1"
    la $a0, plain              # Load the address of the plain alphabet
    la $a1, result1            # Load the address of the output string
    jal encode
    
    # Encode "x123 yes" and store the result in "result2"
    la $a0, plain              # Load the address of the plain alphabet
    la $a1, result2            # Load the address of the output string
    jal encode
    
    # Print the encoded results
    li $v0, 4                  # Print string syscall
    
    # Print the encoded result for example 1
    la $a0, result1
    syscall
    
    # Print a new line
    li $v0, 4
    la $a0, newline
    syscall
    
    # Print the encoded result for example 2
    la $a0, result2
    syscall
    
    # Exit program
    li $v0, 10
    syscall

