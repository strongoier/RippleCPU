LI R1 BF
LI R2 20
SLL R1 R1 0
LI R3 7E
NOP
LI R6 BF
SLL R6 R6 0
ADDIU R6 1
LW R6 R0 0
LI R6 1
AND R0 R6
BEQZ R0 F8
NOP
SW R1 R2 0
ADDIU R2 1
SLT R3 R2
BTEQZ F3
NOP
JR R7
NOP
