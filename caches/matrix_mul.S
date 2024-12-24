.text
.globl main
.set noat
.set noreorder
.ent main


main:
    li $s0, 4 
    li $t3, 0
    li $s3, 0
    li $s5, 0
    li $s6, 2 # Line blocks
    xor $t4, $t4, $t4
    xor $t8, $t8, $t8

    la $t5, array_z          # Load address of array_z into $t5
    la $t6, array_x          # Load address of array_x into $t6
    la $t7, array_y          # Load address of array_y into $t7
    j next_element

    
    next_element_block_x:
        xor $s1, $s1, $s1
        xor $s3, $s3, $s3
        xor $s4, $s4, $s4
        xor $t3, $t3, $t3
        xor $t4, $t4, $t4
        addi $t5, $t5, 4

    first_element_block_y:
        la $t7, array_y          
        j next_element


    next_element_block_y:
        xor $s1, $s1, $s1
        xor $s3, $s3, $s3
        xor $t3, $t3, $t3
        xor $t4, $t4, $t4
        addi $t5, $t5, -92 


    first_previous_block_x:
        addi $t6, $t6, -128
        j next_element

    next_blocks_right_both:
        xor $s1, $s1, $s1
        xor $t4, $t4, $t4
        xor $t3, $t3, $t3

        addi $t6, $t6, -96
        addi $t7, $t7, -96
        addi $t5, $t5, -108

        j next_element
    
    next_line_x:
        xor $t4, $t4, $t4
        addi $t6, $t6, 32
        addi $t5, $t5, 16

    current_first_block_line_y:
        addi $t7, $t7, -128

    # Reset x_line and go to next line for y
    next_line_y: 
        xor $t3, $t3, $t3
        addi $t7, $t7, 16
        addi $t5, $t5, 4

    start_line_x:
        addi $t6, $t6, -16 


    next_element:
        lw $t0, 0($t6)    
        lw $t1, 0($t7)           
        # lw $t2, 0($t5)         

        mult $t0, $t1
        mfhi $t2 
        mflo $t9

        lw $s7, 0($t5)
        add $s7, $s7, $t9
        sw $s7, 0($t5)    
        
        sra $t9, $t9, 31
        bne $t9, $t2, exit 
        mflo $t9


        xor $t9, $t9, $t9

        addi $t6, $t6, 4
        addi $t7, $t7, 4

        addi $t3, $t3, 1
        slt $t8, $t3, $s0
        bne $t8, $zero, next_element 


        addi $t4, $t4, 1
        slt $t9, $t4, $s0       
        bne $t9, $zero, next_line_y  


        addi $s1, $s1, 1
        slt $s2, $s1, $s0
        bne $s2, $zero, next_line_x   

        
        addi $s3, $s3, 1
        slt $s2, $s3, $s6
        bne $s2, $zero, next_blocks_right_both

        addi $s4, $s4, 1
        slt $s2, $s4, $s6
        bne $s2, $zero, next_element_block_y

        addi $s5, $s5, 1      
        slt $s2, $s5, $s6     
        bne $s2, $zero, next_element_block_x  

    print_array:
        la $t0, array_z       # Load address of the array into $t0
        li $t1, 64            # Number of elements to print
        li $t2, 4             # Size of each element in bytes
        li $t3, 8             # Counter for printing rows (8 elements per row)

    print_loop:
        beq $t1, $zero, exit  # Break if all elements are printed

        lw $a0, 0($t0)        # Load current element into $a0
        li $v0, 1             # Print integer syscall
        syscall

        # Print a space after the number
        li $v0, 11            # Print character syscall
        li $a0, 32            # ASCII code for space
        syscall

        addi $t0, $t0, 4      # Move to the next word (4 bytes)
        addi $t1, $t1, -1     # Decrement total counter
        addi $t3, $t3, -1     # Decrement row counter

        beq $t3, $zero, print_newline  # If 8 elements printed, go to newline printing

        j print_loop          # Continue the loop

    print_newline:
        # Print a newline after 8 elements
        li $v0, 11            # Print character syscall
        li $a0, 10            # ASCII code for newline
        syscall

        li $t3, 8             # Reset row counter
        j print_loop          # Continue printing next row

    exit:
        li $v0, 10            # Exit syscall
        syscall






.end main

.data
# .org 10000000


array_x:
    .word 1, 1, 1, 1, 1, 1, 1, 1
    .word 2, 2, 2, 2, 2, 2, 2, 2
    .word 3, 3, 3, 3, 3, 3, 3, 3
    .word 4, 4, 4, 4, 4, 4, 4, 4 
    .word 5, 5, 5, 5, 5, 5, 5, 5
    .word 6, 6, 6, 6, 6, 6, 6, 6
    .word 7, 7, 7, 7, 7, 7, 7, 7
    .word 8, 8, 8, 8, 8, 8, 8, 8


array_y:
    .word 1, 1, 1, 1, 1, 1, 1, 1
    .word 2, 2, 2, 2, 2, 2, 2, 2
    .word 3, 3, 3, 3, 3, 3, 3, 3
    .word 4, 4, 4, 4, 4, 4, 4, 4 
    .word 5, 5, 5, 5, 5, 5, 5, 5
    .word 6, 6, 6, 6, 6, 6, 6, 6
    .word 7, 7, 7, 7, 7, 7, 7, 7
    .word 8, 8, 8, 8, 8, 8, 8, 8


array_z:
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0
    .word 0, 0, 0, 0, 0, 0, 0, 0





