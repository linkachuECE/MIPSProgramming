# Writing a comment

.data
	INPUT_N: 	.asciiz	"Please enter a number as n: "
	EQUATION: 	.asciiz	""
	OUTPUT_MESSAGE: .asciiz	"Output: "

	result: 	.word	0

NEWLINE: .asciiz "\n"
.globl main
.text

main:
	# Display message for N input
	li $v0, 4
	la $a0, INPUT_N
	syscall

	# Get input for N and store in $a0
	li $v0, 5
	syscall
	addi $a0, $v0, 0
	
	# Call function
	jal FUN
	addi $t0, $v0, 0

	# Display message for final output
	li $v0, 4
	la $a0, OUTPUT_MESSAGE
	syscall
	# Display output value
	li $v0, 1
	addi $a0, $t0, 0
	syscall
	
	# End program
	li $v0, 10
	syscall
	
FUN:
	# Set V0 to 1 initially
	li $v0, 1
	
	# Move stack pointer down
	subu $sp, $sp, 12
	
	# Store return address and value in $a0
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	# Test for zero and one
	beq $a0, 0, ZERO_OUT
	beq $a0, 1, ONE_OUT
	
	# First recursion
	subi $a0, $a0, 1
	jal FUN
	
	# Store four times return of first recursion in stack
	sll $t0, $v0, 2
	sw $t0, 8($sp)
	
	# load original $a0 value 
	lw $a0, 4($sp)
	
	# Second recursion
	subi $a0, $a0, 2
	jal FUN
	
	# Store 2 times return of second recursion in $t0
	sll $t0, $v0, 1
	
	# Get result of 4 times previous recursion from stack
	lw $t1, 8($sp)
	
	# Store final result in $v0
	addu $v0, $t0, $t1
	
	# Move stack pointer back up
	lw $ra 0($sp)
	lw $s0 4($sp)
	addu $sp, $sp, 12
		
	jr $ra
	
	ONE_OUT:
		lw $ra 0($sp)
		addu $sp, $sp, 12
		
		li $v0, 3
		jr $ra
	ZERO_OUT:
		lw $ra 0($sp)
		addu $sp, $sp, 12
		
		li $v0, 1
		jr $ra