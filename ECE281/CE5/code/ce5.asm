#;-------------------------------------------------------------------------------
#; CompEx 5 - High-Low Game
#; Mark Demore II / 13 Apr 2017 (Start Date) / 14 Apr 2017 (Completion Date)
#;
#; Purpose:  This program is a high-low guessing game, using memory-mapped I/O
#; 
#; Documentation: None 
#;-------------------------------------------------------------------------------

main:
	lw $t5, 0xFFFF0000
	beq $t5, 1, compare
	j main


compare:
	addi $t1, $0, 4 	#store "random" value
	lw $t2, 0xFFFF0004	#retrieve user guess
	sub $t2, $t2, 48	#take care of ascii offset
	beq $t2, $t1, win	#determine if guess correct
	slt $t3, $t2, $t1 	#determine if low or high
	beq $t3, 1, low
	j high
	
win:
	addi $t5, $0, 1		#set ready bit
	sw $t5, 0xFFFF0008
	addi $t4, $0, 'W'	#store output
	sw $t4, 0xFFFF000C
	j main
	
low: 
	addi $t5, $0, 1
	sw $t5, 0xFFFF0008
	addi $t4, $0, 'L'
	sw $t4, 0xFFFF000C
	j main
	
high:
	addi $t5, $0, 1
	sw $t5, 0xFFFF0008
	addi $t4, $0, 'H'
	sw $t4, 0xFFFF000C
	j main
