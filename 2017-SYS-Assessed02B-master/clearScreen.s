   B main

test DEFB "A message to fill the screen\n",0
prompt DEFB "Press any key to clear the screen...\n",0
line DEFB "\n",0

ALIGN
main            MOV R3,#15

 mLoop          ADR R0, test
                SWI 3
                SUBS R3,R3, #1
                BNE mLoop

                ADR R0, prompt
                SWI 3
                SWI 1
                MOV R2,#0
                BL clearScreen
                SWI 2

; clearScreen : Clear the screen
; Input: none
; Output: none

clearScreen    
                MOV R0,#10
                SWI 0
                ADD R2, R2, #1
                CMP R2, #100
                B clearScreen
                MOV PC, R14

