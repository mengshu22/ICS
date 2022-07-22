            .ORIG x0200
            LD R6, OS_SP
            LD R0, USER_PSR
            ADD R6, R6, #-1
            STR R0, R6, #0
            LD R0, USER_PC
            ADD R6, R6, #-1
            STR R0, R6, #0
;
            ; set keyboard to interrupt enable
            LD R0, TEMP
            STI R0, KBSR
            RTI
OS_SP       .FILL x3000
USER_PSR    .FILL x0002
USER_PC     .FILL x3000
KBSR        .FILL xFE00
TEMP        .FILL x4000
            .END
;
;
;
            .ORIG x3000
            ; start of game
START       AND R1, R1, #0
LOOP        LDI R2, PCURH
            NOT R2, R2
            ADD R2, R2 #1
            ADD R2, R2, R1
            BRnp L1
            LDI R0, PSYMBOL
            OUT
            OUT
            OUT
            ADD R1, R1, #3
L1          LD R2, MAXH
            NOT R2, R2
            ADD R2, R2, #1
            ADD R2, R2, R1
            BRn L3
            LD R0, LF
            OUT
            LD R2, PAUSE
L2          ADD R2, R2, #-1
            BRp L2
            LDI R0, PCURH
            BRz START
            ADD R0, R0, #-1
            STI R0, PCURH
            BRnzp START
L3          LD R0, DOT
            OUT
            ADD R1, R1, #1
            BRnzp LOOP
;
MAXH        .FILL x0014
PAUSE       .FILL x3000
DOT         .FILL x002E
LF          .FILL x000A
PCURH       .FILL x3100
PSYMBOL     .FILL x3101
            .END
;
;
;
            .ORIG x3100
CURH        .FILL x0005
SYMBOL      .FILL x0061
            .END
;
;
;
            .ORIG x0180
            .FILL x2000
            .END
;
;
;
            .ORIG x2000
            ; save the values in registers used in interrupt
            ADD R6, R6, #-1
            STR R0, R6, #0
            ADD R6, R6, #-1
            STR R1, R6, #0
;
            LDI R0, KBDR
            LD R1, MAXNUMBER
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R1, R0
            BRp LETTER
NUM         LD R1, ZERO             ; is a number
            NOT R1, R1
            ADD R1, R1, #1
            ADD R0, R0, R1
            LDI R1, PPCURH
            ADD R1, R1, R0
            LD R0, LIMH
            NOT R0, R0
            ADD R0, R0, #1
            ADD R0, R0, R1
            BRnz INLIMIT
            LD R1, LIMH
INLIMIT     ADD R1, R1, #1
            STI R1, PPCURH
            BRnzp RETURN
LETTER      STI R0, PPSYMBOL        ; is a letter
            BRnzp RETURN
;
            ; reload the values in registers
RETURN      LDR R1, R6, #0
            ADD R6, R6, #1
            LDR R0, R0, #0
            ADD R6, R6, #1
            RTI
;
ZERO        .FILL x0030
MASK        .FILL xFF00
MAXNUMBER   .FILL x0039
KBSR2       .FILL xFE00
KBDR        .FILL xFE02
PPCURH      .FILL x3100
PPSYMBOL    .FILL x3101
LIMH        .FILL x0011
EMPTY       .FILL xFE00
            .END