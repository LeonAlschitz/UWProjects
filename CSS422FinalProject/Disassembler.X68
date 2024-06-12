*-----------------------------------------------------------
* Title      :Disassembler
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

        BRA     INTRO_MSGS

* Put program code here

*------LEA = Load effective address
*------Running Trap #15 while the number 14 is in D0 will print out whatever data is in the address stored in A1

INTRO_MSGS:
        CLR.L       D0
        CLR.L       D1
        CLR.L       D2
        CLR.L       D3
        CLR.L       D4
        CLR.L       D5
        CLR.L       D6
        CLR.L       D7



        LEA         INTRO_MSG,      A1
        MOVE.B      #14,            D0    
        TRAP        #15
        
        LEA         STARTING_MSG,   A1
        MOVE.B      #14,            D0   
        TRAP        #15
        
*----------------- 
*       Running trap command 15 while the number 2 is in D0 
*       Will ask the user to enter input
*       after the user hits enter, the length of the input is stored in D1
*       and the user data is stored in the space allocated by STA_ADDR repressented by ASSCI code
*       IE 31 = 1, 32 = 2 etc etc
*       If I store the number 1200, it will appear in memory as 31 32 30 30

        LEA         STA_ADDR,       A1
        MOVE.B      #2,             D0
        TRAP        #15
        
        JSR         CONVERT_TO_ASCII
        
        * A3 now has our Starting Address
        MOVEA.L     D7,             A3
        
        CLR.L       D2
        CLR.L       D7
        
        LEA         ENDING_MSG,     A1
        MOVE.B      #14,            D0
        TRAP        #15
        
        LEA         END_ADDR,       A1
        MOVE.B      #2,             D0
        TRAP        #15
        
        JSR         CONVERT_TO_ASCII
        * A4 now has our Ending Address
        MOVEA.L     D7,             A4
        

        JSR         PRINT_MEMORY_LOOP
        
        
        
        *BRA         DONE
        *   ASCII conversion
*---------------------------------------        
CONVERT_TO_ASCII:             
        CMPI.B      #$0,            D1
        BEQ         ASCII_DONE
        MOVE.B      (A1)+,          D2
        MOVE.B      #$39,           D0
        CMP.B       D0,             D2
        BLE         NUMBER_ASCII   
        BRA         LETTER_ASCII  

ASCII_DONE:
        RTS
        
NUMBER_ASCII:
        SUBI.B      #$1,            D1
        MOVE.B      #$30,           D0
        SUB.B       D0,             D2
        ADD.B       D2,             D7
        CMPI.B      #$0,            D1
        BEQ         ASCII_DONE
        ASL.L       #4,             D7
        BRA         CONVERT_TO_ASCII
LETTER_ASCII:
        SUBI.B      #$1,            D1
        MOVE.B      #$37,           D0
        SUB.B       D0,             D2
        ADD.B       D2,             D7
        CMPI.B      #$0,            D1
        BEQ         ASCII_DONE
        ASL.L       #4,             D7
        BRA         CONVERT_TO_ASCII
*---------------------------------------        
        
        
        *   Printing data and addresses
*---------------------------------------

PRINT_MEMORY_LOOP:
        * add code here to compare current address with end address
        
        * if equal to, or further than ending address jump to DONE
        * SIMHALT
        CMP.L       A3,             A4
        BLE         RESTART
        
        * We are goiong to keep track of the number of byts we have examined using D1
        * Before printing the address we have to reverse the order
        CLR.L       D1
        CLR.L       D2
        MOVE.B      #$8,            D1
        MOVE.L      A3,             D3
        JSR         REVERSE_START
        
        MOVE.L      D7,             D3
        CLR.L       D1
        CLR.L       D2
        MOVE.B      #$8,            D1
        JSR         PRINT_LOOP
        
        
        * space between address and data
        LEA         SPACE_MSG,      A1
        MOVE.B      #14,            D0    
        TRAP        #15
        
        CLR.L       D1
        CLR.L       D2
        MOVE.B      #$8,            D1
        MOVE.W      (A3)+,          D3
        *JSR         REVERSE_START
        
        *MOVE.L      D7,             D3
        CLR.L       D1
        CLR.L       D2
        *MOVE.B      #$8,            D1
        *JSR         PRINT_LOOP
        
        * Jump to Function in another file
        JSR         CHECK_OPCODES
        
        
        CLR.L       D1
        CLR.L       D2
        CLR.L       D3
        CLR.L       D4
        * new line
        LEA         NEW_LINE,       A1
        MOVE.B      #14,            D0    
        TRAP        #15

        * branch to the start of this method
        BRA         PRINT_MEMORY_LOOP


PRINT_LOOP:

        
        * When D1 == 0, we are done and exit this loop
        CMPI.B      #$0,            D1
        BEQ         PRINT_DONE
        SUBI.B      #$1,            D1
        
        MOVE.B      D3,             D2
        * Bit shifting to isolate the right most digit
        * 1234 5678 => 8000 0000 => 0000 0008
        MOVE.B      #28,            D0    
        LSL.L       D0,             D2     
        ROL.L       #4,             D2 
        
        * Bit shifting to prep the next digit
        * 1234 4567 => 0123 4567
        ASR.L       #4, D3
        
        *Assuming D4 is empty
        
        MOVE.B       D2,            D4
        LEA          ZERO_MSG,      A1
        * load the address of Zero_msg
        * because all of the msgs are stored next to each other in order
        * we can simply take the value isolated from the number, multiply it by 2 (msg's take up 2 bytes)
        * and then add it to the address starting at zero_msg
        MULU         #2,            D4
        ADDA.L       D4,            A1
        
        * trap command 14 reads whatever address is in A1, and then spits out the data to the console
        MOVE.B       #14,           D0
        TRAP         #15
        BRA          PRINT_LOOP
        NOT          D4
        
PRINT_DONE:
        RTS
        
    *   Reversing the address
*---------------------------------------

REVERSE_START:        
        CLR.L       D1
        CLR.L       D7
        MOVE.B      #8,             D1
        JSR         REVERSE_LOOP
        RTS
        
REVERSE_LOOP:

        
        CMPI.B      #$0,            D1
        BEQ         REVERSE_DONE
        SUBI.B      #$1,            D1
        ASL.L       #4,             D7
        
        CLR.L       D5
        
        MOVE.B      D3,             D5
        
        MOVE.B      #28,            D0    
        LSL.L       D0,             D5     
        ROL.L       #4,             D5
        
        ADD.B       D5,             D7
        
        
        ASR.L       #4,             D3
        
        BRA         REVERSE_LOOP

REVERSE_DONE:
        RTS

RESTART:
        LEA         DONE_MSG,       A1
        MOVE.B      #14,            D0
        TRAP        #15
        LEA         RESTART_MSG,    A1
        MOVE.B      #14,            D0
        TRAP        #15
        MOVE.B      #2,             D0
        TRAP        #15
        


        BRA         DONE
DONE:

        LEA         TY_MSG,         A1
        MOVE.B      #14,            D0
        TRAP        #15
        MOVE.B      #9,             D0
        TRAP        #15        
        

    *SIMHALT             ; halt simulator

    INCLUDE         'Disassembler_OPCodes.x68'
    INCLUDE         'Disassembler_EA.x68'
    INCLUDE         'Disassembler_Msgs.x68'
    *INCLUDE         'Sample_Test.x68'
    INCLUDE         'demo_test.x68'




    END    START        ; last line of source













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
