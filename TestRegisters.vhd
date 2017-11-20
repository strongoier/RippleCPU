--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:25:09 11/20/2017
-- Design Name:   
-- Module Name:   C:/ise/RippleCPU/TestRegisters.vhd
-- Project Name:  RippleCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Registers
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
 
ENTITY TestRegisters IS
END TestRegisters;
 
ARCHITECTURE behavior OF TestRegisters IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Registers
    PORT(
         Clk : IN  std_logic;
         RegWrite : IN  std_logic;
         ReadRegister1 : IN  std_logic_vector(3 downto 0);
         ReadRegister2 : IN  std_logic_vector(3 downto 0);
         WriteRegister : IN  std_logic_vector(3 downto 0);
         WriteData : IN  std_logic_vector(15 downto 0);
         ReadData1 : OUT  std_logic_vector(15 downto 0);
         ReadData2 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal RegWrite : std_logic := '0';
   signal ReadRegister1 : std_logic_vector(3 downto 0) := (others => '0');
   signal ReadRegister2 : std_logic_vector(3 downto 0) := (others => '0');
   signal WriteRegister : std_logic_vector(3 downto 0) := (others => '0');
   signal WriteData : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ReadData1 : std_logic_vector(15 downto 0);
   signal ReadData2 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Registers PORT MAP (
          Clk => Clk,
          RegWrite => RegWrite,
          ReadRegister1 => ReadRegister1,
          ReadRegister2 => ReadRegister2,
          WriteRegister => WriteRegister,
          WriteData => WriteData,
          ReadData1 => ReadData1,
          ReadData2 => ReadData2
        );

   -- Stimulus process
   stim_proc: process
   begin
      Clk <= '0';
      wait for Clk_period/2;
      Clk <= '1';
      RegWrite <= '1';
      WriteRegister <= "1010";
      WriteData <= "1010101010101010";
      ReadRegister1 <= "1010";
      wait for Clk_period/2;
      Clk <= '0';
      wait for Clk_period/2;
      Clk <= '1';
      WriteRegister <= "1011";
      WriteData <= "1010101010101010";
      ReadRegister2 <= "1011";
      wait for Clk_period/2;
      Clk <= '0';
      wait;
   end process;

END;
