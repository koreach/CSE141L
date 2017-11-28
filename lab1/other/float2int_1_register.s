				;Input
				MOV		R0, #0x0000
				
				;Isolate	sign bit into R1
				AND		R1, R0, #0x8000
				
				;Isolate	and load the exponent into R2
				AND		R2, R2, #0x7C00
				LSR		R2, R2, #10
				
				;Isolate	and load mantissa into R3
				AND		R3, R3, #0x3FF
				
				;If		(E != 0), prepend hidden bit onto M
				CMP		R2, #0
				BNE		prepend
				
prepend_out
				
				;Exponent	regines
				CMP		R2, #29
				;29-31
				BGE		overflow
				BLT		lower
;====================JUMP=====================
prepend
				ORR		R3, R3, #0x400
				B			prepend_out
				
				;29-31	overflow; force output 7FFF or FFFF
overflow
				CMP		R1, #0x8000
				BEQ		overflow_negative
				MOV		R4, #0x7FFF
				B			label
				
overflow_negative
				MOV		R4, #0xFFFF
				B		label
				
lower
				CMP		R2, #26
				BGE		case_1
				BLT		lower_1
				
lower_1
				CMP		R2, #25
				BEQ		case_2
				BLT		lower_2
				
lower_2
				CMP		R2, #14
				BGE		case_3
				BLT		case_4
				
				;26-28	left shift mantissa, zero fill left and right as needed
case_1
				SUB		R2, R2, #15
				LSL		R4, R3, R2
				B		label
				
				;25		copy mantissa, zero fill from left
case_2
				MOV		R4, R3
				B		label
				
				;right	shift mantissa, round
case_3
				;R2		contains how every many times to shift to the right
				SUB		R2, R2, #15
				;Check if R2 is 0 or less, so don't have to move mantissa.
				;This portion I am not too sure about... ask people when meeting for 141L
				CMP		R2, #0
				BLE		out
				
				;Extract	the first bit
				AND		R4, R3, #0x1
				;Shift the mantissa 1 to the right
				LSR		R3, R3, #0x1
				;That means R2-1 since its how many times you need to traverse
				SUB		R2, R2, #1
				CMP		R2, #0
				BEQ		out2

				;And here, you do what I did above until R2 becomes 0 
forloop
				;Extract first bit into R5
				AND		R5, R3, #0x1
				;Shift mantissa 1 to the right
				LSR		R3, R3, #0x1
				;R2-1
				SUB		R2, R2, #1
				;Shift the extracted bit and add it into the 2nd bit
				LSL		R5, R5, #1
				ADD		R4, R4, R5
				;If there is no more to shift, get out otherwise keep looping. 
				CMP		R2, #0
				BEQ		forloopout
				B		forloop
forloopout
				;If U = 1 and R = 1 add 1 to U to round
				AND		R5, R4, #0x1
				AND		R6, R3, #0x1
				CMP		R5, R6
				BEQ		out3

				;First check if U = 0
				AND		R5, R3, #0x1
				CMP		R5, #0x0
				BEQ		out4
				
				B		label
				
				;underflow/zero,	force output 0000 or 8000
case_4
				CMP		R1, #0x8000
				BEQ		overflow_negative_2
				MOV		R4, #0x0000
				B		label
				
overflow_negative_2
				MOV		R4, #0x8000
				B		label
				
copy_mantissa
				MOV		R4, R3
				B		label
				
out
				MOV		R4, R3
				B		label
				
out2
				AND		R4, R3, #0x1
				ADD		R5, R5, R4
				CMP		R5, #0x2
				BEQ		out3
				
out3
				ADD		R4, R3, #1
				B		label

;If U = 0, then check if R = 1
out4
				AND		R5, R4, #0x1
				CMP		R5, #1
				BEQ		out5
				B		label

;Check if S = 1. If it does, then add 1 to U. 
out5
				AND		R5, R4, #0xFFFE
				CMP		R5, #0
				BNE		out3
				B		label
				
label			end
