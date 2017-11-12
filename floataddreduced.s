	mov		r0, #128
	ldr		r0, r0
	mov		r0, #129
	ldr		r1, r0
	mov		r0, #132
	ldr		r2, r0
	add		r0, #133
	ldr		r3, r0
	and		r4, r0, #0x7C
	lsr		r4, r4, #2
	and		r5, r2, #0x7C
	lsr			r5, r5, #2
	cmp 		r4, r5
	bge 		greater
	blt 		less
out	
	and 		r4, r0, #0x80
	and 		r5, r2, #0x80
	cmp 		r4, r5
	beq 	 	overflow_check
	bge 		negative
	ble 		positive
	cmp 		r1, r3
	beq			r1
greater 
	sub		r4, r4, r5
	;Counter to keep track of how many times the mantissa was moved to the right
	mov 		r5, #0
	;Counter to see if it has gone through the loop twice
	mov 		r6, #0
	;Need to do rounding
forloop
	;If r4 == r5, jump out 
	cmp 		r6, r5
	beq 		outOfForLoop
	;Includes the bits that were shifted out from the mantissa
	orr 		r8, r3, #1
	lsl			r8, r8, #1
	;Shift one bit to the right of LSW
	lsr 		r3, r3, #1
	
	;If it has gone through the loop twice, then the last two bits in MSW does not matter
	cmp 		r5, #2
	bgt 		continue
	;Bitmask out last bit of r2
	and 		r7, r2, #1
	;Shift it to the 8th bit 
	lsl			r7, r7, #7
	;Orr the r3 with r7 to account for the bit shift
	orr		r3, r7, r3
	;Shift the bit right to one
	lsr			r2, r2, #1
	;Counter++
	add		r6, r6, #1
continue
	;Counter++
	add		r6, r6, #1
	b 			forloop
outOfForLoop
	lsr			r2, r2, r6
	b  			out
;==================================================
;If  r5 > r4 (from line 33) then move right the mantissa of r1 since its the smaller value
less 	
	; r5 - r4 = r4
	sub 		r4, r5, r4
	;Counter to keep track of how many times the mantissa was moved to the right
	mov 		r5, #0
	;Counter to see if it has gone through the loop twice
	mov 		r6, #0
	;Need to do rounding
forloop
	;If r4 == r5, jump out 
	cmp 		r6, r5
	beq 		outOfForLoop
	;Includes the bits that were shifted out from the mantissa
	orr 		r8, r1, #1
	lsl			r8, r8, #1

	;Shift one bit to the right of LSW
	lsr 		r1, r1, #1
	;If it has gone through the loop twice, then the last two bits in MSW does not matter
	cmp 		r5, #2
	bgt 		continue
	;Bitmask out last bit of r0
	and 		r7, r0, #1
	;Shift it to the 8th bit 
	lsl			r7, r7, #7
	;Orr the last bit of r1 into r7
	orr		r1, r7, r1
	;Shift the bit right to one
	lsr			r0, r0, #1
	;Counter++
	add		r6, r6, #1
continue
	;Counter++
	add		r6, r6, #1
	b 			forloop
outOfForLoop
	lsr			r0, r0, r6
	b			out
;==================================
overflow_check
	;Check exponent to see if one is 11110 if so
	;Add the mantissas together and see if it overflows...
	b			round_up
;first value is positive
negative
	;compare mantissa
	cmp 		r1, r3
	bge		addition_1
	ble		subtract_1
;second value is positive
positive
	;compare mantissa
	cmp 		r1, r3
	bge			subtract_2
	ble 		addition_2
addition_1
	add		r1, r1, r3
	b			end
subtract_1
	sub		r1, r3	, r1
	b			end	
subtract_2
	sub		r1, r1, r3
	b			end
addition_2
	add		r1, r3, r1
	b			end
label		end