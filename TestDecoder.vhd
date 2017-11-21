--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:07:21 11/21/2017
-- Design Name:   
-- Module Name:   F:/RippleCPU/TestDecoder.vhd
-- Project Name:  RippleCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestDecoder IS
END TestDecoder;
 
ARCHITECTURE behavior OF TestDecoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         ins : IN  std_logic_vector(15 downto 0);
         ALUOp : OUT  std_logic_vector(3 downto 0);
         ALUSrc : OUT  std_logic;
         MemRead : OUT  std_logic;
         MemWrite : OUT  std_logic;
         PCToReg : OUT  std_logic;
         RegWrite : OUT  std_logic;
         MemToReg : OUT  std_logic;
         PCJump : OUT  std_logic;
         ReadReg1 : OUT  std_logic_vector(3 downto 0);
         ReadReg2 : OUT  std_logic_vector(3 downto 0);
         WriteReg : OUT  std_logic_vector(3 downto 0);
         Immediate : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ins : std_logic_vector(15 downto 0) := (others=>'0');

 	--Outputs
   signal ALUOp : std_logic_vector(3 downto 0);
   signal ALUSrc : std_logic;
   signal MemRead : std_logic;
   signal MemWrite : std_logic;
   signal PCToReg : std_logic;
   signal RegWrite : std_logic;
   signal MemToReg : std_logic;
   signal PCJump : std_logic;
   signal ReadReg1 : std_logic_vector(3 downto 0);
   signal ReadReg2 : std_logic_vector(3 downto 0);
   signal WriteReg : std_logic_vector(3 downto 0);
   signal Immediate : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          ins => ins,
          ALUOp => ALUOp,
          ALUSrc => ALUSrc,
          MemRead => MemRead,
          MemWrite => MemWrite,
          PCToReg => PCToReg,
          RegWrite => RegWrite,
          MemToReg => MemToReg,
          PCJump => PCJump,
          ReadReg1 => ReadReg1,
          ReadReg2 => ReadReg2,
          WriteReg => WriteReg,
          Immediate => Immediate
        );

   stim_proc: process
   begin
       wait for 20 ns;
       ins<="1110010001000111";
       wait for 20 ns;
       ins<="0000100000000000";
       wait for 20 ns;
       ins<="1110111100000000";
       wait for 20 ns;
       ins<="0011000011100011";
       wait for 20 ns;
       ins<="0001010101010101";
   end process;

END;
