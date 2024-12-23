
#################################################
#                                               #
#               text segment                    #
#                                               #
#################################################

#################################################
#     [ An x s ]                                #
#     vector x scalar                           #
#################################################

#################################################
# $s0 --> scalar                                #
# $s1 --> N                                     #
# $a0 --> vector                                #
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
    la $t0, n        # Load N - vector dim
    lw $s1, 0($t0)  
    lw $s0, 4($t0)   # Load scalar

    la $a0, vector   # Load vector
    la $s3, result   # Load result

loop:
    mflo $t7
    beq $s1, $zero, Exit 
    lw $t2, 0($a0)          # Load vector element
    
    mult $t2, $s0

    # Check for arithmetic overflow.
    mfhi $t6
    mflo $t7
    sw $t7, 0($s3)          # Store result.
    sra $t7, $t7, 31

    addi $s3, $s3, 4        # Load address of next result
    addi $a0, $a0, 4        # Load address of next element
    addi $s1, $s1, -1       # Reduce element counter

    beq $t6, $t7, loop

Exit:   
        li $v0, 10
        syscall             

#################################################
#                                               #
#           data segment                        #
#                                               #
#################################################

    .data
n: .word 16
scalar: .word 20
vector: .word 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 43
result: .space 32




