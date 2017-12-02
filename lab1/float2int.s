	;R0	contains the lower 8 bits
	;Memory location 2 contains least significant word of input
	LDRI	R0, [#65]
	;R1	contains the upper 8 bits
	;Memory location 1 contains most significant word of input
	LDRI	R1, [#64]
	
	;Isolate sign bit into R2
	ANDI	R2, R1, #0x80
	
	;Isolate and load the exponent into R3
	ANDI	R3, R1, #0x7C
	;Shift it twice to the right to get rid of the 0's 
	LSRI	R3, R3, #2
	
	;Isolate lower mantissa into R4
	ANDI 	R4, R0
	;Isolate upper mantissa into R5
	ANDI 	R5, R1, #0x3
	
	;If	(E != 0), prepend hidden bit onto mantissa
	MOVI	R6, #0
	BNE		R3, R6, PREPEND
	
PREPEND_OUT
	
	;EXPONENT REGIMES: This has various if statements
	;which will output upon the value of the exponent
	MOVI 	R6, #29
	;If the exponent >= 29
	BGE 	R3, R6, OVERFLOW

	;If exponent < 29, move on to next case	
	MOVI 	R6, #26
	;If the exponent < 29 && >= 26
	BGE		R3, R6, LEFT_SHIFT_MANTISSA

	;If exponent < 26, move on to next case	
	MOVI	R6, #25
	;If the exponent == 25
	BEQ		R3, R6, COPY_MANTISSA

	;If exponent < 25, move on to the next case
	MOVI	R6, #14
	;If the exponent >= 14 && exponent < 25
	BGT		R3, R6, RIGHT_SHIFT_MANTISSA

	;If exponent < 14, force output 0000 or 8000
	MOVI	R1, #0x80
	;If Sign bit == 1, then output 1000. Otherwise, output 0000
	BEQ		R2, R1, UNDERFLOW_POSITIVE

	MOVI	R4, #0x00
	MOVI 	R5, #0x00

	;Force output 0000
	STRI	R4, [#67]
	STRI	R5, [#66]

	B		LABEL
;====================JUMP=====================
	;Prepend the hidden bit into the mantissa. 
PREPEND
	;Here you are appending a 1 at the 11th bit
	ORRI	R5, R5, #0x4
	B		PREPEND_OUT
	
	;29-31 overflow; force output 7FFF or FFFF
OVERFLOW
	MOVI	R6, #0x80
	;If Sign bit == 1, then output FFFF. Otherwise, output 7FFF
	BEQ		R2, R6, OVERFLOW_POSITIVE

	MOVI	R4, #0xFF
	MOVI 	R5, #0x7F
	;Force output 7FFF
	STRI	R4, [#67]
	STRI	R5, [#66]
	B		LABEL
	
OVERFLOW_POSITIVE
	MOVI	R4, #0xFF
	MOVI	R5, #0xFF
	;Force output FFFF
	STRI	R4, [#67]
	STRI	R5, [#66]
	B		LABEL

	;26-28	left shift mantissa, zero fill left and right as needed
LEFT_SHIFT_MANTISSA
	;The amount to shift the mantissas left by
	SUBI	R3, R3, #15
	;When to stop
	MOVI 	R7, #0
FORLOOP_1
	;Check if the counter has reached 0
	BEQ		R3, R7, OUT_1
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
	;Decrement counter
	SUBI	R3, R3, #1
	;Continue	loop
	B		FORLOOP_1
OUT_1
	;Return the output
	STRI	R4, [#67]
	STRI	R5, [#66]
	B		LABEL

	;25	 copy mantissa, zero fill from left
COPY_MANTISSA
	;Just output the mantissa
	STRI	R4, [#67]
	STRI	R5, [#66]	
	B		LABEL

UNDERFLOW_NEGATIVE
	MOVI	R4, #0x10
	MOVI	R5, #0x00

	;Force output 1000
	STRI	R4, [#67]
	STRI	R5, [#66]
	B		LABEL
	
	;14-24: right shift mantissa and round
RIGHT_SHIFT_MANTISSA
	;R3	contains how every many times to shift to the right
	SUBI	R3, R3, #15
	;R6 contains the comparison value for the BEQ
	MOVI 	R6, #0
	;This will contain the S value, OR of all bits right of R
	MOVI	R9, #0
	;This will contain the R value (immediately right of one's place)
	MOVI 	R7, #0

FORLOOP_2
	;Check if the counter has reached 0
	BEQ		R3, R6, OUT_2
	;Before extracting the lower first bit into R7
	;Orr the existing R7 value into R9 (which is S)
	ORR 	R9, R9, R7
	;Extract lower first bit into R7
	ANDI	R7, R4, #0x1
	;Extract upper first bit into R8
	ANDI 	R8, R5, #0x1
	;Shift extracted upper bit left 7 time to ORR it back together
	LSLI 	R8, R8, #7
	;Shift lower mantissa 1 to the right
	LSRI	R4, R4, #0x1
	;Shift upper mantissa 1 to the right
	LSRI	R5, R5, #0x1
	;ORR the extracted bit into the shifted mantissa
	ORR    	R4, R4, R8
	;Decrement counter
	SUBI	R3, R3, #1
	B		FORLOOP_2
OUT_2

	;Get the U value. 1 if odd, 0 if even
	ANDI	R6, R4, 0x1
	;R8 contains the comparison value for the BEQ
	MOVI	R8, #1;
	;Check if U == 1
	BEQ		R6, R8, CHECK_R 
	;If U == 0, check R also.
	
	MOVI	R8, #0;
	;If R == 0, then dont round
	BEQ		R7, R8, OUTPUT
	;Else add check to see if S == 1
	MOVI	R8, #0;
	;If S == 0, then dont round
	BEQ		R9, R8, OUTPUT
	;Else add 1 to round and output
	ADDI 	R4, R4, #1
	B 		OUTPUT

CHECK_R 
	MOVI	R8, #0;
	;If R==0, then dont round
	BEQ		R7, R8, OUTPUT
	;Else add 1 to round and output
	ADDI 	R4, R4, #1
	B 		OUTPUT

OUTPUT
	STRI	R4, [#67]
	STRI	R5, [#66]
	B		LABEL
	
LABEL