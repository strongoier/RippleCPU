library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Definitions.all;

entity Registers is
    port (
        Clk: in std_logic;
        RegWrite: in std_logic;
        ReadRegister1: in std_logic_vector(3 downto 0);
        ReadRegister2: in std_logic_vector(3 downto 0);
        WriteRegister: in std_logic_vector(3 downto 0);
        WriteData: in std_logic_vector(15 downto 0);
        ReadData1: out std_logic_vector(15 downto 0);
        ReadData2: out std_logic_vector(15 downto 0)
    );
end Registers;

architecture Behavioral of Registers is
    signal RegisterArray: RegisterArrayType;
begin
    ReadData1 <= RegisterArray(conv_integer(ReadRegister1)) when ReadRegister1 <= "1010" else (others => '0');
    ReadData2 <= RegisterArray(conv_integer(ReadRegister2)) when ReadRegister2 <= "1010" else (others => '0');

    process (Clk)
    begin
        if falling_edge(Clk) and RegWrite = '1' then
            RegisterArray(conv_integer(WriteRegister)) <= WriteData;
        end if;
    end process;
end Behavioral;
