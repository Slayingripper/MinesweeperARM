            B main
            
space       DEFW "\n",0
seed        DEFW 10
magic       DEFW 65539
mask        DEFW 0x7FFFFFFF


main    
        LDR R0,seed
        LDR R1,magic
        LDR R2,mask
        MUL R0,R1,R0
        AND R0,R2,R0
        SWI 4
        STR R0,seed
        ADR R0,space
        SWI 3
        B main