--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:21:02 11/23/2017
-- Design Name:   
-- Module Name:   C:/ise/RippleCPU/TestRippleCPU.vhd
-- Project Name:  RippleCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RippleCPU
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
 
ENTITY TestRippleCPU IS
END TestRippleCPU;
 
ARCHITECTURE behavior OF TestRippleCPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RippleCPU
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         outPC : OUT  std_logic_vector(15 downto 0);
         outTemp0 : OUT  std_logic_vector(15 downto 0);
         outTemp1 : OUT  std_logic_vector(15 downto 0);
         outTemp2 : OUT  std_logic_vector(15 downto 0);
         outTemp3 : OUT  std_logic_vector(15 downto 0);
         outTemp4 : OUT  std_logic_vector(15 downto 0);
         outTemp5 : OUT  std_logic_vector(15 downto 0);
         outTemp6 : OUT  std_logic_vector(15 downto 0);
         outTemp7 : OUT  std_logic_vector(15 downto 0);
         outTemp8 : OUT  std_logic_vector(15 downto 0);
         outTemp9 : OUT  std_logic_vector(15 downto 0);
         outTemp10 : OUT  std_logic_vector(15 downto 0);
         outTemp11 : OUT  std_logic_vector(15 downto 0);
         outTemp12 : OUT  std_logic_vector(15 downto 0);
         outTemp13 : OUT  std_logic_vector(15 downto 0);
         outTemp14 : OUT  std_logic_vector(15 downto 0);
         outTemp15 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '1';

 	--Outputs
   signal outPC : std_logic_vector(15 downto 0);
   signal outTemp0 : std_logic_vector(15 downto 0);
   signal outTemp1 : std_logic_vector(15 downto 0);
   signal outTemp2 : std_logic_vector(15 downto 0);
   signal outTemp3 : std_logic_vector(15 downto 0);
   signal outTemp4 : std_logic_vector(15 downto 0);
   signal outTemp5 : std_logic_vector(15 downto 0);
   signal outTemp6 : std_logic_vector(15 downto 0);
   signal outTemp7 : std_logic_vector(15 downto 0);
   signal outTemp8 : std_logic_vector(15 downto 0);
   signal outTemp9 : std_logic_vector(15 downto 0);
   signal outTemp10 : std_logic_vector(15 downto 0);
   signal outTemp11 : std_logic_vector(15 downto 0);
   signal outTemp12 : std_logic_vector(15 downto 0);
   signal outTemp13 : std_logic_vector(15 downto 0);
   signal outTemp14 : std_logic_vector(15 downto 0);
   signal outTemp15 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RippleCPU PORT MAP (
          Clk => Clk,
          Rst => Rst,
          outPC => outPC,
          outTemp0 => outTemp0,
          outTemp1 => outTemp1,
          outTemp2 => outTemp2,
          outTemp3 => outTemp3,
          outTemp4 => outTemp4,
          outTemp5 => outTemp5,
          outTemp6 => outTemp6,
          outTemp7 => outTemp7,
          outTemp8 => outTemp8,
          outTemp9 => outTemp9,
          outTemp10 => outTemp10,
          outTemp11 => outTemp11,
          outTemp12 => outTemp12,
          outTemp13 => outTemp13,
          outTemp14 => outTemp14,
          outTemp15 => outTemp15
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 120 ns;	
      Rst <= '0';
      wait for 5 ns;
      Rst <= '1';

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
