*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

                  ; first instruction of program

TEST
    RTS
    NOP
    
    MOVE.B      D1,     D2
    MOVE.W      #$1231, D2
    MOVE.L      A1,     D2
    MOVEA.W     (A1)+,  A2
    MOVEA.L     -(A1),  A2
    MOVEM.W     A1-A7,  -(A1)
    MOVEQ       #$0,    D0
    MOVEQ       #50,  D6
    LEA         (A1),   A2
    
    AND.B       D1,     D2
    AND.L       (A3),   D5
    AND.W       -(A2),  D1
    AND.W       #123,   D0         
    AND.L       $A000,  D2          *shows up as A000 in data
    AND.W       $0000A000, D2       *shows up as 0000A000 in data
    AND.B       (A6)+,  D0
    AND.B       D1,     (A2)
    AND.W       D2, $FFFF1234       *shows up as A000 in data, MOVE.L will take word from next opcode
    
    OR.B        D1,     D2
    OR.B        $00001234,  D6
    OR.B        $ABCD,  D7
    OR.B        D6,     $1234ABCD
    OR.B        D7,     $ABCD
    
    MOVEQ       #$CD,    D0
    MOVEQ       #50,  D6
    
    NOT.B       D0
    NOT.W       (A2)+
    NOT.L       $A000


    ADD.B       D1,     D2
    ADDA.W      D1,     A2
    ADDQ.W      #$1,    A2
    SUB.B       D1,     D2
    
    JSR         TEST
    BGT.B       TEST
    BLE.W       TEST
    BEQ.W       TEST
    BRA         TEST
    NOT         TEST
    
    LSL.B       D1,     D2
    LSR.B       D1,     D2
    ASL.B       D1,     D2
    ASR.B       D1,     D2
    ROL.B       D1,     D2
    ROR.B       D1,     D2





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
