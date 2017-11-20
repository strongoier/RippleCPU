library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Definitions.all;

entity HazardDetection is
    port (
        IF2ID_ReadRegister1: in std_logic_vector(3 downto 0);
        IF2ID_ReadRegister2: in std_logic_vector(3 downto 0);
        ID2EX_MemRead: in std_logic;
        ID2EX_WriteRegister: in std_logic_vector(3 downto 0);
        PC_Write: out std_logic;
        IF2ID_Write: out std_logic;
        ID2EX_Flush: out std_logic
    );
end HazardDetection;

architecture Behavioral of HazardDetection is

begin
    PC_Write <= '0' when (ID2EX_MemRead and (ID2EX_WriteRegister = IF2ID_ReadRegister1 or ID2EX_WriteRegister = IF2ID_ReadRegister2)) else '1';
    IF2ID_Write <= '0' when (ID2EX_MemRead and (ID2EX_WriteRegister = IF2ID_ReadRegister1 or ID2EX_WriteRegister = IF2ID_ReadRegister2)) else '1';
    ID2EX_Flush <= '1' when (ID2EX_MemRead and (ID2EX_WriteRegister = IF2ID_ReadRegister1 or ID2EX_WriteRegister = IF2ID_ReadRegister2)) else '0';
end Behavioral;
