----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:54 11/27/2017 
-- Design Name: 
-- Module Name:    VGA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use work.Definitions.all;
use work.Components.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           --in_text : in matrix;
           Data : in STD_LOGIC_VECTOR (9 downto 0);
           Addr : out STD_LOGIC_VECTOR (13 downto 0) := (others => '0');
           Red : out  STD_LOGIC_VECTOR (2 downto 0) := (others => '1');
           Green : out  STD_LOGIC_VECTOR (2 downto 0) := (others => '1');
           Blue : out  STD_LOGIC_VECTOR (2 downto 0) := (others => '1');
           Hs : out  STD_LOGIC := '1';
           Vs : out  STD_LOGIC := '1');
end VGA;

architecture Behavioral of VGA is
    signal curClk : STD_LOGIC := '0';
    constant GRID_WIDTH  : integer := 8;
    constant GRID_HEIGHT : integer := 16;
    --signal cur_text : matrix;
    signal cur_grid : STD_LOGIC_VECTOR(8 downto 0) := (others=>'1');
begin

process (clk)
begin
    if (clk'event and clk = '0') then
        curClk <= not curClk;
    end if;
end process;

process (rst, curClk)
    variable curHorizon  : integer := 0;
    variable curVertical : integer := 0;
    variable grid_low_h  : integer := 0;
    variable grid_high_h : integer := 0;
    variable grid_low_v  : integer := 0;
    variable grid_high_v : integer := 0;
begin
    if (rst = '0') then
        curHorizon := 0;
        curVertical := 0;
        grid_low_h := 0;
        grid_low_v := 0;
        grid_high_h := 0;
        grid_high_v := 0;
        Hs <= '1';
        Vs <= '1';
        Red <= (others=>'1');
        Green <= (others=>'1');
        Blue <= (others=>'1');
        Addr <= (others=>'0');
        cur_grid <= (others=>'1');
        --cur_text <= in_text;
    elsif (curClk'event and curClk = '1') then
        --if (curHorizon = 0 and curVertical = 0) then
        --    cur_text <= in_text;
        if (curHorizon >= 656 and curHorizon < 752) then
            Hs <= '0';
        else
            Hs <= '1';
        end if;
        if (curVertical = 490 or curVertical = 491) then
            Vs <= '0';
        else
            Vs <= '1';
        end if;
        if (curHorizon < 640 and curVertical < 480) then
            -- draw
            cur_grid <= Data(9 downto 1);
            Red <= cur_grid(8 downto 6);
            Green <= cur_grid(5 downto 3);
            Blue <= cur_grid(2 downto 0);
        else
            Red <= (others=>'0');
            Green <= (others=>'0');
            Blue <= (others=>'0');
        end if;
        -- next grid
        curHorizon := curHorizon + 1;
        grid_low_h := grid_low_h + 1;
        if (grid_low_h >= GRID_WIDTH) then
            grid_low_h := 0;
            grid_high_h := grid_high_h + 1;
        end if;
        if (curHorizon >= 800) then
            curHorizon := 0;
            curVertical := curVertical + 1;
            grid_low_h := 0;
            grid_high_h := 0;
            grid_low_v := grid_low_v + 1;
            if (grid_low_v >= GRID_HEIGHT) then
                grid_low_v := 0;
                grid_high_v := grid_high_v + 1;
            end if;
            if (curVertical >= 525) then
                curVertical := 0;
                grid_low_v := 0;
                grid_high_v := 0;
            end if;
        end if;
        --Addr<=cur_text(grid_high_v)(grid_high_h)(6 downto 0)&(TO_STDLOGICVECTOR(grid_low_h, 3))&(TO_STDLOGICVECTOR(grid_low_v, 4);
        Addr<="0000010"&STD_LOGIC_VECTOR(TO_UNSIGNED(grid_low_h, 3))&STD_LOGIC_VECTOR(TO_UNSIGNED(grid_low_v, 4));
    end if;
end process;


end Behavioral;

