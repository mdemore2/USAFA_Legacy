#-------------------------------------------------------------------------------
# ICE 2 - Intro to MIPS
# Mark Demore II / 10 Apr 20157 (Start Date) / 10 Apr 2017 (Completion Date)
#
# Purpose:  This program stores 3 values in registers: 5, 20, and 0. It then sums 5 and the incremented, by 4, values of the counter value until the loop exits when the counter reaches 20.
# 
# Documentation: none 
#-------------------------------------------------------------------------------

	addi $t0, $0, 5		#store value of 5 in register $t0
	addi $t1, $0, 20 	#store value of 20 in register $t1
	add $t2, $0, $0 	#store value of 0 in register $t2
loop:	
	add $t0, $t0, $t2	#add values of $t0 and $t2 in $t0, end value is 0x2D or 45
	addi $t2, $t2, 4	#increment value of $t2 by 4 in $t2
	beq $t2, $t1, end	#end loop when values in $t1 = $t2, or when $t2 = 20, loop will execute 5 times
	j loop
end:
	j end			#end program
	
	
