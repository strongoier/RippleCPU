----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:37:13 11/21/2017 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use work.Definitions.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( in_data1 : in  STD_LOGIC_VECTOR (15 downto 0);
           in_data2 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUOp : in  STD_LOGIC_VECTOR (3 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (15 downto 0);
           Branch : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
begin

process(in_data1, in_data2, ALUOp)
begin
    case ALUOp is
        when ALUOp_ADD=>
            Branch<='0';
            ALUResult<=(in_data1)+(in_data2);
        when ALUOp_AND=>
            Branch<='0';
            ALUResult<=(in_data1 and in_data2);
        when ALUOp_BNOP=>
            Branch<='1';
            ALUResult<=(others=>'0');
        when ALUOp_BEQZ=>
            ALUResult<=(others=>'0');
            if (in_data1 = "0000000000000000") then
                Branch<='1';
            else
                Branch<='0';
            end if;
        when ALUOp_BNEZ=>
            ALUResult<=(others=>'0');
            if (in_data1 = "0000000000000000") then
                Branch<='0';
            else
                Branch<='1';
            end if;
        when ALUOp_SNE=>
            Branch<='0';
            if (in_data1 = in_data2) then
                ALUResult<=(others=>'0');
            else
                ALUResult<="0000000000000001";
            end if;
        when ALUOp_OR=>
            Branch<='0';
            ALUResult<=(in_data1 or in_data2);
        when ALUOp_SLL=>
            Branch<='0';
            ALUResult<=TO_STDLOGICVECTOR(TO_BITVECTOR(in_data1) sll CONV_INTEGER(in_data2));
        when ALUOp_SRA=>
            Branch<='0';
            ALUResult<=TO_STDLOGICVECTOR(TO_BITVECTOR(in_data1) sra CONV_INTEGER(in_data2));
        when ALUOp_SUB=>
            Branch<='0';
            ALUResult<=(in_data1)-(in_data2);
        when ALUOp_SLT=>
            Branch<='0';
            if (SIGNED(in_data1) < SIGNED(in_data2)) then
                ALUResult<="0000000000000001";
            else
                ALUResult<=(others=>'0');
            end if;
        when ALUOp_SLTU=>
            Branch<='0';
            if (UNSIGNED(in_data1) < UNSIGNED(in_data2)) then
                ALUResult<="0000000000000001";
            else
                ALUResult<=(others=>'0');
            end if;
        when others=>
            Branch<='0';
            ALUResult<=(others=>'0');
    end case;
end process;
end Behavioral;

