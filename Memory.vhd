library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Memory is
    port (
        OE: in std_logic;
        WE: in std_logic;
        RamAddr: out std_logic_vector(17 downto 0);
        RamData: inout std_logic_vector(15 downto 0);
        MemWrite: in std_logic;
        Address: in std_logic_vector(15 downto 0);
        WriteData: in std_logic_vector(15 downto 0);
        ReadData: out std_logic_vector(15 downto 0)
    );
end Memory;

architecture Behavioral of Memory is

begin
    RamAddr <= "00" & Address;
    ReadData <= RamData;

    process (OE)
    begin
        if rising_edge(OE) and MemWrite = '0' then
            RamData <= (others => 'Z');
        end if;
    end process;

    process (WE)
    begin
        if rising_edge(WE) and MemWrite = '1' then
            RamData <= WriteData;
        end if;
    end process;
end Behavioral;
