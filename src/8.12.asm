              .ORIG x3000
              LEA R0, FROM
              TRAP x22
              TRAP x20 ; Inputs a char without banner
              NOT R1, R0
              ADD R1, R1, #1
              LEA R0, TO
              TRAP x22
              TRAP x20
              NOT R0, R0
              ADD R0, R0, #1
              AND R5, R5, #0
              LDI R2, HEAD
SEARCH        BRz DONE
              LDR R3, R2, #0
              ADD R7, R1, R3
              BRz FOUND_FROM
              LDR R2, R2, #1
              BRnzp SEARCH
FOUND_FROM    ADD R2, R2, #2
NEXT_BRIDGE   LDR R3, R2, #0
              BRz DONE
              LDR R4, R3, #0
              ADD R7, R0, R4
              BRnp SKIP
              ADD R5, R5, #1 ; Increment Counter
SKIP          ADD R2, R2, #1
              BRnzp NEXT_BRIDGE
DONE          STI R5, ANSWER
              HALT
HEAD          .FILL x3050
ANSWER        .FILL x4500
FROM          .STRINGZ "FROM: "
TO            .STRINGZ "TO: "
              .END
;
              .ORIG x3050
              .FILL x4000
              .END
;
              .ORIG x4000
              .FILL x0041
              .FILL xA243
              .FILL xA243
              .FILL xBBBB
              .FILL x3100
              .FILL x3100
              .END
;
              .ORIG xA243
              .FILL x0042
              .FILL X4100
              .FILL x4000
              .FILL xBBBB
              .FILL x4100
              .FILL x4100
              .END
;
              .ORIG x4100
              .FILL x0043
              .FILL xBBBB
              .FILL xA243
              .FILL xA243
              .FILL xBBBB
              .END
;
              .ORIG xBBBB
              .FILL x0044
              .FILL x3100
              .FILL x3100
              .FILL x4100
              .FILL xA243
              .FILL x4000
              .END
;
              .ORIG x3100
              .FILL x0045
              .FILL x0000
              .FILL x4000
              .FILL x4000
              .FILL xBBBB
              .END