.orig x3000
LD R0 #14           ; R0 <- x4000
LDR R2, R0, #1      ; R2 is the code of working machine
AND R3, R3, #0
ADD R3, R3, #1
LDR R1, R0, #0      ; R1 is the number of the busy machine
BRz #3
ADD R3, R3, R3
ADD R1, R1, #-1
BR #-4
NOT R2, R2
NOT R3, R3
AND R2, R2, R3
NOT R2, R2
STR R2, R0, #1
HALT
.fill x4000
.end
