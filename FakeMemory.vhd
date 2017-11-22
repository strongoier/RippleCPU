library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Definitions.all;

entity FakeMemory is
    port (
        MemRead: in std_logic;
        MemWrite: in std_logic;
        Address: in std_logic_vector(15 downto 0);
        WriteData: in std_logic_vector(15 downto 0);
        ReadData: out std_logic_vector(15 downto 0)
    );
end FakeMemory;

architecture Behavioral of FakeMemory is

begin
--    ReadData <= "0110100100000100" when Address = 0 else -- LI R1 0001
--                "0110101011111111" when Address = 1 else -- LI R2 00ff
--                --"1110000101001101" when Address = 2 else -- ADDU R1 R2 R3
--                "0111101101000000" when Address = 2 else -- MOVE R3 R2
--                "0011001001000000" when Address = 3 else -- SLL R2 R2 0000
--                "1110101000101101" when Address = 4 else -- OR R2 R1
--                "1110101001001100" when Address = 5 else -- AND R2 R2
--                "1110101101000010" when Address = 6 else -- SLT R3 R2
--                "0110000000000001" when Address = 7 else -- BTEQZ 0001
--                "0100101011111111" when Address = 8 else -- ADDIU R2 ffff
--                "1110001000101011" when Address = 9 else -- SUBU R2 R1 R2
--                WriteData when MemRead = '1' and MemWrite = '1' else
--                INSTRUCTION_NOP;
--    ReadData <= "0110101011111111" when Address = 0 else -- LI R2 00ff
--                "0111101101000000" when Address = 1 else -- MOVE R3 R2
--                "0011001001000000" when Address = 2 else -- SLL R2 R2 0000
--                "0110100100000001" when Address = 3 else -- LI R1 0001
--                "0110100011111100" when Address = 4 else -- LI R0 00fc
--                "1110101000101101" when Address = 5 else -- OR R2 R1
--                "1110101001001100" when Address = 6 else -- AND R2 R2
--                "1110101101000010" when Address = 7 else -- SLT R3 R2
--                "0110000000000001" when Address = 8 else -- BTEQZ 0001
--                "0100101011111111" when Address = 9 else -- ADDIU R2 ffff
--                "1110001000101011" when Address = 10 else -- SUBU R2 R1 R2
--                WriteData when MemRead = '1' and MemWrite = '1' else
--                INSTRUCTION_NOP;
    ReadData <= "0110101011111111" when Address = 0 else -- LI R2 00ff
                "0111101101000000" when Address = 1 else -- MOVE R3 R2
                "0100101000000100" when Address = 2 else -- ADDIU R2 4
                "0110100100000001" when Address = 3 else -- LI R1 0001
                "0110100000001001" when Address = 4 else -- LI R0 9
                "1110101000101101" when Address = 5 else -- OR R2 R1
                "1110101001001100" when Address = 6 else -- AND R2 R2
                "1110101101000010" when Address = 7 else -- SLT R3 R2
                "0110000000000001" when Address = 8 else -- BTEQZ 0001
                "0100101011111111" when Address = 9 else -- ADDIU R2 ffff
                "1110001000101011" when Address = 10 else -- SUBU R2 R1 R2
                "1110101101000011" when Address = 11 else -- SLTU R3 R2
                "0110000000000011" when Address = 12 else -- BTEQZ 3
                INSTRUCTION_NOP when Address = 13 else -- NOP
                "1110100000000000" when Address = 14 else -- JR R0
                INSTRUCTION_NOP when Address = 15 else -- NOP
                WriteData when MemRead = '1' and MemWrite = '1' else
                INSTRUCTION_NOP;
end Behavioral;
