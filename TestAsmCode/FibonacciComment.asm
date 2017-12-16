LI R1 1       ; 寄存器R1记录第一个Fibonacci数
LI R2 1       ; 寄存器R2记录第二个Fibonacci数
LI R3 85
SLL R3 R3 0   ; 初始地址为0x8500
LI R4 5       ; 计数器初值为10 / 2 = 5
SW R3 R1 0    
SW R3 R2 1    ; 在内存中存下算出的两个Fibonacci数
ADDU R1 R2 R1 ; R1 = R1 + R2
ADDU R1 R2 R2 ; R2 = R1 + R2 = (原R1 + R2) + R2
ADDIU R3 2    ; 每次计算出两个Fibonacci数，地址加2
ADDIU R4 FF   ; 计数器 - 1
BNEZ R4 F9    ; R4值不为0时，跳转至SW R3 R1 0，否则退出循环
NOP
JR R7
NOP
