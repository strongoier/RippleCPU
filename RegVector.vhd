library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity RegVector is
    generic (
        Size: integer := 16
    );
    port (
        Clk: in std_logic;
        Flush: in std_logic;
        WriteEnable: in std_logic;
        DataInitial: in std_logic_vector(Size - 1 downto 0);
        DataIn: in std_logic_vector(Size - 1 downto 0);
        DataOut: out std_logic_vector(Size - 1 downto 0)
    );
end RegVector;

architecture Behavioral of RegVector is

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
