;Load	I into R0... or whatever memory address.
			mov		r0, #40
			;Isolate	sign bit into r1
			and		r1, r0, #0x8000
;Set (biased) E = 29 into R2. 29-15	= 14 bits. 15th bit already defined in sigbit.16th bit is + or -				mov		r2, #29
			;Copy	R3[14:0]=I[14:0] by using a bitmask of 0x7FFF
			mov		r3, #0x7F00
			orr		r3, r3, #0xFF
			and		r3, r3, r0	
			;FOR		LOOP
forloop
			;Isolate	the R3[14] bit
			and		r4, r3, #0x4000
			;Compare	and see if 15th bit is 1
			cmp		r4, #0x4000
			;If		(r4[14] == 1) break out of loop
			beq		out
			;Otherwise,	left shift R3 and decrement R2
			lsl		r3, r3, #1
						sub		r2, r2, #1
			;Continue	loop
			b		forloop		
out
			;ROUNDING
			;PART	1: If(R3[4]==1 && R3[3]==1) add R3+8
			and		r4, r3, #0x10
			;Compare	and see if 5th bit is 1
			cmp		r4, #0x10
			;If		(R3[4] == 1)
			beq		rounding_1
			;Coming	out of PART 1 if statement
rounding_exit1
			;PART	2: If(R3[4]==0 && R3[3]==1&&R3[2:0]!=0) add R3+8
			and		r4, r3, #0x10
			;Compare	to see if 5th bit is 0
			cmp		r4, #0
			;If		(R3[4] == 0)
			beq		rounding_2
			;Coming	out of PART 2 if statement
rounding_exit2
			;OVERFLOW	CHECK
			and		r4, r3, #0x8000
			;Compare	to see if 16th bit is negative
			cmp		r4, #0x8000
			;If		(R3[15]==1)
			beq		overflow
			;Coming	out of overflow if statement
overflow_end
			;lsl		r2, r2, #10
			;orr		r2,	 r2, r1
			
			;mov		r4, #28
			;sub		r2, r4, r2
			;mov		r4, #1
			;lsl		r2, r4, r2
			;orr		r2,	 r2, r3
			b		label			
;==============================================
			;ALL		THE ADDRESSES TO JUMP TO
			;If		(R3[3] == 1)
rounding_1
			and		r4, r3, #0x8
			cmp		r4, #0x8
			beq		rounding_1_1
			b		rounding_exit1
			;add		R3 + 8
rounding_1_1
			add		r3, r3, #8
			b		rounding_exit1
			;If		(R3[3] == 1)
rounding_2
			and		r4, r3, #0x8
			cmp		r4, #0x8
			beq		rounding_2_1
			b		rounding_exit2
			;If		(R3[2:0]!=0)
rounding_2_1
			and		r4, r3, #0x7
			cmp		r4, #0
			bne		rounding_2_2
			b		rounding_exit2
			;add		R3 + 8
rounding_2_2
			add		r3, r3, #8
			b		rounding_exit2
			;If		(R3[15]==1)
overflow
			;RIght	shift r3
			lsr		r3, r3, #1
			;Increment	r2 by 1
			add		r2, r2, #1
			b		overflow_end
label		end



