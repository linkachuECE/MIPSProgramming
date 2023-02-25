# Writing a comment

.data
	INPUT_N: 	.asciiz	"Please enter a number as n: "
	EQUATION: 	.asciiz	"Equation:\nf(n) = 4 * f(n - 1) + 2 * f(n - 2)\nf(1) = 3\nf(0) = 1\n"
	OUTPUT_MESSAGE: .asciiz	"Output: "

	result: 	.word	0

NEWLINE: .asciiz "\n"
.globl main
.text

main:
	# Display message for N input
	li $v0, 4
	la $a0, EQUATION
	syscall
	
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
	# Move stack pointer down
	subu $sp, $sp, 12
	
	# Store return address and argument value in $a0
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
	
	# Store 2 times the return value of the second recursion in $t0
	sll $t0, $v0, 1
	
	# Retrieve result of 4 times previous recursion from stack
	lw $t1, 8($sp)
	
	# Store final result in $v0a
	addu $v0, $t0, $t1
	
	# Move stack pointer back up
	b UP_STACK
	
	# Function that returns 3 if n = 1
	ONE_OUT:
		li $v0, 3
		b UP_STACK
		
	# Function that returns 1 if n = 0
	ZERO_OUT:
		li $v0, 1
		b UP_STACK
	
	# Function for going back up the stack
	UP_STACK:
		lw $ra 0($sp)
		addu $sp, $sp, 12
		jr $ra