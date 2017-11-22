--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Definitions is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

    constant REG_ZERO         : std_logic_vector(3 downto 0) := "1111";
    constant REG_SP           : std_logic_vector(3 downto 0) := "1000";
    constant REG_T            : std_logic_vector(3 downto 0) := "1001";
    constant REG_IH           : std_logic_vector(3 downto 0) := "1010";
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
    constant ZERO_16          : std_logic_vector(15 downto 0) := "0000000000000000";
    constant ZERO_4           : std_logic_vector(3 downto 0) := "0000";
end Definitions;

package body Definitions is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end Definitions;
