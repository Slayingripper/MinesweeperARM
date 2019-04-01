        B main

; Our board 
; 0, represents an empty space
; 1-8 represents the number of bombs around us
; 66 represents there is a bomb at this location
; No more than 8 bombs

letter  DEFW 65   

space   DEFB " ",0
space1  DEFB "  ",0
space2  DEFB "    ",0
toprow  DEFB "     1    2    3    4    5    6    7    8",0   
star    DEFB "*",0
new DEFB "\n\n",0

        ALIGN

boardMask       DEFW  0,-1,-1,-1,-1, 0,-1, 0,-1,-1,-1,-1,-1,-1, 0,-1,-1,-1,-1,-1, 0,-1,-1,-1, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0,-1,-1,-1,-1, 0,-1, 0,-1,-1,-1,-1,-1,-1, 0,-1,-1,-1,-1,-1, 0,-1,-1,-1, 0, 0,-1,-1
board           DEFW  1,66, 1, 0, 0, 1,66,66, 1, 1, 1, 0, 0, 1, 3,66, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,66, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1,66, 1, 0, 0, 1, 1, 2, 2, 2, 1, 0, 0, 1,66, 2,66, 1, 0, 0, 0
main    ADR R0, board 
        ADR R1, boardMask
        BL printMaskedBoard
        SWI 2

; printMaskedBoard -- print the board with only the squares visible when boardMask contains zero
; Input: R0 <-- Address of board
;        R1 <-- Address of board Mask

printMaskedBoard

    ; Insert your implementation here
        MOV R9,R1
        MOV R1,R0
        MOV R2,#0
        MOV R6,#0
        
        
        ADRL R0,toprow
        SWI 3
        MOV R0,#10
        SWI 0
BBE     LDR R5,letter
        CMP R5,#64
        BEQ end
        CMP R5,#73
        BEQ end
        MOV R0, R5
        SWI 0
        ADD R5,R5,#1
        STR R5,letter

BBS     ADRL R0,space2
        SWI 3
        LDR R0,[R9,R2]
        CMP R0,#0
        BNE ass
        LDR R0,[R1,R2]
        
        CMP R0,#66
        BEQ mines
        CMP R0,#0
        BEQ spaces
        SWI 4
        ADD R2,R2,#4
        ADD R6,R6,#1
        CMP R6,#8
        BEQ newline
        B BBS

mines   MOV R0,#'M'
        SWI 0
        ADD R2,R2,#4
        ADD R6,R6,#1
        CMP R6,#8
        BEQ newline
        B BBS
ass 
        MOV R0,#'*'
        SWI 0
        ADD R2,R2,#4
        ADD R6,R6,#1
        CMP R6,#8
        BEQ newline
        B BBS

spaces  ADRL R0,space
        SWI 3
        ADD R2,R2,#4
        ADD R6,R6,#1
        CMP R6,#8
        BEQ newline
        B BBS

newline ADRL R0,new
        SWI 3
        MOV R6,#0
        B BBE


end        MOV PC,R14
