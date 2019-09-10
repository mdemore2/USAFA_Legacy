#-------------------------------------------------------------------------------
# ICE 2 - Intro to MIPS
# Mark Demore II / 10 Apr 20157 (Start Date) / 10 Apr 2017 (Completion Date)
#
# Purpose:  This program counts up and down to 10 by 2.
# 
# Documentation: none 
#-------------------------------------------------------------------------------

	addi $t0, $0, 0	#store value of 0 in register $t0
	
addr:	
	add $t0, $t0, 2		#increment value of $t0 by 2
	beq $t0, 10, subtr	#go to subtract loop when counted to 10
	j addr

subtr:
	sub $t0, $t0, 2		#increment value of $t0 by 2
	beq $t0, 0, addr	#go to subtract loop when counted to 10
	j subtr

end:
	j end			#end program
	
	
