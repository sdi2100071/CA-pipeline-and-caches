
#################################################
#                                               #
#               text segment                    #
#                                               #
#################################################

#################################################
#     [ An x s ]                                #
#     vector x scalar                           #
#################################################
# $s0 --> scalar
# $s1 --> N
# $a0 --> vector
# $t2 --> current vector element
# $s3 --> result
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

    beq $s1, $zero, Exit 
    lw $t2, 0($a0)          # Load vector element
    
    mul $t3, $t2, $s0       # Multiply element * scalar
    sw $t3, 0($s3)          # Store result
    lw $t5, 0($s3)

    addi $s3, $s3, 4        # Load address of next result
    addi $a0, $a0, 4        # Load address of next element
    addi $s1, $s1, -1       # Reduce element counter

    j loop

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
scalar: .word 2
vector: .word 1, 2, 3, 4, 5, 6, 7, 8
result: .space 32




