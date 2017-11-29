	;MSW of the first value
	mov		r0, #128
	ldr		r0, [r0]
	;LSW of the first value
	mov		r0, #129
	ldr		r1, [r0]
	;MSW of the second value
	mov		r0, #132
	ldr		r2, [r0]
	;LSW of the second value
	add		r0, #133
	ldr		r3, [r0]

	;Extract and compare sign bits
	and 	r4, r0, #0x80
	and 	r5, r2, #0x80
	;Compare the sign bits
	cmp 	r4, r5
	;We are only doing something if the sign bits are the same
	bne 	 end

	;Extract and compare exponents
	;And mask with 01111100 to extract exponents
	and		r4, r0, #0x7C
	and		r5, r2, #0x7C
	
	;Compare to see which exponent value is bigger
	cmp 	r4, r5

	;If r4 > r5 then right shift second mantissa
	bgt 	greater
	;If r5 > r4 then right shift first mantissa
	blt 	less
out	
	//Add the two mantinssas
	//Check if it is overflow
	//Rounding 

label		end
;================================================
;		All the branches that happen 
;================================================
;If r4 > r5 (from line 30) then move right the mantissa of r3 since its the smaller value
greater 
	; Currently, this is where the mantissa of r3 is stored
	; r4 - r5 = r4
	sub		r4, r4, r5
	; Restore the hidden bit
	orr 	r5, r5, #0x80
	;Counter to keep track of how many times the mantissa was moved to the right
	mov 	r5, #0
	;Counter to see if it has gone through the loop twice
	mov 	r6, #0
	;Need to do rounding
forloop
	;If r4 == r5, jump out 
	cmp 	r6, r5
	beq 	outOfForLoop
	;Includes the bits that were shifted out from the mantissa
	orr 	r8, r3, #1
	lsl		r8, r8, #1
	;Shift one bit to the right of LSW
	lsr 	r3, r3, #1
	
	;If it has gone through the loop twice, then the last two bits in MSW does not matter
	cmp 	r5, #2
	bgt 	continue
	;Bitmask out last bit of r2
	and 	r7, r2, #1
	;Shift it to the 8th bit 
	lsl		r7, r7, #7
	;Orr the r3 with r7 to account for the bit shift
	orr		r3, r7, r3
	;Shift the bit right to one
	lsr		r2, r2, #1
	;Counter++
	add		r6, r6, #1
continue
	;Counter++
	add		r6, r6, #1
	b 		forloop
outOfForLoop
	lsr		r2, r2, r6
	b  		out
;==================================================
;If  r5 > r4 (from line 33) then move right the mantissa of r1 since its the smaller value
less 	
	; r5 - r4 = r4
	sub 	r4, r5, r4
	;Counter to keep track of how many times the mantissa was moved to the right
	mov 	r5, #0
	;Counter to see if it has gone through the loop twice
	mov 	r6, #0
	;Need to do rounding
forloop
	;If r4 == r5, jump out 
	cmp 	r6, r5
	beq 	outOfForLoop
	;Includes the bits that were shifted out from the mantissa
	orr 	r8, r1, #1
	lsl		r8, r8, #1

	;Shift one bit to the right of LSW
	lsr 	r1, r1, #1
	;If it has gone through the loop twice, then the last two bits in MSW does not matter
	cmp 	r5, #2
	bgt 	continue
	;Bitmask out last bit of r0
	and 	r7, r0, #1
	;Shift it to the 8th bit 
	lsl		r7, r7, #7
	;Orr the last bit of r1 into r7
	orr		r1, r7, r1
	;Shift the bit right to one
	lsr		r0, r0, #1
	;Counter++
	add		r6, r6, #1
continue
	;Counter++
	add		r6, r6, #1
	b 			forloop
outOfForLoop
	lsr			r0, r0, r6
	b			out