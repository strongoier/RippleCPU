LI R0 0
LI R1 0
LI R2 0
LI R3 0
LI R4 9
SLL R4 R4 0
ADDIU R4 60
SUBU R4 R2 R5
BEQZ R5 8
NOP
LI R5 BF
SLL R5 R5 0
SW R5 R1 2
SW R5 R2 3
ADDIU R2 1
B 7F7
NOP
LI R2 0
LI R5 BF
SLL R5 R5 0
SW R5 R2 5
MOVE R0 R1
LI R5 BF
SLL R5 R5 0
LW R5 R1 4
SUBU R0 R1 R5
BEQZ R5 FA
NOP
BEQZ R1 F8
NOP
LI R5 60
SLTU R1 R5
BTEQZ E
NOP
LI R4 4F
CMP R3 R4
BTEQZ F0
NOP
ADDIU R3 1
LI R5 BF
SLL R5 R5 0
SW R5 R1 2
SW R5 R2 3
ADDIU R2 1
SW R5 R2 5
B 7E7
NOP
LI R5 60
SUBU R5 R1 R5
BNEZ R5 E
NOP
LI R4 0
CMP R3 R4
BTEQZ DF
NOP
ADDIU R3 FF
LI R5 BF
SLL R5 R5 0
ADDIU R2 FF
SW R5 R2 5
SW R5 R1 2
SW R5 R2 3
B 7D6
NOP
LI R5 69
SUBU R5 R1 R5
BNEZ R5 3
NOP
B 7BB
NOP
LI R5 68
SUBU R5 R1 R5
BNEZ R5 3
NOP
B 10
NOP
LI R5 61
SUBU R5 R1 R5
BNEZ R5 A
NOP
LI R4 50
SUBU R4 R3 R4
ADDU R2 R4 R2
LI R3 0
LI R5 BF
SLL R5 R5 0
SW R5 R2 5
B 7BD
NOP
B 7BB
NOP
JR R7
NOP
