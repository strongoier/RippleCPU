INIT: LI R0 0                   // 初始化 R0: 上次读取的按键
LI R1 0                         // R1: 当前读取的按键
LI R2 0                         // R2: 当前光标位置（距离左上角的距离）
LI R3 0                         // R3: 当前光标列号（距离本行左侧的距离）
CLEARSCREEN: LI R4 9            // CLEARSCREEN: 清空整个屏幕
SLL R4 R4 0                     // 设置 R4 为整个屏幕的字符总数 0x960
ADDIU R4 60
CLEARCHAR: SUBU R4 R2 R5        // 判断当前光标位置是否到达右下角
BEQZ R5 SETCURSORLEFTTOP        // 到达右下角，清屏结束，跳至 SETCURSORLEFTTOP
NOP
LI R5 BF                        // 将当前光标位置的字符置为空
SLL R5 R5 0
SW R5 R1 2
SW R5 R2 3
ADDIU R2 1                      // 移动光标到下一个位置
B CLEARCHAR                     // 跳转到 CLEARCHAR 判断是否清屏完毕
NOP
SETCURSORLEFTTOP: LI R2 0       // 将光标移至左上角
LI R5 BF
SLL R5 R5 0
SW R5 R2 5
GETCURRENTKEY: MOVE R0 R1       // 用当前按键的值覆盖上次按键的值
LI R5 BF                        // 读取当前按键
SLL R5 R5 0
LW R5 R1 4
SUBU R0 R1 R5                   // 判断当前按键与上次按键是否相同
BEQZ R5 GETCURRENTKEY           // 如果相同，说明按键状态没有改变，跳至 GETCURRENTKEY 继续读取
NOP
BEQZ R1 GETCURRENTKEY           // 如果当前按键为 0，说明没有键按下，跳至 GETCURRENTKEY 继续读取
NOP
LI R5 60                        // 判断当前按键是否为可见字符
SLTU R1 R5
BTEQZ E                         // 当前按键不是可见字符，跳至 JUDGEBKSP 判断是否为退格键
NOP
LI R4 4F                        // 当前按键是可见字符，判断当前光标位置是否到达本行行尾
CMP R3 R4
BTEQZ GETCURRENTKEY             // 如果到达行尾，不写入当前字符，跳至 GETCURRENTKEY 继续读取按键
NOP
ADDIU R3 1                      // 当前光标列号 +1
LI R5 BF                        // 写入当前字符
SLL R5 R5 0
SW R5 R1 2
SW R5 R2 3
ADDIU R2 1                      // 当前光标位置 +1
SW R5 R2 5
B GETCURRENTKEY                 // 当前按键作为可见字符处理完毕，跳至 GETCURRENTKEY 继续读取按键
NOP
JUDGEBKSP: LI R5 60             // 判断当前按键是否为退格键
SUBU R5 R1 R5
BNEZ R5 JUDGECLEARSCREEN        // 当前按键不是退格键，跳至 JUDGECLEARSCREEN 判断是否为清屏功能键
NOP
LI R4 0                         // 当前按键是退格键，判断是否到达行首
CMP R3 R4
BTEQZ GETCURRENTKEY             // 如果到达行首，不执行退格，跳至 GETCURRENTKEY 继续读取按键
NOP
ADDIU R3 FF                     // 当前光标列号 -1
LI R5 BF                        // 清空当前字符
SLL R5 R5 0
ADDIU R2 FF                     // 当前光标位置 -1
SW R5 R2 5
SW R5 R1 2 
SW R5 R2 3
B GETCURRENTKEY                 // 当前按键作为退格键处理完毕，跳至 GETCURRENTKEY 继续读取按键
NOP
JUDGECLEARSCREEN: LI R5 69      // 判断当前按键是否为清屏功能键
SUBU R5 R1 R5
BNEZ R5 JUDGEEXIT               // 如果当前按键不是清屏功能键，跳至 JUDGEEXIT 判断是否为退出功能键
NOP
B INIT                          // 当前按键是清屏功能键，跳至 INIT 执行初始化与清屏
NOP
JUDGEEXIT: LI R5 68             // 判断当前按键是否为退出功能键
SUBU R5 R1 R5
BNEZ R5 JUDGEENTER              // 如果当前按键不是退出功能键，跳至 JUDGEENTER 判断是否为换行功能键
NOP
B QUIT                          // 当前按键是退出功能键，跳至 QUIT 退出
NOP
JUDGEENTER: LI R5 61            // 判断当前按键是否为换行功能键
SUBU R5 R1 R5
BNEZ R5 NEXT                    // 如果不是换行功能键，跳至 NEXT 准备下一个判断
NOP
LI R4 50                        // 计算当前行剩余空字符数量
SUBU R4 R3 R4
ADDU R2 R4 R2                   // 将当前光标位置移至下行行首
LI R3 0                         // 将当前光标列号置 0
LI R5 BF                        // 更新光标位置给 VGA
SLL R5 R5 0
SW R5 R2 5
B GETCURRENTKEY                 // 当前按键作为换行功能键处理完毕，跳至 GETCURRENTKEY 继续读取按键
NOP
NEXT: B GETCURRENTKEY           // 预留给其他按键类型判断的位置，跳至 GETCURRENTKEY 继续读取按键
NOP
QUIT: JR R7
NOP
