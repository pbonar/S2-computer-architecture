# Zdefiniuj liczbę wejściową i stałe formatu IEEE 754
.data
in_iod: .word -6
out_f: .float 0.0

.text
.globl main
main:
    # Wczytaj liczbę wejściową do rejestru $t0
    lw $t0, in_iod
    
    # Sprawdź znak i zamień na dodatnią
    addi $t1, $zero, 0
    bltz $t0, negate
    j normalize

negate:
    sub $t0, $zero, $t0
    addi $t1, $zero, 1

normalize:
    # Oblicz wartość eksponenty
    addi $t2, $zero, 31  # Wartość początkowa eksponenty (2^31)
    addi $t3, $zero, 0   # Licznik przesunięć w lewo

shift_left:
    sll $t0, $t0, 1
    addi $t3, $t3, 1
    bgez $t0, shift_left
    subi $t3, $t3, 1
    add $t2, $t2, $t3

    # Utwórz wartość mantysy w kodzie binarnym
    addi $t3, $zero, 0   # Licznik bitów w mantysie
    addi $t4, $zero, 0   # Maska bitowa
    addi $t5, $zero, 1   # Wartość początkowa maski bitowej

create_mantissa:
    slti $t6, $t3, 23    # Sprawdź, czy osiągnięto 23 bity mantysy
    beqz $t6, create_mantissa_done
    and $t7, $t0, $t5
    srlv $t7, $t7, $t3
    or $t4, $t4, $t7
    addi $t3, $t3, 1
    sll $t5, $t5, 1
    j create_mantissa

create_mantissa_done:
    # Utwórz wartość eksponenty w kodzie binarnym
    addi $t2, $t2, 127
    sll $t2, $t2, 23

    # Utwórz wartość bitową liczby zmiennoprzecinkowej w formacie IEEE 754
    or $t8, $t1, $t2
    or $t8, $t8, $t4

    # Zapisz wynik do zmiennej wyjściowej
    sw $t8, out_f

    # Zakończ program
    li $v0, 10
    syscall 
