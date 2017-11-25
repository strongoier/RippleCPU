library ieee;
use ieee.std_logic_1164.all;

package Definitions is

    type RegisterArrayType is array(15 downto 0) of std_logic_vector(15 downto 0);

    constant COUNT_INSTRUCTION: integer := 32768;
    constant REG_ZERO         : std_logic_vector(3 downto 0) := "1111";
    constant REG_SP           : std_logic_vector(3 downto 0) := "1000";
    constant REG_T            : std_logic_vector(3 downto 0) := "1001";
    constant REG_IH           : std_logic_vector(3 downto 0) := "1010";
    constant ALUOp_DEFAULT    : std_logic_vector(3 downto 0) := "0001";
    constant ALUOp_ADD        : std_logic_vector(3 downto 0) := "0001";
    constant ALUOp_AND        : std_logic_vector(3 downto 0) := "0010";
    constant ALUOp_BNOP       : std_logic_vector(3 downto 0) := "0011";
    constant ALUOp_BEQZ       : std_logic_vector(3 downto 0) := "0100";
    constant ALUOp_BNEZ       : std_logic_vector(3 downto 0) := "0101";
    constant ALUOp_SNE        : std_logic_vector(3 downto 0) := "0110";
    constant ALUOp_OR         : std_logic_vector(3 downto 0) := "0111";
    constant ALUOp_SLL        : std_logic_vector(3 downto 0) := "1000";
    constant ALUOp_SRA        : std_logic_vector(3 downto 0) := "1001";
    constant ALUOp_SUB        : std_logic_vector(3 downto 0) := "1010";
    constant ALUOp_SLT        : std_logic_vector(3 downto 0) := "1011";
    constant ALUOp_SLTU       : std_logic_vector(3 downto 0) := "1100";
    constant ALUSrc_DEFAULT   : std_logic := '0';
    constant ALUSrc_IMMEDIATE : std_logic := '0';
    constant ALUSrc_REG       : std_logic := '1';
    constant FORWARD_ID2EX    : std_logic_vector(1 downto 0) := "00";
    constant FORWARD_EX2MEM   : std_logic_vector(1 downto 0) := "01";
    constant FORWARD_MEM2WB   : std_logic_vector(1 downto 0) := "10";
    constant INSTRUCTION_NOP  : std_logic_vector(15 downto 0) := "0000100000000000";
    constant PC_INITIAL       : std_logic_vector(15 downto 0) := "0000000000000000";
    constant ZERO_16          : std_logic_vector(15 downto 0) := "0000000000000000";

end Definitions;

package body Definitions is
end Definitions;
