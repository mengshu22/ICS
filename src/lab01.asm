.orig x3000

; initialize all register
AND R0, R0, #0      ; R0 is ...1111...
ADD R0, R0, xF

AND R1, R1, #0      ; R1 is the number to be tested

AND R2, R2, #0      ; R2 is used to store tmp result

AND R3, R3, #0      ; use R3 to count loop time

AND R4, R4, #0      ; use R4 to store max loop time 12
ADD R4, R4, #12


LD R1, xF8


AND R2, R0, R1
; R2 = R0 - R2
NOT R2, R2
ADD R2, R2, #1
ADD R2, R2, R0

; if R2 == 0
BRz #7
; else
ADD R0, R0, R0  ; R0 <<= R0
; determine stop loop or not
ADD R3, R3, #1
; R2 = R4 - R3
NOT R2, R3
ADD R2, R2, #1
ADD R2, R2, R4
BRn #4  ; stop

BR #-12

AND R2, R2, #0
ADD R2, R2, #1
HALT

AND R2, R2, #0
HALT

.end