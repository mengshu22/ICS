.ORIG   x3000
        LEA R3, NUM1
        LEA R4, NUM2
        LEA R5, RESULT
        LDR R1, R3, #0
        LDR R2, R4, #0
        ADD R0, R1, R2
        STR R0, R5, #0
        JSR X        ;(a)
        LDR R1, R3, #1 ;(b)
        LDR R2, R4, #1 ;(c)
        ADD R1, R1, R2 ;(d)
        ADD R0, R0, R1 ;(e)
        STR R0, R5, #1 ;(f)
        TRAP x25

X       ST R4, SAVER4
        AND R0, R0, #0
        AND R4, R1, R2
        BRn LABEL      ;(g)
        ADD R1, R1, #0
        BRn ADDING     ;(h)
        ADD R2, R2, #0 ;(i)
        BRn ADDING
        BRnzp EXIT
ADDING  ADD R4, R1, R2
        BRn EXIT
LABEL   ADD R0, R0, #1
EXIT    LD R4, SAVER4
        RET

NUM1    .BLKW 2
NUM2    .BLKW 2
RESULT  .BLKW 2
SAVER4  .BLKW 1
.END