.orig x3000
; initialize
AND R0, R0, #0   
AND R4, R4, #0    
AND R5, R5, #0   
AND R6, R6, #0   

LD R1, ZERO
NOT R1, R1
ADD R1, R1, #1   ; R1 <- -'0'

LD R2, RETURN
NOT R2, R2
ADD R2, R2, #1   ; R2 <- -'\r'

AND R3, R3, #0   ; R3 is the decimal form of the number

INPUT GETC       ; R0 <- inputchar
OUT
ADD R6, R0, R2   ; test R0 ?= '\r'
BRz CONVERT
ADD R0, R0, R1
JSR MUL
BR INPUT

MUL AND R6, R6, #0
ADD R6, R6, #10
AND R5, R5, #0
ADD R5, R5, R3
AND R3, R3, #0
ADD R3, R3, R5       ; R3 <- R3 * 10
ADD R6, R6, #-1
BRp #-3
ADD R3, R3, R0       ; R3 <- R3 + R0
RET

CONVERT ADD R6, R6, #4
BR OUTPUT
CONT ADD R3, R3, R3
ADD R3, R3, R3
ADD R3, R3, R3
ADD R3, R3, R3
ADD R6, R6, #-1
BRp #-7
HALT

; get hexadecimal digit of the current highest 4-bit of R3
; the result is stored in R5
GETHEX LD R1, A
AND R2, R2, #0
ADD R2, R2, #1
AND R5, R5, #0
AND R4, R4, #0
AND R4, R1, R3
BRz #5
NOT R2, R2
NOT R5, R5
AND R5, R5, R2
NOT R5, R5
NOT R2, R2
ADD R2, R2, R2
ADD R1, R1, R1
BRz #1
BR #-12
RET

OUTPUT JSR GETHEX
ADD R5, R5, #-10
BRzp #4
LD R0, ZERO
ADD R0, R0, R5
ADD R0, R0, #10
BR #2
LD R0, CAPA
ADD R0, R0, R5
OUT
BR CONT

RETURN .fill x000A     ; ASCII code of ENTER
ZERO .fill x0030       ; ASCII code of '0'
CAPA .fill x0041  ; ASCII code of 'A'
LOWX .fill x0078    ; ASCII code of 'x'
A .fill x1000
.end