#-------------------------------------------------------------------------------
# ICE 2 - Intro to MIPS
# Mark Demore II / 10 Apr 20157 (Start Date) / 10 Apr 2017 (Completion Date)
#
# Purpose:  This program accepts user input and outputs the integer divided by 8 using bit shifting operations.
# 
# Documentation: referenced Stack Overflow and Missouri State website to figure out how to use syscall to accept input and print output 
#-------------------------------------------------------------------------------

.data

	intPrompt:	.asciiz "\nPlease enter an unsigned integer\n"
	outPrompt:	.asciiz "\nThe integer divided by 8 is\n"

.text
	
main:
		j prompt
	
prompt:
		li $v0, 4		#give print string command
		la $a0, intPrompt	#load intPrompt to output
		syscall			#execute
		j readInput
readInput:
		li $v0, 5		#give read int command
		syscall			#execute
		add $t2, $v0, $0	#store input in t2
		j divide
		
divide:
		srl $t1, $t2, 3		#shift bits right thrice, dividing by 8 - store in t1
		j output

output:
		li $v0, 4		#give print string command
		la $a0, outPrompt	#load outPrompt to output
		syscall			#execute
		
		li $v0, 1		#give pring int command
		add $a0, $t1, $0	#load input/8 from t1
		syscall			#execute
		