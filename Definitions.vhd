library ieee;
use ieee.std_logic_1164.all;

package Definitions is

    type RegisterArrayType is array(15 downto 0) of std_logic_vector(15 downto 0);
    type text_line is array(79 downto 0) of std_logic_vector(7 downto 0);
    type matrix is array(29 downto 0) of text_line;

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

    constant key_A: integer :=1;
    constant key_B: integer :=2;
    constant key_C: integer :=3;
    constant key_D: integer :=4;
    constant key_E: integer :=5;
    constant key_F: integer :=6;
    constant key_G: integer :=7;
    constant key_H: integer :=8;
    constant key_I: integer :=9;
    constant key_J: integer :=10;
    constant key_K: integer :=11;
    constant key_L: integer :=12;
    constant key_M: integer :=13;
    constant key_N: integer :=14;
    constant key_O: integer :=15;
    constant key_P: integer :=16;
    constant key_Q: integer :=17;
    constant key_R: integer :=18;
    constant key_S: integer :=19;
    constant key_T: integer :=20;
    constant key_U: integer :=21;
    constant key_V: integer :=22;
    constant key_W: integer :=23;
    constant key_X: integer :=24;
    constant key_Y: integer :=25;
    constant key_Z: integer :=26;
    constant key_1: integer :=27;
    constant key_2: integer :=28;
    constant key_3: integer :=29;
    constant key_4: integer :=30;
    constant key_5: integer :=31;
    constant key_6: integer :=32;
    constant key_7: integer :=33;
    constant key_8: integer :=34;
    constant key_9: integer :=35;
    constant key_0: integer :=36;
    constant key_point: integer :=37; -- `
    constant key_sub: integer :=38; -- -
    constant key_equal: integer :=39; -- =
    constant key_bslash: integer :=40; -- \
    constant key_lbracket: integer :=41; -- [
    constant key_rbracket: integer :=42; -- ]
    constant key_semicolon: integer :=43; -- ;
    constant key_quote: integer :=44; -- '
    constant key_comma: integer :=45; -- ,
    constant key_stop: integer :=46; -- .
    constant key_slash: integer :=47; -- /
    constant key_space: integer :=48;
    constant key_bksp: integer :=49;
    constant key_enter: integer :=50;
    constant key_up: integer :=51;
    constant key_down: integer :=52;
    constant key_left: integer :=53;
    constant key_right: integer :=54;
    constant key_lshft: integer :=55;
    constant key_rshft: integer :=56;
end Definitions;

package body Definitions is
end Definitions;
