--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:38:37 11/28/2017
-- Design Name:   
-- Module Name:   F:/RippleCPU/TestVGA.vhd
-- Project Name:  RippleCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: VGA
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
 
ENTITY TestVGA IS
END TestVGA;
 
ARCHITECTURE behavior OF TestVGA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT VGA
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         in_text : IN  std_logic_vector(29 downto 0);
         Data : IN  std_logic_vector(9 downto 0);
         Addr : OUT  std_logic_vector(13 downto 0);
         Red : OUT  std_logic_vector(2 downto 0);
         Green : OUT  std_logic_vector(2 downto 0);
         Blue : OUT  std_logic_vector(2 downto 0);
         Hs : OUT  std_logic;
         Vs : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal in_text : std_logic_vector(29 downto 0) := (others => '0');
   signal Data : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal Addr : std_logic_vector(13 downto 0);
   signal Red : std_logic_vector(2 downto 0);
   signal Green : std_logic_vector(2 downto 0);
   signal Blue : std_logic_vector(2 downto 0);
   signal Hs : std_logic;
   signal Vs : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: VGA PORT MAP (
          clk => clk,
          rst => rst,
          in_text => in_text,
          Data => Data,
          Addr => Addr,
          Red => Red,
          Green => Green,
          Blue => Blue,
          Hs => Hs,
          Vs => Vs
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
