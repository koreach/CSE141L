			;Load	the input into r0
			mov		r0, #65
			;Isolate	sign bit into r1
			and		r1, r0, #0x8000
			;Set		(biased) E = 29 into R2. 29-15	= 14 bits. 15th bit already defined in sigbit.16th bit is + or -
			mov		r2, #29
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
			;Putting	values together
			
			;Exponent	value - 15 in order to figure out how many places to shift r0 for mantissa
			mov		r4, r0
			
forloop2
			;Isolate	the R3[10] bit
			and		r6, r4, #0x400
			;Compare	and see if 15th bit is 1
			cmp		r6, #0x400
			;If		(r4[10] == 1) break out of loop
			beq		out2
			;Otherwise,	left shift R3
			lsl		r4, r4, #1
			;Continue	loop
			b		forloop2
out2
			
			;15-15	is 0 so there should be no shift but here I do it anyways so...
			
			;Then	get rid of any bits that are in the 11th bit by ANDING it
			mov		r5, #0x300
			orr		r5, r5, #0xFF
			and		r4, r5, r4
			
			;Shift	exponent value 10 bits to the left
			mov		r5, r2
			lsl		r5, r5, #10
			
			;Put		all the values together
			orr		r4, r5, r4
			orr		r4, r4, r1
			
			b		label
			;==============================================
			;ALL		THE ADDRESSES TO JUMP TO
			;If		(R3[3] == 1
rounding_1
			and		r4, r3, #0x8
			cmp		r4, #0x8
			beq		rounding_1_1
			b		rounding_exit1
			
			;add		R3 + 8
rounding_1_1
			add		r3, r3, #0x8
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
			add		r3, r3, #0x8
			b		rounding_exit2
			
			;If		(R3[15]==1)
overflow
			;RIght	shift r3
			lsr		r3, r3, #1
			;Increment	r2 by 1
			add		r2, r2, #1
			b		overflow_end
			
label		end
