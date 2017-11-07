@ preliminary to make ARMsim initialize memory w/ our floating pt. operand
@ Load the sign bit into R0
   MOV R0, #0x0000     @#0x8000 for negative
@ Load the exponent into R1
   MOV R1, #0x0010
   MOV R1, R1, LSL#10
@ Load the mant. fraction into R2
   MOV R2, #0x0200  
@ Load the floating point value into R0
   ADD R0, R0, R1
   ADD R0, R0, R2
@ store in memory
   MOV R4, #0x11400
   SUB R4, R4, #0x8
   STR R0, [R4]
@ now the real program  
@ load the sign bit into R1
   LDR R1, [R4]      @ hold the sign bit
   MOV R1, R1, LSR #15 @wipe out exp and mant
   MOV R1, R1, LSL #15 @keep just the sign bit
@ load the exp into R2, right-justified
   LDR R2, [R4]
   MOV R2, R2, LSR#10
   AND R2, R2, #0x1f   @mask out the sign bit
   SUB R2, R2, #0xf   @subtract bias of 15
@  load the mant fraction into R3, prepend hidden
   LDR R3, [R4]
   MOV R8, #0x400
   SUB R8, R8, #1
   AND R3, R3, R8
   ADD R3, R3, #0x400  @assumes nonzero exponent
      
@ Check for overflow
   MOV R5, #29        @ why exp>29 ==> overflow?
   SUBS R5, R5, R2
   BMI overflow
   
@ Get exponent-25
   MOV R5, #10  @since already have exp-15
   SUBS R5, R2, R5
   BMI negative   
@ Shift mantissa by exponent-25
   MOV R6, R3, LSL R5
   B  exit  
negative:
   RSB  R5, R5, #0
   MOV R6, R3, LSR R5
overflow:
@ same as for int to float 
exit:
@ append sign bit
   ADD R6, R6, R1
   ADD R4, R4, #4
   STR R6, [R4]
END
