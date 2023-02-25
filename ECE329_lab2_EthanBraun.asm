# Writing a comment

.data
INPUT_N: .asciiz "Please enter a number as n: "

EQUATION: .asciiz "f = 2 * g + 5 * h - 8 * z\n"

OUTPUT_MESSAGE: .asciiz "Output: "

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

	jal FUN

	# Display message for final output	
	li $v0, 4
	la $a0, OUTPUT_MESSAGE
	syscall
	# Display output value
	li $v0, 1
	add $a0, $s7, 0
	syscall

OUT_ZERO:
	li, $v0, 1
	jr $ra

OUT_ONE:
	li, $v0, 3
	jr $ra

FUN:
	jal

OUTPUT_FINAL: