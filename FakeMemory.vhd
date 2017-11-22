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
    ReadData <= "0110100100000010" when Address = 0 else -- LI R1 0002
                "0110101011111111" when Address = 1 else -- LI R2 00ff
                "1110000101001101" when Address = 2 else -- ADDU R1 R2 R3
                WriteData when MemRead = '1' and MemWrite = '1' else
                INSTRUCTION_NOP;
end Behavioral;
