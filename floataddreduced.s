mov r0, #128
ldr r0, r0
mov r0, #129
ldr r1, r0
mov r0, #132
ldr r2, r0
add r0, #133
ldr r3, r0
and r4, r0, #0x7C
lsr r4, r4, #2
and r5, r2, #0x7C
lsr r5, r5, #2
cmp r4, r5
bge greater
blt less
out 
and r4, r0, #0x80
and r5, r2, #0x80
cmp r4, r5
beq overflow_check
bge negative
ble positive
cmp r1, r3
beq r1
greater 
sub r4, r4, r5
mov r5, #0
mov r6, #0
forloop
cmp r6, r5
beq outOfForLoop
orr r8, r3, #1
lsl r8, r8, #1
lsr r3, r3, #1
cmp r5, #2
bgt continue
and r7, r2, #1
lsl r7, r7, #7
orr r3, r7, r3
lsr r2, r2, #1
add r6, r6, #1
continue
add r6, r6, #1
b forloop
outOfForLoop
lsr r2, r2, r6
b out
less  
sub r4, r5, r4
mov r5, #0
mov r6, #0
forloop
cmp r6, r5
beq outOfForLoop
orr r8, r1, #1
lsl r8, r8, #1
lsr r1, r1, #1
cmp r5, #2
bgt continue
and r7, r0, #1
lsl r7, r7, #7
orr r1, r7, r1
lsr r0, r0, #1
add r6, r6, #1
continue
add r6, r6, #1
b forloop
outOfForLoop
lsr r0, r0, r6
b out
overflow_check
b round_up
negative
cmp r1, r3
bge addition_1
ble subtract_1
positive
cmp r1, r3
bge subtract_2
ble addition_2
addition_1
add r1, r1, r3
b end
subtract_1
sub r1, r3 , r1
b end 
subtract_2
sub r1, r1, r3
b end
addition_2
add r1, r3, r1
b end
label end