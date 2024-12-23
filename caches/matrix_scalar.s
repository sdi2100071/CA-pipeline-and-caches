
#################################################
#                                               #
#               text segment                    #
#                                               #
#################################################

#################################################
#     [ A_n*n x s ]                             #
#     square matrix x scalar                    #
#################################################

#################################################
# $s0 --> scalar                                #
# $s1 --> N                                     #
# $a0 --> array                                 #
# $t2 --> current vector element                #
# $s3 --> result                                #
#################################################


.globl _start
.globl __start
.set noreorder
.ent _start

    .text
    .globl __start  
                                
__start:

    la $t0, n        # Load N
    lw $s1, 0($t0)  
    lw $s0, 4($t0)   # Load scalar

    la $a0, array    # Load array
    la $s3, result   # Load result
    addi $t3, $zero, 0

outer:
    mflo $t7
    beq $s1, $zero, reinit 
    lw $t2, 0($a0)          # Load element
    
    mult $t2, $s0

    # Check for arithmetic overflow.
    mfhi $t6
    mflo $t7
    sw $t7, 0($s3)          # Store result.
    sra $t7, $t7, 31

    addi $s3, $s3, 4        # Load address of next result
    addi $a0, $a0, 4        # Load address of next element
    addi $s1, $s1, -1       # Reduce element counter

    beq $t6, $t7, outer

overflow:   
        li $v0, 10
        syscall 

reinit:
    lw $s1, 0($t0) 
    addi $t3, $t3, 1
    beq $t3, $s1, Exit

inner: 
    mflo $t7
    beq $s1, $zero, outer 
    lw $t2, 0($a0)          # Load element
    
    mult $t2, $s0

    # Check for arithmetic overflow.
    mfhi $t6
    mflo $t7
    sw $t7, 0($s3)          # Store result.
    sra $t7, $t7, 31

    addi $s3, $s3, 4        # Load address of next result
    addi $a0, $a0, 4        # Load address of next element
    addi $s1, $s1, -1       # Reduce element counter

    beq $t6, $t7, inner

Exit:   
        li $v0, 10
        syscall             

#################################################
#                                               #
#           data segment                        #
#                                               #
#################################################

    .data
n: .word 8
scalar: .word 3
array: .word     1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 69, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81 
       .word     1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 91, 1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 91 
       .word     1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 82, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 83, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 84, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 85, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 86, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81, 1, 2, 3, 4, 5, 6, 7, 87, 1, 2, 3, 4, 5, 6, 7, 81
       .word     1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 91, 1, 2, 3, 4, 5, 6, 7, 88, 1, 2, 3, 4, 5, 6, 7, 99
result: .space 1000




