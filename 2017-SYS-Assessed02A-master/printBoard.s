
 B main

; Our board 
; 0, represents an empty space
; 1-8 represents the number of bombs around us
; 66 represents there is a bomb at this location
; No more than 8 bombs
letter  DEFW 65   
board   DEFW  1,66, 1, 0, 0, 1,66,66, 1, 1, 1, 0, 0, 1, 3,66, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1,66, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1,66, 1, 0, 0, 1, 1, 2, 2, 2, 1, 0, 0, 1,66, 2,66, 1, 0, 0, 0
space   DEFB " ",0
space1  DEFB "  ",0
space2  DEFB "    ",0
toprow  DEFB "     1    2    3    4    5    6    7    8",0   
                         
new DEFB "\n\n",0
numbers DEFW 1,2,3,4,5,6,7,8

        ALIGN
main    ADR R0, board 
        MOV R1,R0
        BL printBoard

        SWI 2

; printBoard -- print the board 
; Input: R0 <-- Address of board
        
printBoard
    ; Insert your implementation here
        MOV R1,R0
        MOV R2,#0
        MOV R6,#0
        
        
        ADR R0,toprow
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

BBS     ADR R0,space2
        SWI 3
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

spaces  ADR R0,space
        SWI 3
        ADD R2,R2,#4
        ADD R6,R6,#1
        CMP R6,#8
        BEQ newline
        B BBS

newline ADR R0,new
        SWI 3
        MOV R6,#0
        B BBE


end        MOV PC,R14
