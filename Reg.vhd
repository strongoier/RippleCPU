library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Reg is
    port (
        Clk: in std_logic;
        Flush: in std_logic;
        WriteEnable: in std_logic;
        DataIn: in std_logic;
        DataOut: out std_logic
    );
end Reg;

architecture Behavioral of Reg is

begin
    process (Clk)
    begin
        if rising_edge(Clk) then
            if Flush = '1' then
                DataOut <= '0';
            elsif WriteEnable = '1' then
                DataOut <= DataIn;
            end if;
        end if;
    end process;
end Behavioral;
