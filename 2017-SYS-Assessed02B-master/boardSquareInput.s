B main

prompt DEFB "Enter square to reveal: ",0
mesg DEFB "YOu entered the index ",0
line DEFB "\n",0

        ALIGN
main                
                    BL boardSquareInput

                    MOV R1, R0
                    ADR R0, line
                    SWI 3
                    ADR R0, mesg
                    SWI 3
                    MOV R0,R1
                    SWI 4
                    MOV R0,#10
                    SWI 0
                    SWI 2

; boardSquareInput -- read board position from keyboard
; Input: R0 ---> prompt string address
; Ouptut: R0

boardSquareInput    ADR R0, prompt
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

;i dont even know whats going on 