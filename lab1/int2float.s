	;R0	contains the lower 8 bits
	;Memory location 2 contains least significant word of input
	LDRI	R0, [#2]
	;R1	contains the upper 8 bits
	;Memory location 1 contains most significant word if input
	LDRI	R1, [#1]
	
	;Isolate sign bit into R2
	ANDI	R2, R1, #0x80
	;Set (biased) E = 29 into R3
	MOVI	R3, #29
	
	;So R4 has the lower 8 bits
	;Copy R4[7:0]=I[7:0]
	MOV		R4, R0;
	;So R5 has the upper 7 bits (which excludes the sign bit)
	;Copy R5[14:8]=I[14:8]
	ANDI	R5, R1, #0x7F
	
	;FOR LOOP
FORLOOP
	;Isolate R4[14] (which is the 15th bit)
	ANDI	R6, R5, #0x40
	;Move #0x40 into R7 for BEQ comparison
	MOVI 	R7, #0x40
	;Compare and see if 15th bit is 1
	;If (R6 == #0x40), then break out of the loop. Branch to out
	BEQ		R6, R7, OUT

	;This is the other case, where R6 == 0
	;Then left shift R4/R5 and decrement R3
	;Shift upper 8 bit one to the left
	LSLI	R5, R5, #1
	;Extract the 8th bit of lower 8bits
	ANDI	R6, R4, #0x80
	;Shift it right 7 places so the extracted bit is in the first bit
	LSRI	R6, R6, #7
	;Or	it to piece it back together
	ORR		R5, R5, R6
	;Shift lower 8 bit one to the left. The overflow is taken care of above
	LSLI	R4, R4, #1
	
	;Decrement exponent value by 1
	SUB		R3, R3, #1
	
	;Continue	loop
	B		FORLOOP
OUT

	;ROUNDING
	;Case A: If(R4[4]==1 && R4[3]==1) add R4+8
	;Extract R4[4]
	ANDI	R6, R4, #0x10
	;Move 1 into R7 for BEQ comparison
	MOVI 	R7, #1
	;Compare and see if R4[4] == 1
	BEQ		R6, R7, ROUDING_CASE_A
	;Coming	out of Case A if statement
ROUNDING_CASE_A_EXIT
	
	;Case B: If(R4[4]==0 && R4[3]==1 && R4[2:0]!=0) add R4+8
	;Extract R4[4]	
	ANDI	R6, R4, #0x10
	;Move 0 into R7 for BEQ comparison
	MOVI 	R7, #0
	;Compare to see if R[4] == 0
	BEQ		R6, R7, ROUDING_CASE_B
	;Coming	out of PART 2 if statement
ROUNDING_CASE_B_EXIT
	
	;OVERFLOW	CHECK
	;Move 1 into R6 for BEQ comparioson
	MOVI	R6, #0x80
	;Compare to see if 16th bit is negative. If so, go to OVERFLOW
	;R2 has the 16th bit already so use that for comparison
	BEQ 	R2, R6, OVERFLOW
	;Coming	out of overflow if statement
OVERFLOW_END
	
	;Putting the value together
	;Bring the sign bit into R5
	ORR		R5, R5, R2
	;Then output the result into respective memory locations
	;LSW of result into 6
	STRI	R4, [#6]
	;MSW of result into 5
	STRI	R5, [#5]

	;The end of the program, goes to the end. 
	B		END
	
	;All branches
	;=====================================================

	;Compare and see if R4[3] == 1
ROUDING_CASE_A
	;Extract R4[3]
	ANDI	R6, R4, #0x8
	; Move 1 into R7 for BEQ comparison
	MOVI 	R7, #0x8
	;Compare and see if R4[3] == 1. If so, then go to next branch
	BEQ		R6, R7, ROUDING_CASE_A_1
	B		ROUDING_CASE_A_EXIT

	;Add R4+8
ROUNDING_CASE_A_1 
	ADDI 	R4, R4, #8
	B 		ROUNDING_CASE_A_EXIT
	

	;Compare and see if R4[3] == 1
ROUDING_CASE_B
	;Extract R4[3]
	ANDI	R6, R4, #0x8
	;Move 1 into R7 for BEQ comparison
	MOVI 	R7, #0x8
	;Compare and see if R4[3] == 1. If so, then go to next branch
	BEQ		R6, R7, ROUDING_CASE_B_1
	B		ROUDING_CASE_B_EXIT
	
	;Compare and see if R3[2:0] != 0
ROUDING_CASE_B_1
	;Extract R3[2:0]
	ANDI	R6, R4, #0x7
	;Move 0 into R7 for BNE comparison
	MOVI	R7, #0
	;Compare and see if R3[2:0] != 0, if so, then go to next branch
	BNE		R6, R7, ROUNDING_CASE_B_2
	B		ROUDING_CASE_B_EXIT
	
	;Add R4+8
ROUNDING_CASE_B_2
	ADDI 	R4, R4, #8
	B 		ROUNDING_CASE_B_EXIT
	
	;Overflow check
OVERFLOW
	;Right shift R4/R5 and increment R3
	;Shift lower 8 bit one to the right
	LSRI	R4, R4, #1
	;Extract the 1st bit of upper 8bits
	ANDI	R6, R5, #0x1
	;Shift it left 7 places so the extracted bit is in the eight bit
	LSLI	R6, R6, #7
	;Or	it to piece it back together
	ORR		R4, R4, R6
	;Shift upper 8 bit one to the right. The overflow is taken care of above
	LSRI	R5, R5, #1
	;Increment exponent value by 1
	ADDI	R3, R3, #1
	B		OVERFLOW_END
END