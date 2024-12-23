.text
.globl _start
.set noat
.set noreorder
.ent _start

li $s0, 4
li $t3, 0
xor $t4, $t4, $t4
xor $t8, $t8, $t8



_start:

    la $t5, array_z          # Load address of array_z into $t5
    la $t6, array_x          # Load address of array_x into $t6
    la $t7, array_y          # Load address of array_y into $t7

loop:
    addi $t3, $t3, 1

    lw $t0, 0($t6)    
    lw $t1, 0($t7)           

    addi $t6, $t6, 4
    addi $t7, $t7, 4

    # Check if $t3 < $s0 and loop if true
    slt $t8, $t3, $s0
    bne $t8, $zero, loop

    addi $t6, $t6, -16          

    # Update $t7 and $t4, and reset $t6
    addi $t7, $t7, 16
    addi $t4, $t4, 1

    # Reset $t3 and $t8
    xor $t3, $t3, $t3
    xor $t8, $t8, $t8
    xor $t9, $t9, $t9

    # Check if $t4 < $s0 and loop if true
    slt $t9, $t4, $s0        # Compare $t4 and $s0 again
    bne $t9, $zero, loop     # Loop if $t4 is less than $s0

    xor $t4, $t4, $t4

    addi $t6, $t6, 32
    addi $s1, $s1, 1
    addi $t7, $t7, -128

    slt $s2, $s1, $s0
    bne $s2, $zero, loop


.end _start

.data
.org 10000000

array_x:
    .word 1, 11, 111, 1111, 99, 999, 9999, 99999
    .word 2, 22, 222, 2222, 99, 999, 9999, 99999
    .word 3, 33, 333, 3333, 99, 999, 9999, 99999
    .word 4, 44, 444, 4444, 99, 999, 9999, 99999
    .word 5, 55, 555, 5555, 99, 999, 9999, 99999
    .word 6, 66, 666, 6666, 99, 999, 9999, 99999
    .word 7, 77, 777, 7777, 99, 999, 9999, 99999
    .word 8, 88, 888, 8888, 99, 999, 9999, 99999

array_y:
    .word 1, 11, 111, 1111, 99, 999, 9999, 99999
    .word 2, 22, 222, 2222, 99, 999, 9999, 99999
    .word 3, 33, 333, 3333, 99, 999, 9999, 99999
    .word 4, 44, 444, 4444, 99, 999, 9999, 99999
    .word 5, 55, 555, 5555, 99, 999, 9999, 99999
    .word 6, 66, 666, 6666, 99, 999, 9999, 99999
    .word 7, 77, 777, 7777, 99, 999, 9999, 99999
    .word 8, 88, 888, 8888, 99, 999, 9999, 99999

array_z:
    .space 100000              # 4x4 matrix, 64 bytes
