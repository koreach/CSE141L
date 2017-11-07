					;Load	the input into r0
					;r0		contains the lower 8 bits
					mov		r0, #0x06
					;r1		contains the upper 8 bits
					mov		r1, #0x80
					
					;Isolate	sign bit into r2
					and		r2, r1, #0x80
					;Set		(biased) E = 29 into R2. 29-15	= 14 bits. 15th bit already defined in sigbit.16th bit is + or -
					mov		r3, #29
					
					;Copy	R4[7:0]=I[7:0] and R5[14:7]=I[14:7]
					;r4		contains lower 8 bits
					mov		r4, r0
					;r5		contains upper 8 bits
					and		r5, r1, #0xFF
					
					;FOR		LOOP
forloop
					;Isolate	the R3[14] bit
					and		r6, r5, #0x40
					;Compare	and see if 15th bit is 1
					cmp		r6, #0x40
					;If		(r4[14] == 1) break out of loop
					beq		out
					;Otherwise,	left shift R4/R5 and decrement R3
					
					;Shift	upper 8 bit one to the left
					lsl		r5, r5, #1
					;Extract	the 8th bit of lower 8bits
					and		r6, r4, #0x80
					;Shift	it right 7 places so its in the 1st bit place
					lsr		r6, r6, #7
					;Or		it to piece it back together
					orr		r5, r5, r6
					;Shift	lower 8 bit one to the left
					lsl		r4, r4, #1
					and		r4, r4, #0xFF
					
					;Decrement	exponent value
					sub		r3, r3, #1
					
					;Continue	loop
					b		forloop
					
out
					;ROUNDING
					;PART	1: If(R3[4]==1 && R3[3]==1) add R3+8
					and		r6, r4, #0x10
					;Compare	and see if 5th bit is 1
					cmp		r6, #0x10
					;If		(R3[4] == 1)
					beq		rounding_1
					;Coming	out of PART 1 if statement
rounding_exit1
					
					;PART	2: If(R3[4]==0 && R3[3]==1&&R3[2:0]!=0) add R3+8
					and		r6, r4, #0x10
					;Compare	to see if 5th bit is 0
					cmp		r4, #0
					;If		(R3[4] == 0)
					beq		rounding_2
					;Coming	out of PART 2 if statement
rounding_exit2
					
					;OVERFLOW	CHECK
					and		r6, r5, #0x80
					;Compare	to see if 16th bit is negative
					cmp		r6, #0x80
					;If		(R3[15]==1)
					beq		overflow
					;Coming	out of overflow if statement
overflow_end
					
					;===========Putting	values together===================
					;Exponent	value - 15 in order to figure out how many places to shift r0 for mantissa
					b		label
					
					;==============================================
					;ALL		THE ADDRESSES TO JUMP TO
					;If		(R3[3] == 1)
rounding_1
					and		r6, r4, #0x8
					cmp		r6, #0x8
					beq		rounding_1_1
					b		rounding_exit1
					
					;add		R3 + 8
rounding_1_1
					;Check	to see if value will overflow into r5
					cmp		r4, #0xF8
					bgt		local_overflow
local_overflow_exit
					add		r4, r4, #0x8
					and		r4, r4, #0xFF
					b		rounding_exit1
					
					;If		(R3[3] == 1)
rounding_2
					and		r6, r4, #0x8
					cmp		r6, #0x8
					beq		rounding_2_1
					b		rounding_exit2
					
					;If		(R3[2:0]!=0)
rounding_2_1
					and		r6, r4, #0x7
					cmp		r6, #0
					bne		rounding_2_2
					b		rounding_exit2
					
					;add		R3 + 8
rounding_2_2
					cmp		r4, #0xF8
					bgt		local_overflow2
local_overflow_exit2
					add		r4, r4, #0x8
					and		r4, r4, #0xFF
					b		rounding_exit2
					
					;If		(R3[15]==1)
overflow
					;Shift	lower 8 bit one to the right
					lsr		r4, r4, #1
					;Extract	the 1st bit of upper 8bits
					and		r6, r5, #0x1
					;Shift	it left 7 places so its in the 8th bit place
					lsl		r6, r6, #7
					;Or		it to piece it back together
					orr		r4, r4, r6
					;Shift	upper 8 bit one to the right
					lsr		r5, r5, #1
					
					;Increment	exponent value
					add		r3, r3, #1
					b		overflow_end
					
local_overflow
					add		r5, r5, #1
					b		local_overflow_exit
					
local_overflow2
					add		r5, r5, #1
					b		local_overflow_exit2
					
label				end
