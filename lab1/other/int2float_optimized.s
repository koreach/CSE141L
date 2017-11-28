ldr r0, #MemoryAddressOfUpper8Bit
ldr r1, #MemoryAddressOfLower8Bit

;Isolate sign bit into r2
and	r2, r1, #0x80
;Load 29 into r3
ldr r3, #MemoryAddressOfValue29

;Copy R0[14:7]. Get rid of 8th bit. R1 still holds the same bit. 
and r0, r0, #0xF8

;FORLOOP
forloop
	;Isolate the 15th bit
	and 
