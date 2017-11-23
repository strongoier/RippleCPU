library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Memory is
    port (
        Clk: in std_logic;
        MemRead: in std_logic;
        MemWrite: in std_logic;
        Address: in std_logic_vector(15 downto 0);
        WriteData: in std_logic_vector(15 downto 0);
        ReadData: out std_logic_vector(15 downto 0);
        OE: out std_logic;
        WE: out std_logic;
        EN: out std_logic;
        RamAddr: out std_logic_vector(17 downto 0);
        RamData: inout std_logic_vector(15 downto 0)
    );
end Memory;

architecture Behavioral of Memory is

begin
    OE <= Clk or (not MemRead);
    WE <= Clk or (not MemWrite);
    EN <= '0';
    RamAddr <= "00" & Address;
    ReadData <= RamData;
    RamData <= WriteData when MemWrite = '1' else
               (others => 'Z');
end Behavioral;
