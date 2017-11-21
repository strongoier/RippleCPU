----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:20:36 11/21/2017 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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
use ieee.numeric_std.all;
use work.Definitions.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
    Port ( ins       : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUOp     : out STD_LOGIC_VECTOR (3 downto 0);
           ALUSrc    : out STD_LOGIC;
           MemRead   : out STD_LOGIC;
           MemWrite  : out STD_LOGIC;
           PCToReg   : out STD_LOGIC;
           RegWrite  : out STD_LOGIC;
           MemToReg  : out STD_LOGIC;
           PCJump    : out STD_LOGIC;
           ReadReg1  : out STD_LOGIC_VECTOR (3 downto 0);
           ReadReg2  : out STD_LOGIC_VECTOR (3 downto 0);
           WriteReg  : out STD_LOGIC_VECTOR (3 downto 0);
           Immediate : out STD_LOGIC_VECTOR (15 downto 0));
end Decoder;

architecture Behavioral of Decoder is
    
begin

process(ins)
begin
    case ins(15 downto 11) is
        when "00000"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=REG_SP;
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
        when "00001"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_DEFAULT;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<="0000";
            ReadReg2<="0000";
            WriteReg<="0000";
            Immediate<="0000000000000000";
        when "00010"=>
            ALUOp<=ALUOp_BNOP;
            ALUSrc<=ALUSrc_DEFAULT;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<="0000";
            ReadReg2<="0000";
            WriteReg<="0000";
            Immediate<=std_logic_vector(resize(signed(ins(10 downto 0)), Immediate'length));
        when "00100"=>
            ALUOp<=ALUOp_BEQZ;
            ALUSrc<=ALUSrc_DEFAULT;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<="0000";
            WriteReg<="0000";
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
        when "00101"=>
            ALUOp<=ALUOp_BNEZ;
            ALUSrc<=ALUSrc_DEFAULT;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<="0000";
            WriteReg<="0000";
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
        when "00110"=>
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(7 downto 5));
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            if (ins(4 downto 2) = "000") then
                Immediate<="0000000000001000";
            else
                Immediate<=("0000000000000"&ins(4 downto 2));
            end if;
            case ins(0) is
                when '0'=>
                    ALUOp<=ALUOp_SLL;
                when '1'=>
                    ALUOp<=ALUOp_SRA;
                when others=>
            end case;
        when "01000"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<="0000";
            WriteReg<=("0"&ins(7 downto 5));
            Immediate<=std_logic_vector(resize(signed(ins(3 downto 0)), Immediate'length));
         when "01001"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
         when "01100"=>
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg2<="0000";
            case ins(10 downto 8) is
                when "011"=>
                    ALUOp<=ALUOp_ADD;
                    ALUSrc<=ALUSrc_IMMEDIATE;
                    RegWrite<='1';
                    ReadReg1<=REG_SP;
                    WriteReg<=REG_SP;
                    Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
                when "000"=>
                    ALUOp<=ALUOp_BEQZ;
                    ALUSrc<=ALUSrc_DEFAULT;
                    RegWrite<='0';
                    ReadReg1<=REG_T;
                    WriteReg<="0000";
                    Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
                when "100"=>
                    ALUOp<=ALUOp_ADD;
                    ALUSrc<=ALUSrc_IMMEDIATE;
                    RegWrite<='1';
                    ReadReg1<=("0"&ins(7 downto 5));
                    WriteReg<=REG_SP;
                    Immediate<="0000000000000000";
                when others=>
            end case;
        when "01101"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=REG_ZERO;
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            Immediate<=("00000000"&ins(7 downto 0));
        when "01111"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(7 downto 5));
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            Immediate<="0000000000000000";
        when "10010"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='1';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='1';
            PCJump<='0';
            ReadReg1<=REG_SP;
            ReadReg2<="0000";
            WriteReg<=("0"&ins(10 downto 8));
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
        when "10011"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='1';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='1';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<="0000";
            WriteReg<=("0"&ins(7 downto 5));
            Immediate<=std_logic_vector(resize(signed(ins(4 downto 0)), Immediate'length));
        when "11010"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='1';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=REG_SP;
            ReadReg2<=("0"&ins(10 downto 8));
            WriteReg<="0000";
            Immediate<=std_logic_vector(resize(signed(ins(7 downto 0)), Immediate'length));
         when "11011"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='1';
            PCToReg<='0';
            RegWrite<='0';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<=("0"&ins(7 downto 5));
            WriteReg<="0000";
            Immediate<=std_logic_vector(resize(signed(ins(4 downto 0)), Immediate'length));
        when "11100"=>
            case ins(1) is
                when '0'=>ALUOp<=ALUOp_ADD;
                when '1'=>ALUOp<=ALUOp_SUB;
                when others=>
            end case;
            ALUSrc<=ALUSrc_REG;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg1<=("0"&ins(10 downto 8));
            ReadReg2<=("0"&ins(7 downto 5));
            WriteReg<=("0"&ins(4 downto 2));
            Immediate<="0000000000000000";
        when "11110"=>
            ALUOp<=ALUOp_ADD;
            ALUSrc<=ALUSrc_IMMEDIATE;
            MemRead<='0';
            MemWrite<='0';
            PCToReg<='0';
            RegWrite<='1';
            MemToReg<='0';
            PCJump<='0';
            ReadReg2<="0000";
            Immediate<="0000000000000000";
            case ins(0) is
                when '0'=>
                    ReadReg1<=REG_IH;
                    WriteReg<=("0"&ins(10 downto 8));
                when '1'=>
                    ReadReg1<=("0"&ins(10 downto 8));
                    WriteReg<=REG_IH;
                when others=>
            end case;
        when "11101"=>
            MemRead<='0';
            MemWrite<='0';
            MemToReg<='0';
            Immediate<="0000000000000000";
            case ins(3 downto 0) is
                when "0000"=>
                    ALUOp<=ALUOp_ADD;
                    ALUSrc<=ALUSrc_IMMEDIATE;
                    ReadReg2<="0000";
                    case ins(6) is
                        when '0'=>
                            PCToReg<='0';
                            RegWrite<='0';
                            PCJump<='1';
                            ReadReg1<=("0"&ins(10 downto 8));
                            WriteReg<="0000";
                        when '1'=>
                            PCToReg<='1';
                            RegWrite<='1';
                            PCJump<='0';
                            ReadReg1<="0000";
                            WriteReg<=("0"&ins(10 downto 8));
                        when others=>
                    end case;
                when "1100"=>
                    ALUOp<=ALUOp_AND;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(10 downto 8));
                    ReadReg2<=("0"&ins(7 downto 5));
                    WriteReg<=("0"&ins(10 downto 8));
                when "1010"=>
                    ALUOp<=ALUOp_SNE;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(10 downto 8));
                    ReadReg2<=("0"&ins(7 downto 5));
                    WriteReg<=REG_T;
                when "1101"=>
                    ALUOp<=ALUOp_OR;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(10 downto 8));
                    ReadReg2<=("0"&ins(7 downto 5));
                    WriteReg<=("0"&ins(10 downto 8));
                when "0010"=>
                    ALUOp<=ALUOp_SLT;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(10 downto 8));
                    ReadReg2<=("0"&ins(7 downto 5));
                    WriteReg<=REG_T;
                when "0100"=>
                    ALUOp<=ALUOp_SLL;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(7 downto 5));
                    ReadReg2<=("0"&ins(10 downto 8));
                    WriteReg<=("0"&ins(7 downto 5));
                when "0011"=>
                    ALUOp<=ALUOp_SLTU;
                    ALUSrc<=ALUSrc_REG;
                    PCToReg<='0';
                    RegWrite<='1';
                    PCJump<='0';
                    ReadReg1<=("0"&ins(10 downto 8));
                    ReadReg2<=("0"&ins(7 downto 5));
                    WriteReg<=REG_T;
                when others=>
            end case;
        when others=>
    end case;

end process;

end Behavioral;

