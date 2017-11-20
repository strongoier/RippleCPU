library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Definitions.all;

entity Forwarding is
    port (
        ID2EX_ReadRegister1: in std_logic_vector(3 downto 0);
        ID2EX_ReadRegister2: in std_logic_vector(3 downto 0);
        EX2MEM_RegWrite: in std_logic;
        EX2MEM_WriteRegister: in std_logic_vector(3 downto 0);
        MEM2WB_RegWrite: in std_logic;
        MEM2WB_WriteRegister: in std_logic_vector(3 downto 0);
        Forward1: out std_logic_vector(1 downto 0);
        Forward2: out std_logic_vector(1 downto 0)
    );
end Forwarding;

architecture Behavioral of Forwarding is

begin
    Forward1 <= FORWARD_EX2MEM when (EX2MEM_RegWrite = '1' and EX2MEM_WriteRegister = ID2EX_ReadRegister1) else
                FORWARD_MEM2WB when (MEM2WB_RegWrite = '1' and MEM2WB_WriteRegister = ID2EX_ReadRegister1) else
                FORWARD_ID2EX;
    Forward2 <= FORWARD_EX2MEM when (EX2MEM_RegWrite = '1' and EX2MEM_WriteRegister = ID2EX_ReadRegister2) else
                FORWARD_MEM2WB when (MEM2WB_RegWrite = '1' and MEM2WB_WriteRegister = ID2EX_ReadRegister2) else
                FORWARD_ID2EX;
end Behavioral;
