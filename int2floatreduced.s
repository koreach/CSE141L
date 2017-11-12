mov r0, #0x06
mov r1, #0x80
and r2, r1, #0x80
mov r3, #29
mov r4, r0
and r5, r1, #0xFF
forloop
and r6, r5, #0x40
cmp r6, #0x40
beq out
lsl r5, r5, #1
and r6, r4, #0x80
lsr r6, r6, #7
orr r5, r5, r6
lsl r4, r4, #1
and r4, r4, #0xFF
sub r3, r3, #1
b forloop
out
and r6, r4, #0x10
cmp r6, #0x10
beq rounding_1
rounding_exit1
and r6, r4, #0x10
cmp r4, #0
beq rounding_2
rounding_exit2
and r6, r5, #0x80
cmp r6, #0x80
beq overflow
overflow_end
b label
rounding_1
and r6, r4, #0x8
cmp r6, #0x8
beq rounding_1_1
b rounding_exit1
rounding_1_1
cmp r4, #0xF8
bgt local_overflow
local_overflow_exit
add r4, r4, #0x8
and r4, r4, #0xFF
b rounding_exit1
rounding_2
and r6, r4, #0x8
cmp r6, #0x8
beq rounding_2_1
b rounding_exit2
rounding_2_1
and r6, r4, #0x7
cmp r6, #0
bne rounding_2_2
b rounding_exit2
rounding_2_2
cmp r4, #0xF8
bgt local_overflow2
local_overflow_exit2
add r4, r4, #0x8
and r4, r4, #0xFF
b rounding_exit2
overflow
lsr r4, r4, #1
and r6, r5, #0x1
lsl r6, r6, #7
orr r4, r4, r6
lsr r5, r5, #1
add r3, r3, #1
b overflow_end
local_overflow
add r5, r5, #1
b local_overflow_exit
local_overflow2
add r5, r5, #1
b local_overflow_exit2
label end