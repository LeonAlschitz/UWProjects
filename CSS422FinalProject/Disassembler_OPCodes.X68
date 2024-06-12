*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------


*------Use D3 to store original data
*------Use D4 to copy and modify D3 data
*------Use D6 as a boolean to know wether we have printed or not

*------Jump to different Isolate methods
*------keep returning and jumping untill you find the correct Method
*------Print out OPCode message, and then return to main loop
CHECK_OPCODES:
        CLR.L   D6

        JSR     ISOLATE_16
        CMP.B   #$1,    D6
        BEQ     RETURN
        
        JSR     ISOLATE_15_6
        CMP.B   #$1,    D6
        BEQ     RETURN

        JSR     ISOLATE_15_8
        CMP.B   #$1,    D6
        BEQ     RETURN
        
        JSR     ISOLATE_15_11
        CMP.B   #$1,    D6
        BEQ     RETURN
        
        JSR     ISOLATE_15_12
        CMP.B   #$1,    D6
        BEQ     RETURN
        
        JSR     ISOLATE_8_6
        CMP.B   #$1,    D6        
        BEQ     RETURN
        
        JSR     ISOLATE_15_14    
        CMP.B   #$1,    D6
        BEQ     RETURN
        

        RTS
RETURN:
        RTS

ISOLATE_15_12:
        MOVE.W      D3,     D4
        MOVE.W      #12,     D2
        LSR.W       D2,     D4
        
        CMP.B       #$D,   D4
        BEQ         OP_CODE_ADD
       ;CMP.W       #$D,   D4
       ;BEQ         OP_CODE_ADDA
        CMP.B       #$5,   D4
        BEQ         OP_CODE_ADDQ
        CMP.B       #$9,   D4
        BEQ         OP_CODE_SUB
        
        CMP.B       #$7,    D4
        BEQ         OP_CODE_MOVEQ
        CMP.B       #$8,    D4
        BEQ         OP_CODE_OR      *may get confused with DIVU + any other opcodes that start with 1000 (ones that we are not required to cover)
        CMP.B       #$C,    D4
        BEQ         OP_CODE_AND

        RTS
        
ISOLATE_16:

        CMP.W       #$4E71, D3
        BEQ         OP_CODE_NOP
        CMP.W       #$4E75, D3
        BEQ         OP_CODE_RTS

        RTS

ISOLATE_15_6:
        
        MOVE.W      D3,     D4
        MOVE.W      #6,     D2
        LSR.W       D2,     D4
        
        CMP.W       #$13A,  D4
        BEQ         OP_CODE_JSR
        
        RTS

ISOLATE_15_8:
        MOVE.W      D3,     D4
        MOVE.W      #8,     D2
        LSR.W       D2,     D4
        
        CMP.B       #$46,   D4
        BEQ         OP_CODE_NOT
        CMP.B       #$60,   D4
        BEQ         OP_CODE_BRA

        RTS
        
ISOLATE_15_11:
        MOVE.W      D3,     D4
        MOVE.W      #11,    D2
        LSR.W       D2,     D4
        
        CMP.B       #$9,    D4
        BEQ         OP_CODE_MOVEM
        
        RTS
        
ISOLATE_15_14:
        MOVE.W      D3,     D4
        MOVE.W      #14,    D2
        LSR.W       D2,     D4
        
        CMP.B       #$0,    D4
        BEQ         OP_CODE_MOVE
        
        RTS
        
ISOLATE_8_6:
        MOVE.W      D3,     D4
        MOVE.W      #7,     D2
        LSL.W       D2,     D4
        MOVE.W      #13,    D2
        LSR.W       D2,     D4
        
        CMP.B       #$1,    D4
        BEQ         OP_CODE_MOVEA
        CMP.B       #$7,    D4
        BEQ         OP_CODE_LEA

        RTS



*----------------
OP_CODE_NOT:
        LEA         NOT_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         SIZE_7_6
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        MOVE.B      #1,      D6
        
        RTS 
OP_CODE_BRA:
        LEA         BRA_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        *MOVE.W      (A3)+,   D7
        
        RTS
        
OP_CODE_LEA:
        LEA         LEA_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15

        MOVE.B      #1,      D6

        RTS        
*-----------------
OP_CODE_MOVE:

        LEA         MOVE_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         SIZE_13_12
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         DESTINATION_11_6

        MOVE.B      #1,      D6

        RTS
        
OP_CODE_MOVEA:
        LEA         MOVEA_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         SIZE_13_12
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         DESTINATION_11_6

        MOVE.B      #1,      D6

        RTS

OP_CODE_MOVEM:
        LEA         MOVEM_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         SIZE_6
        
        MOVE.W      D3,     D4
        
        MOVE.W      #5,     D2
        LSL.W       D2,     D4
        MOVE.W      #15,    D2
        LSR.W       D2,     D4
        
        CMP.B       #$0,    D4
        BEQ         REG_TO_MEM
        CMP.B       #$1,    D4
        BEQ         MEM_TO_REG
        
        RTS

