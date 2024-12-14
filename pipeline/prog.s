
#################################################
#                                               #
#               text segment                    #
#                                               #
#################################################

.globl _start
.globl __start
.set noreorder
.ent _start

    .text
    .globl __start  
                                
__start:

main: 

    # load array address 
    lui $t1, 0x1001
    ori $s0, $zero, 200
    
    addi $t3,$zero, 0   # counter of negatives
    ori $a0, $t1, 4     # address of first element       
    addi $t4,$zero, 0   # counter of positives
    addi $t5,$zero, 0   # counter of odds

    lw $t2, 0($a0)      # load first array element

    addi $t7,$zero, 0   # counter of zeros
    addi $t6,$zero, 0   # counter of evens

    addiu $s5, $a0, 800 # load adress of last element


# Unroll: 4 elements per loop
loop:
    # 1st Element
    srl $t0, $t2, 31    # get msb     
    sltiu $t8, $t2, 1   # check if zero   
    andi $t9, $t2, 1    # get lsb 
    add $t3, $t3, $t0   # add msb to negatives counter
    lw $t2, 4($a0)      # load next array element
    add $t5, $t5, $t9   # add lsb to odds counter
    add $t7, $t7, $t8   # add slt result to counter zeros
    
    # 2nd Element
    srl $t0, $t2, 31    # get msb  
    andi $t9, $t2, 1    # get lsb
    sltiu $t8, $t2, 1   # check if zero
    add $t3, $t3, $t0   # add msb to negatives counter
    lw $t2, 8($a0)      # load next array element
    add $t5, $t5, $t9   # add lsb odds counter
    add $t7, $t7, $t8   # add slt result to counter zeros

    # 3rd element
    srl $t0, $t2, 31    # get msb    
    sltiu $t8, $t2, 1   # check if zero
    andi $t9, $t2, 1    # get lsb
    add $t3, $t3, $t0   # add msb to negatives counter
    lw $t2, 12($a0)     # load next array element
    add $t5, $t5, $t9   # add lsb to odds counter
    add $t7, $t7, $t8   # add slt result to zeros counter
    
    # 4th Element
    srl $t0, $t2, 31    # get msb  
    andi $t9, $t2, 1    # get lsb
    sltiu $t8, $t2, 1   # check if zero
    addiu $a0, $a0, 16  # add address of the next element 
    add $t3, $t3, $t0   # add msb to negatives counter
    add $t5, $t5, $t9   # add lsb to odds counter
    lw $t2, 0($a0)      # load next array element
    add $t7, $t7, $t8   # add slt result to zeros counter
    
    beq $a0, $s5, Exit
    j loop
	 

Exit:     

    # Load counters data addresses
    addiu $s3, $a0, 4   # Address for N
    addiu $s4, $a0, 8   # Address for P
    addiu $s5, $a0, 12  # Address for Z
    addiu $s6, $a0, 16  # Address for E
    addiu $s7, $a0, 20  # Address for O


    #positives = array size - negatives - zeros
    sub $t4, $s0, $t3       # rm from total size the negatives and add to positives
    sub $s0, $s0, $t7       # rm from new total size the zeros

    
    addi $v0, $zero, 10     # $v0 = 10 --> exit
    sub $t4, $t4, $t7       # rm from positives the zeros

    #evens 
    sub $t6, $s0, $t5       # rm from current total size the odds and add to evens.

    # store data counters.
    sw $t3, 0($s3)
	sw $t4, 0($s4)
	sw $t5, 0($s5)
	sw $t6, 0($s6)
	sw $t7, 0($s7)
    
    # EXIT
    syscall 


#################################################
#                                               #
#           data segment                        #
#                                               #
#################################################
# NETIVES : 99
# POSITIVES : 97
# ZEROS : 4
# EVENS : 110
# ODDS : 86
#################################################
    
    .data

size_array: .word 0x200

A: .word -89, 44, -69, -54, -56, -88, -42, -32, -94, -71, 0, -64, 73, 20, -44, -81, 67, -81, 100, -10, -12, 3, -3, -9, 72, -32, -65, 29, 34, -50, -77, 4, 13, 6, -69, 68, -60, -2, 7, 66, -46, -56, -39, -62, 10, -43, 38, -10, -62, -12, 2, 37, -76, -39, 27, -88, 94, -51, 70, 9, 68, -21, -55, 0, -13, -80, 96, -18, -31, 77, -9, 75, -46, 74, -76, -27, 84, 4, -46, -84, -34, 38, 48, -19, 22, -64, 76, -54, -56, -54, -20, -24, 76, -78, -82, -57, 90, 42, -84, -53, 22, -20, 20, 29, 59, -72, -75, 4, -33, 24, -54, 36, 53, -100, 96, -76, 95, 69, 100, 63, -2, 48, 51, 37, 99, 74, 22, -49, 25, 20, 77, 39, 0, 84, 23, 54, -23, -55, 41, 34, -80, -2, -98, 23, 28, 61, 55, -44, -22, 18, 97, -36, -32, 17, 70, 80, 9, -51, -99, -61, 69, 0, 39, 90, -12, -83, -19, -76, 83, 77, 35, -33, 31, 25, -99, -14, -3, -38, 43, -80, 39, -32, 44, 78, 35, 78, 5, 46, 42, -41, 1, 49, -87, 31, 22, 17, -81, -98, -58, -7

N: .word 0    # Negatives
P: .word 0    # Positives
Z: .word 0    # Zeros
E: .word 0    # Evens
O: .word 0    # Odds





