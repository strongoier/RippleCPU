--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:29:36 11/21/2017
-- Design Name:   
-- Module Name:   F:/RippleCPU/TestALU.vhd
-- Project Name:  RippleCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
use work.Definitions.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestALU IS
END TestALU;
 
ARCHITECTURE behavior OF TestALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         in_data1 : IN  std_logic_vector(15 downto 0);
         in_data2 : IN  std_logic_vector(15 downto 0);
         ALUOp : IN  std_logic_vector(3 downto 0);
         ALUResult : OUT  std_logic_vector(15 downto 0);
         Branch : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in_data1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in_data2 : std_logic_vector(15 downto 0) := (others => '0');
   signal ALUOp : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALUResult : std_logic_vector(15 downto 0);
   signal Branch : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          in_data1 => in_data1,
          in_data2 => in_data2,
          ALUOp => ALUOp,
          ALUResult => ALUResult,
          Branch => Branch
        );
        
   -- Stimulus process
   stim_proc: process
   begin		
      in_data1<="0101010101010110";
      in_data2<="1010101010101010";
      ALUOp<=ALUOp_ADD;
      wait for clk_period;
      ALUOp<=ALUOp_AND;
      wait for clk_period;
      ALUOp<=ALUOp_SUB;
      wait for clk_period;
      ALUOp<=ALUOp_OR;
      wait for clk_period;
      ALUOp<=ALUOp_BEQZ;
      wait for clk_period;
      ALUOp<=ALUOp_BNEZ;
      wait for clk_period;
      ALUOp<=ALUOp_BNOP;
      wait for clk_period;
      ALUOp<=ALUOp_SNE;
      wait for clk_period;
      ALUOp<=ALUOp_SLT;
      wait for clk_period;
      ALUOp<=ALUOp_SLTU;
      wait for clk_period;
      in_data1<="1010101010101010";
      in_data2<="0000000000001000";
      ALUOp<=ALUOp_SLL;
      wait for clk_period;
      ALUOp<=ALUOp_SRA;
      wait for clk_period;
   end process;

END;