REG_TO_MEM:

        MOVE.W      D3,     D4
        LEA         WHITESPACE, A1
        MOVE.B      #14,    D0
        TRAP        #15
        MOVE.W      #10,    D2
        LSL.W       D2,     D4
        MOVE.W      #13,    D2
        LSR.W       D2,     D4
        MOVEA.L     A3,     A5

        CLR.L       D0
        CLR.L       D1
        MOVE.W      #$FF,   D1
        CLR.L       D6
        MOVE.W      #$FF,   D6
        CLR.L       D0
        CMP.B       #$4,    D4
        BEQ         RTM_1_B
        
        MOVE.B      #$F,   D0
        BRA         RTM_1_A
 
        

RTM_1_A:
        MOVE.W      (A5)+,   D4    
        JSR         POST_INCR_MASK_FIELD
        BRA         RTM_2
RTM_1_B: 
        MOVE.W      (A5)+,   D4   
        JSR         PRE_DECR_MASK_FIELD
        BRA         RTM_2
RTM_2:

        LEA         WHITESPACE_COM, A1
        MOVE.B      #14,    D0
        TRAP        #15

        SUB.W       #4,     A5
        MOVE.W      (A5)+,  D3
        JSR         EFFECTIVEADD_5_0
        CLR.L       D6
        MOVE.W      (A3)+,  D3
        MOVE.B      #1,     D6
        RTS
    
    
MEM_TO_REG:

        MOVE.W      D3,     D4
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15

        MOVE.W      D3,     D4
        MOVE.W      #10,    D2
        LSL.W       D2,     D4
        MOVE.W      #13,    D2
        LSR.W       D2,     D4
        CLR.L       D0
        CLR.L       D1
        MOVE.W      #$FF,   D1
        CLR.L       D6
        MOVE.W      #$FF,   D6
        
        CLR.L       D0
        CMP.B       #$4,    D4
        BEQ         MTR_1_B
        
        MOVE.B      #$F,   D0

        BRA         MTR_1_A
        


MTR_1_A: 
        MOVE.W      (A3)+,  D4   
        JSR         POST_INCR_MASK_FIELD
        CLR.L       D6
        MOVE.B      #1,     D6
        RTS
MTR_1_B:
        MOVE.W      (A3)+,  D4    
        JSR         PRE_DECR_MASK_FIELD
        CLR.L       D6
        MOVE.B      #1,     D6
        RTS

*------------------------
OP_CODE_ADD:
        LEA         ADD_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_ADDA:
        LEA         ADDA_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_ADDQ:
        LEA         ADDQ_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS

OP_CODE_SUB:
        LEA         SUB_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS
        
*------------------------        
OP_CODE_RTS:
        LEA         RTS_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_NOP:
        LEA         NOP_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        MOVE.B      #1,      D6
        
        RTS
        
*------------------------  
OP_CODE_MOVEQ:
        *NOTE MOVEQ has static bit at index 8
        LEA         MOVEQ_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         IMM_DATA, A1
        MOVE.B      #14, D0
        TRAP        #15

        LEA         HEX, A1
        MOVE.B      #14, D0
        TRAP        #15
       
        JSR         DATA_7_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         DATA_REG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         REGISTER_11_9
        
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_AND:
        LEA         AND_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        *check opmode
        *if starts with 1 do Dn ^ <ea> -> <ea>
        *OPMODE_8_6 will appent size next to opcode
        JSR         OPMODE_8_6
        ROL.W       #1, D4
        BCS         OP_CODE_AND2
        *else...
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        *check ea and print
        JSR         EFFECTIVEADD_5_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        *print out data reg
        
        LEA         DATA_REG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         REGISTER_11_9
        
        
        MOVE.B      #1,      D6
        
        RTS

OP_CODE_AND2:
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         DATA_REG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         REGISTER_11_9
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        MOVE.B      #1,      D6
        
        RTS
OP_CODE_OR:
        LEA         OR_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         OPMODE_8_6
        ROL.W       #1, D4
        BCS         OP_CODE_OR2
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         DATA_REG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         REGISTER_11_9
            
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_OR2:
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         DATA_REG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         REGISTER_11_9
        
        LEA         WHITESPACE_COM, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        MOVE.B      #1,      D6
        
        RTS
        
OP_CODE_JSR:
        LEA         JSR_MSG, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        LEA         WHITESPACE, A1
        MOVE.B      #14, D0
        TRAP        #15
        
        JSR         EFFECTIVEADD_5_0
        
        MOVE.B      #1,      D6
        
        RTS



*DATA_MSG:   DC.B    'DATA',0





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
