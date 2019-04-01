            B main

x           DEFW  5                             ;The number to calculate the factorial of
firstmsg    DEFB  "INSERT VALUE\n",0
ansmsg1     DEFB  "The factorial of ",0
ansmsg2     DEFB  " is ",0
ansmsg3     DEFB  ".\n",0
        
        
        ALIGN



            
main    LDR R3,x                       ; x=5
        MOV R1, #1                     ;R1 ZI COUNTER
        MOV R2, #1                    ;R2 THE factorial




fact   MUL R2,R1,R2                     ; factorial = factorial * counter
       ADR R0,ansmsg1
        SWI 3
        MOV R0,R1
        SWI 4
        ADR R0,ansmsg2
        SWI 3
        MOV R0,R2
        SWI 4
        ADR R0,ansmsg3
        SWI 3
        
       ADD R1,R1,#1                     ; ADD 1 TO THE COUNTER
       
       CMP R1,R3                        ;if r1=5 then END
       BLE fact
       


done    
        SWI 2
