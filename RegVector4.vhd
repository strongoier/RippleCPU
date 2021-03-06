library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity RegVector4 is
    generic (
        DataInitial: std_logic_vector(3 downto 0)
    );
    port (
        Clk: in std_logic;
        Flush: in std_logic;
        WriteEnable: in std_logic;
        DataIn: in std_logic_vector(3 downto 0);
        DataOut: out std_logic_vector(3 downto 0) := DataInitial
    );
end RegVector4;

architecture Behavioral of RegVector4 is

begin
    process (Clk)
    begin
        if rising_edge(Clk) then
            if Flush = '1' then
                DataOut <= DataInitial;
            elsif WriteEnable = '1' then
                DataOut <= DataIn;
            end if;
        end if;
    end process;
end Behavioral;
