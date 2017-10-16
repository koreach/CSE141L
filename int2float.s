@This is where the data segment starts
.data
x:	.short -42 


@This is where the code (.text) segment starts
.text
_start:
	@Move memory address of x into of r0
	ldr r0, =x 
	@Transfer them values into the 3 registers
	ldr r1, [r0]
	ldr r2, [r0]
	mov r0, r2

	@These values are all obtained by using an AND mask 
	@r0 is to determine if it is negative or positive
	and r0, $0x8000
	@r1 is the exponent bit
	and r1, $0x7C00
	@r2 is the significant digit precision values
	@lsl r2, #6
	@and r2, $0x1FFC0
end:



