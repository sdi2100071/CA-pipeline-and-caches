.text
.globl _start
.set noat
.set noreorder
.ent _start


li $s0, 4 
li $t3, 0
li $s3, 0
li $s5, 0
li $s6, 2 # Line blocks
xor $t4, $t4, $t4
xor $t8, $t8, $t8


_start:

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
        lw $t2, 0($t5)           

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

    exit:
        li $v0, 10       # Load exit syscall code into $v0
        syscall          # Trigger the syscall to terminate the program


.end _start

.data
.org 10000000


array_x:
    .word 1, 11, 111, 1111, 91, 911, 9111, 91111
    .word 2, 22, 222, 2222, 92, 922, 9222, 92222
    .word 3, 33, 333, 3333, 93, 933, 9333, 93333
    .word 4, 44, 444, 4444, 94, 944, 9444, 94444 
    .word 5, 55, 555, 5555, 95, 955, 9555, 95555
    .word 6, 66, 666, 6666, 96, 966, 9666, 96666
    .word 7, 77, 777, 7777, 97, 977, 9777, 97777
    .word 8, 88, 888, 8888, 98, 988, 9888, 98888


array_y:
    .word 1, 11, 111, 1111, 91, 911, 9111, 91111
    .word 2, 22, 222, 2222, 92, 922, 9222, 92222
    .word 3, 33, 333, 3333, 93, 933, 9333, 93333
    .word 4, 44, 444, 4444, 94, 944, 9444, 94444
    .word 5, 55, 555, 5555, 95, 955, 9555, 95555
    .word 6, 66, 666, 6666, 96, 966, 9666, 96666
    .word 7, 77, 777, 7777, 97, 977, 9777, 97777
    .word 8, 88, 888, 8888, 98, 988, 9888, 98888

array_z:
    .word 1, 11, 111, 1111, 91, 911, 9111, 91111
    .word 2, 22, 222, 2222, 92, 922, 9222, 92222
    .word 3, 33, 333, 3333, 93, 933, 9333, 93333
    .word 4, 44, 444, 4444, 94, 944, 9444, 94444
    .word 5, 55, 555, 5555, 95, 955, 9555, 95555
    .word 6, 66, 666, 6666, 96, 966, 9666, 96666
    .word 7, 77, 777, 7777, 97, 977, 9777, 97777
    .word 8, 88, 888, 8888, 98, 988, 9888, 98888




# array_z:
#     .space 100000              # 4x4 matrix, 64 bytes

