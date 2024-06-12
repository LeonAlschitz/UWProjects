Easy68k was the IDE used in order to run this project.

This project is a Disassembler that is able to read code as Machine Language, 
translate it into Assembly, and then output the result into the IO window.

Disassembler_EA.X68, Disassembler_Msgs.X68, and Disassembler_OPCodes.X68 all need to be included
at the bottom of the Disassembler.x68 in order for the disassembler to function.

Samle_Test.x68 and demo_test.x68 were sample data provided by the professor that we would be tested
against.




1. Start by opening Disassembler.x68, and running it.
2. Two Windows will pop up, an IO window and a debugging window, that also shows you what addresses are being used by the code.
Please press f9 to run the program, or the play button in the top left corner.


3. You will need to provide a starting memory address and an ending memory address.
Please make sure you provide a valid starting and ending address as the disassembler will not check before hand if they are valid.


You can have the Disassembler read itself starting at address 0x00001000
demo_test.x68 starts at 0x00001EA4.

note: there is no scroll feature in the output window

