                B main

value   DEFW 0 ; Store the read number here
msg     DEFB "enter a value",0
error   DEFB "out of range",0
multiplier DEFW 16
        ALIGN
main
        mov R0, #0
        LDR R3,multiplier
        ADR R0,msg
        SWI 3
        
        B user

user    SWI 1  ;Input from user
        SWI 0   ;display his input
       
        
        CMP R0,#10      ;check if he pressess enter
        BEQ end

        MOV R1,R0
        CMP R0,#48     ;check if number is greater or equal to 48
        BLT error1

        CMP R0,#57
        BGT function2      ;check if number is less than or equal to 57


        SUB R1,R1,#48
        ;LDR R3,16
         B function1
       

        
        SWI 3
function1
         MLA R0,R1,R3,R2
         STR R0,value
         B user


error1
        ADR R0,error
        SWI 3
        SWI 2

function2
        CMP R0,#65
        BLT error1
        CMP R0,#70
        BGT error1



end     
        MOV R0,R1
        SWI 4
        SWI 2


