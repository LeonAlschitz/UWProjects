*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
* Put variables and constants here

INTRO_MSG:       DC.B       'Welcome to Team Cools Disassembler!',CR,LF,0
STARTING_MSG:    DC.B       'Please enter the Starting Address',CR,LF,0
ENDING_MSG:      DC.B       'Please enter the Ending Address',CR,LF,0
DONE_MSG:        DC.B       'Done Reading data',CR,LF,0
RESTART_MSG:     DC.B       'Press 1 to restart, and 2 to exit',CR,LF,0
TY_MSG:          DC.B       'Thank you for trying out this disassembler',CR,LF,0

* CR and LF for strings above because we want to go to next line after printing message

STA_ADDR         DS.B        40
END_ADDR         DS.B        40

* no CR and LF for strings below because we want to print each number and letter

SPACE_MSG:       DC.B        '  ',0

ZERO_MSG:        DC.B        '0',0
ONE_MSG:         DC.B        '1',0
TWO_MSG:         DC.B        '2',0
THREE_MSG:       DC.B        '3',0
FOUR_MSG:        DC.B        '4',0
FIVE_MSG:        DC.B        '5',0
SIX_MSG:         DC.B        '6',0
SEVEN_MSG:       DC.B        '7',0
EIGHT_MSG:       DC.B        '8',0
NINE_MSG:        DC.B        '9',0
A_MSG:           DC.B        'A',0
B_MSG:           DC.B        'B',0
C_MSG:           DC.B        'C',0
D_MSG:           DC.B        'D',0
E_MSG:           DC.B        'E',0
F_MSG:           DC.B        'F',0 
*-----------------------------------
NOT_MSG:        DC.B        'NOT',0
BRA_MSG:        DC.B        'BRA',0

MOVE_MSG:       DC.B        'MOVE',0
MOVEM_MSG:      DC.B        'MOVEM',0
MOVEA_MSG:      DC.B        'MOVEA',0


ADD_MSG:        DC.B        'ADD',0
ADDA_MSG:       DC.B        'ADDA',0
ADDQ_MSG:       DC.B        'ADDQ',0
SUB_MSG:        DC.B        'SUB',0
RTS_MSG:        DC.B        'RTS',0
NOP_MSG:        DC.B        'NOP',0






WHITESPACE:     DC.B        ' ',0
WHITESPACE_COM: DC.B        ', ',0

DATA_REG:       DC.B        'D',0
ADDR_REG:       DC.B        'A',0

IMM_DATA:       DC.B        '#',0
HEX:            DC.B        '$',0

DOT_BYTE:       DC.B        '.B',0
DOT_WORD:       DC.B        '.W',0
DOT_LONG:       DC.B        '.L',0

START_PAREN     DC.B        '(',0
END_PAREN       DC.B        ')',0

PLUS_SIGN       DC.B        '+',0
MINUS_SIGN      DC.B        '-',0
DIV_SIGN        DC.B        '/',0
*-------------------------------
JSRMSG:         DC.B        'JSR ',0
JSR_MSG:        DC.B        'JSR',0
MOVEQ_MSG:      DC.B        'MOVEQ',0
AND_MSG:        DC.B        'AND',0
LEA_MSG         DC.B        'LEA',0
ASR_MSG         DC.B        'ASR',0
ASL_MSG         DC.B        'ASL',0
LSR_MSG         DC.B        'LSR',0
LSL_MSG         DC.B        'LSL',0
ROXR_MSG        DC.B        'ROX',0  *Unused messages but present because helps in indexing, DONT USE IT
ROXL_MSG        DC.B        'ROX',0  *Unused messages but present because helps in indexing, DONT USE IT
ROR_MSG         DC.B        'ROR',0
ROL_MSG         DC.B        'ROL',0
OR_MSG:         DC.B        'OR',0
DATA_MSG:       DC.B        'DATA',0
BCC_MSG         DC.B        'B', 0
BLE_MSG         DC.B        'BLE', 0
BGT_MSG         DC.B        'BGT',0
BEQ_MSG         DC.B        'BEQ',0

BYTE_MSG        DC.B        '.B', 0
WORD_MSG        DC.B        '.W', 0
LONG_MSG        DC.B        '.L', 0

COMMA_MSG       DC.B        ',', 0
DOLLAR_MSG      DC.B        '$', 0
HASH_MSG        DC.B        '#', 0
PLUS_MSG        DC.B        '+', 0
MINUS_MSG       DC.B        '-', 0
OPEN_PARENTHESIS_MSG  DC.B   '(', 0
CLOSE_PARENTHESIS_MSG DC.B  ')', 0


*-----Carriage Return
CR              EQU          $0D
*-----------Line Feed
LF              EQU          $0A

NEW_LINE:       DC.B         '',CR,LF,0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
