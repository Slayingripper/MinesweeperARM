        B main

; Our board:
; 0, represents an empty space
; 1-8 represents the number of bombs around us
; 66 represents there is a bomb at this location
; No more than 8 bombs
board   DEFW  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
boardMask
        DEFW -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
        ALIGN
seed    DEFW    0xC0FFEE
mult    DEFW    65539
letter  DEFW 65   

coeficient  DEFW 65539
modulus     DEFW 0x7FFFFFFF
space   DEFB " ",0
space1  DEFB "  ",0
space2  DEFB "    ",0
toprow  DEFB "     1    2    3    4    5    6    7    8",0   
star    DEFB "*",0
new DEFB "\n\n",0
prompt  DEFB "Enter square to reveal: ",0
remain  DEFB "There are ",0
remain2 DEFB " squares remaining.\n",0
already DEFB "That square has already been revealed...\n", 0
loseMsg DEFB "You stepped on a mine, you lose!\n",0
winMsg  DEFB "You successfully uncovered all the squares while avoiding all the mines...\n",0

        ALIGN
main    MOV R13, #0x10000

; Your main game code goes here
            ADR R0,prompt
            SWI3
        
        
        SWI 2



; clearScreen : Clear the screen
; Input:  none
; Output: none
clearScreen    
                MOV R0,#10
                SWI 0
                ADD R2, R2, #1
                CMP R2, #100
                B clearScreen
                MOV PC, R14
; boardSquareInput -- read board position from keyboard
; Input:  R0 ---> prompt string address
; Ouptut: R0 <--- index

boardSquareInput
ADR R0, prompt
                    SWI 3
                    SWI 1 
                    SWI 0

                    CMP R0, #65
                    BLT boardSquareInput
                    CMP R0, # 72
                    BGT boardSquareInput
                    MOV R2, R0
                    SUB R2, R2, #65 ;letter moved to R2

                    SWI 1 
                    SWI 0

                    CMP R0, #49
                    BLT boardSquareInput
                    CMP R0, #56
                    BGT boardSquareInput
                    MOV R3, R0
                    SUB R3, R3, #49 ;number moved to R3

conversion
                    MOV R1, #8
                    MUL R2, R2, R1
                    ADD R0, R2, R3

                    MOV PC,R14


; printMaskedBoard -- print the board 
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



; generateBoard
; Input R0 -- array to generate board in
generateBoard
     ; Insert your subroutine here
   MOV R5,#1
main2   
        BL randu 
        MOV R0, R0 ASR #8 ; shift R0 right by 8 bits 
        AND R0, R0, #0x3f  ; take the modulo by 64 
        MOV R2,#66
        STR R2,[R1,R0,LSL #2]
        CMP R2,R0
        BEQ ting
        ADD R5, R5, #1
        CMP R5, #9
        BNE main2
ting
        B main2    



; randu -- Generates a random number
; Input: None
; Ouptut: R0 -> Random number
randu   
        LDR R0,seed
        LDR R1,coeficient
        LDR R2,modulus
        MUL R0,R1,R0
        AND R0,R2,R0
        STR R0,seed
        MOV PC,R14
        ; Insert your subroutine here...