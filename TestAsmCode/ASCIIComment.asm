LI R1 BF
LI R2 20    ; 第一个能打印的字符值为0x20（空格）
SLL R1 R1 0 ; 将Com1数据端口地址0xBF00存入R1
LI R3 7E    ; 最后一个能打印的字符值为0x7E
NOP
LI R6 BF
SLL R6 R6 0
ADDIU R6 1
LW R6 R0 0
LI R6 1
AND R0 R6
BEQZ R0 F8  ; 以上部分检测串口是否可写，如不可写返回至之前的NOP语句
NOP
SW R1 R2 0  ; 打印当前字符值表示的字符
ADDIU R2 1  ; 当前打印的字符值 + 1
SLT R3 R2   ; 比较当前打印字符值是否超过0x7E
BTEQZ F3    ; T=0时，跳到前一个NOP语句继续执行，否则退出循环
NOP
JR R7
NOP
