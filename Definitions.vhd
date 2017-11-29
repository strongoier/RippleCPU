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

    constant key_a: integer :=1;
    constant key_b: integer :=2;
    constant key_c: integer :=3;
    constant key_d: integer :=4;
    constant key_e: integer :=5;
    constant key_f: integer :=6;
    constant key_g: integer :=7;
    constant key_h: integer :=8;
    constant key_i: integer :=9;
    constant key_j: integer :=10;
    constant key_k: integer :=11;
    constant key_l: integer :=12;
    constant key_m: integer :=13;
    constant key_n: integer :=14;
    constant key_o: integer :=15;
    constant key_p: integer :=16;
    constant key_q: integer :=17;
    constant key_r: integer :=18;
    constant key_s: integer :=19;
    constant key_t: integer :=20;
    constant key_u: integer :=21;
    constant key_v: integer :=22;
    constant key_w: integer :=23;
    constant key_x: integer :=24;
    constant key_y: integer :=25;
    constant key_z: integer :=26;
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
    constant key_CA: integer := 49;
    constant key_CB: integer := 50;
    constant key_CC: integer := 51;
    constant key_CD: integer := 52;
    constant key_CE: integer := 53;
    constant key_CF: integer := 54;
    constant key_CG: integer := 55;
    constant key_CH: integer := 56;
    constant key_CI: integer := 57;
    constant key_CJ: integer := 58;
    constant key_CK: integer := 59;
    constant key_CL: integer := 60;
    constant key_CM: integer := 61;
    constant key_CN: integer := 62;
    constant key_CO: integer := 63;
    constant key_CP: integer := 64;
    constant key_CQ: integer := 65;
    constant key_CR: integer := 66;
    constant key_CS: integer := 67;
    constant key_CT: integer := 68;
    constant key_CU: integer := 69;
    constant key_CV: integer := 70;
    constant key_CW: integer := 71;
    constant key_CX: integer := 72;
    constant key_CY: integer := 73;
    constant key_CZ: integer := 74;
    constant key_not: integer := 75; -- !
    constant key_at: integer := 76; -- @
    constant key_hashtag: integer := 77; --#
    constant key_dollar: integer := 78; --$
    constant key_percent: integer := 79; --%
    constant key_xor: integer := 80;  --^
    constant key_and: integer := 81;  --&
    constant key_times: integer := 82;  --*
    constant key_lparenthesis: integer := 83; --(
    constant key_rparenthesis: integer := 84; --)
    constant key_ripple: integer := 85; --~
    constant key_underline: integer := 86;  --_
    constant key_plus: integer := 87; -- +
    constant key_or: integer := 88;  --|
    constant key_lbrace: integer := 89;  --{
    constant key_rbrace: integer := 90;  --}
    constant key_colon: integer := 91;  --:
    constant key_dquote: integer := 92;  --"
    constant key_lt: integer := 93;  --<
    constant key_gt: integer := 94;  -->
    constant key_ques: integer := 95;  --?
    constant key_bksp: integer :=96;
    constant key_enter: integer :=97;
    constant key_up: integer :=98;
    constant key_down: integer :=99;
    constant key_left: integer :=100;
    constant key_right: integer :=101;
    constant key_lshft: integer :=102;
    constant key_rshft: integer :=103;
    constant key_esc: integer :=104;

end Definitions;

package body Definitions is
end Definitions;
