.orig x3000

; initialize all register
NOT R7, R0      ; R0 is ...1111...
ADD R0, R0, R7
NOT R0, R0
ADD R0, R0, xF

NOT R7, R1      ; R1 is the number to be tested
ADD R1, R1, R7
NOT R1, R1

NOT R7, R2      ; R2 is used to store tmp result
ADD R2, R2, R7
NOT R2, R2

NOT R7, R3      ; use R3 to count loop time
ADD R3, R3, R7
NOT R3, R3

NOT R7, R4      ; use R4 to store max loop time 12
ADD R4, R4, R7
NOT R4, R4
ADD R4, R4, #12


LD R1, xEE


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
BRn #3  ; stop

BR #-12

ADD R2, R2, #1
HALT

NOT R7, R2
ADD R2, R2, R7
NOT R2, R2
HALT

.end