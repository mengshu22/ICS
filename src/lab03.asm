.ORIG       x3000
            AND R0, R0, #0    ; initialize
            LD R5, START      ; R5 is the left of the queue
            ADD R5, R5, #1    ; R5 <-- x4001
            LD R6, START      ; R6 is the right of the queue
                              ; R6 <-- x4000
                              ; Both R5 and R6 points to the
                              ; next position of the top
            LEA R4, OUTSTR    ; R4 is the address of the output string
;
INPUT       GETC
            OUT
            LD R1, PLUS
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R0, R1
            BRnp #2
            JSR LPUSH         ; input char is '+'
            BRnzp CONT
            LD R1, MINUS
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R0, R1
            BRnp #2
            JSR LPOP          ; input char is '-'
            BRnzp CONT
            LD R1, LBRACKET
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R0, R1
            BRnp #2
            JSR RPUSH         ; input char is '['
            BRnzp CONT
            LD R1, RBRACKET
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R0, R1
            BRnp #2
            JSR RPOP          ; input char is ']'
            BRnzp CONT
            LD R1, LF
            NOT R1, R1
            ADD R1, R1, #1
            ADD R1, R0, R1
            BRnp #2
            JSR OUTPUT        ; input char is '\n'
            HALT
CONT        BRnzp INPUT       ; get next char
;
LPUSH       LD R0, LLIMIT
            NOT R0, R0
            ADD R0, R0, #1
            ADD R0, R0, R5
            BRz FULL
            GETC
            OUT
            STR R0, R5, #0   ; store the value
            ADD R5, R5, #1   ; and update the left pointer
            RET
;
LPOP        NOT R0, R6
            ADD R0, R0, #1
            ADD R0, R0, R5
            ADD R0, R0, #-1
            BRz EMPTY
            ADD R5, R5, #-1  ; update the left pointer
            LDR R0, R5, #0
            STR R0, R4, #0   ; store the value to the string to be output
            ADD R4, R4, #1
            RET
;
RPUSH       LD R0, RLIMIT
            NOT R0, R0
            ADD R0, R0, #1
            ADD R0, R0, R6
            BRz FULL
            GETC
            OUT
            STR R0, R6, #0   ; store the value
            ADD R6, R6, #-1  ; and update the left pointer
            RET
;
RPOP        NOT R0, R6
            ADD R0, R0, #1
            ADD R0, R0, R5
            ADD R0, R0, #-1
            BRz EMPTY
            ADD R6, R6, #1   ; update the right pointer
            LDR R0, R6, #0
            STR R0, R4, #0   ; store the value to the string to be output
            ADD R4, R4, #1
            RET
;
OUTPUT      LEA R0, OUTSTR
            PUTS
            RET
;
FULL        LEA R1, OVERFLOW
            AND R0, R0, #0
            ADD R0, R0, R1
            PUTS
            HALT
;
EMPTY       LD R0, UNDERLINE
            STR R0, R4, #0
            ADD R4, R4, #1
            RET
;
PLUS        .FILL x002B
MINUS       .FILL x002D
LBRACKET    .FILL x005B
RBRACKET    .FILL x005D
LF          .FILL x000A
UNDERLINE   .FILL x005F
START       .FILL x4000
RLIMIT      .FILL x4100
LLIMIT      .FILL x3E00
OVERFLOW    .STRINGZ "ERROR!OVERFLOW!"
OUTSTR      .BLKW x0200
            .END