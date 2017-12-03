	;MSW of the first value
	LDRI	R0, [#128]
	;LSW of the first value
	LDRI	R1, [#129]
	;MSW of the second value
	LDRI	R2, [#130]
	;LSW of the second value
	LDRI	R3, [#131]

	;Extract and compare sign bits
	ANDI 	R6, R0, #0x80
	ANDI	R7, R2, #0x80
	;We are only doing something if the sign bits are the same
	;So if not the same, then jsut get out
	BNE 	R4, R5, LABEL

	;Extract and compare exponents
	;And mask with 01111100 to extract exponents
	;First exponent
	ANDI	R4, R0, #0x7C
	;Second exponent
	ANDI	R5, R2, #0x7C

	;Extract the mantissas also
	;First mantissa
	ANDI	R0, R0, #0x3
	;Second Mantissa
	ANDI	R2, R2, #0x3
	
	;Compare to see which exponent value is bigger
	;If R4 > R5 then right shift second mantissa 
	BGT 	R4, R5, GREATER
	;If R5 > R4 then right shift first mantissa
	BLT 	R4, R5, LESS
OUT	
	;Adding the upper mantissa
	ADD 	R0, R0, R2
	;Adding the lower mantissa
	ADD 	R3, R3, R1
	;Apply Rounding

	ANDI 	R10, R3, #1
	;R8 has S, R9 has R, R10 will have LSB

	;If R == 1, then output 
	MOVI 	R11, #0
	BEQ		R11, R9, OUTPUT
	;If LSB == 1, SUM + 1
	MOVI 	R11, #1
	BEQ		R11, R10, OUTPUT_ADD 

	;If S == 1, SUM + 1
	BEQ		R11, R8, OUTPUT_ADD 

	B 		OUTPUT

;================================================
;		All the branches that happen 
;================================================
;If r4 > r5 (from line 30) then move right mantissa of second value
GREATER 
	;R5 = R4 - R5. The amount we need to shift to the right by
	SUB		R5, R4, R5
	;Shift the value two to the right to get rid of the 0's
	LSRI	R5, R5, #2
	;Restore the hidden bit into the mantissa
	ORRI	R2, R2, #0x80

	;This will contain the S value, OR of all bits right of R
	MOVI	R8, #0
	;This will contain the R value (immediately right of one's place)
	MOVI 	R9, #0
	;This will contain the comparison value for BEQ
	MOVI	R10, #0

FORLOOP_1
	;Check if the counter has reached 0
	BEQ		R10, R5, OUT_1
	;Before extracting the lower first bit into R9 (R)
	;Orr the existing R9 (R) value into R8 (S)
	ORR 	R8, R8, R9
	;Extract lower first bit into R9
	ANDI	R9, R3, #0x1
	;Extract upper first bit into R11
	ANDI 	R11, R2, #0x1
	;Shift extracted upper bit left 7 time to ORR it back together
	LSLI 	R11, R11, #7
	;Shift lower mantissa 1 to the right
	LSRI	R3, R3, #0x1
	;Shift upper mantissa 1 to the right
	LSRI	R2, R2, #0x1
	;ORR the extracted bit into the shifted mantissa
	ORR    	R2 R2, R11
	;Decrement counter
	SUBI	R5, R5, #1
	B		FORLOOP_1
OUT_1
	;Set R5 = R4 to restore the exponent value
	MOV 	R5, R4
	B 		OUT


;==================================================
;If  r5 > r4 (from line 33) then move right the mantissa of r1 since its the smaller value
LESS 
	;R4 = R5 - R4. The amount we need to shift to the right by
	SUB		R4, R5, R4
	;Shift the value two to the right to get rid of the 0's
	LSRI	R4, R4, #2
	;Restore the hidden bit into the mantissa
	ORRI	R0, R0, #0x80

	;This will contain the S value, OR of all bits right of R
	MOVI	R8, #0
	;This will contain the R value (immediately right of one's place)
	MOVI 	R9, #0
	;This will contain the comparison value for BEQ
	MOVI	R10, #0

FORLOOP_2
	;Check if the counter has reached 0
	BEQ		R10, R5, OUT_2
	;Before extracting the lower first bit into R9 (R)
	;Orr the existing R9 (R) value into R8 (S)
	ORR 	R8, R8, R9
	;Extract lower first bit into R9
	ANDI	R9, R1, #0x1
	;Extract upper first bit into R11
	ANDI 	R11, R0, #0x1
	;Shift extracted upper bit left 7 time to ORR it back together
	LSLI 	R11, R11, #7
	;Shift lower mantissa 1 to the right
	LSRI	R1, R1, #0x1
	;Shift upper mantissa 1 to the right
	LSRI	R0, R0, #0x1
	;ORR the extracted bit into the shifted mantissa
	ORR    	R0 R0, R11
	;Decrement counter
	SUBI	R4, R4, #1
	B		FORLOOP_2
OUT_2
	;Set R5 = R4 to restore the exponent value
	MOV 	R4, R5
	B 		OUT

OUTPUT
	;Put in the LSW first 
	STRI	R3, [#133]

	;ORR the signbit, exponent, and the remainder mantissa
	ORR 	R0, R0, R5
	ORR 	R0, R0, R6
	STRI	R0, [#132]
	B 		OUT

OUTPUT_ADD
	ADDI 	R3, R3, #1
	;Put in the LSW first 
	STRI	R3, [#133]

	;ORR the signbit, exponent, and the remainder mantissa
	ORR 	R0, R0, R5
	ORR 	R0, R0, R6
	STRI	R0, [#132]
	B 		OUT

LABEL
