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
use work.Definitions.all;

package Components is

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
    component Reg
        port (
            Clk: in std_logic;
            Flush: in std_logic;
            WriteEnable: in std_logic;
            DataIn: in std_logic;
            DataOut: out std_logic := '0'
        );
    end component;
    component RegVector4 is
        generic (
            DataInitial: std_logic_vector(3 downto 0)
        );
        port (
            Clk: in std_logic;
            Flush: in std_logic;
            WriteEnable: in std_logic;
            DataIn: in std_logic_vector(3 downto 0);
            DataOut: out std_logic_vector(3 downto 0) := DataInitial
        );
    end component;
    component RegVector16 is
        generic (
            DataInitial: std_logic_vector(15 downto 0)
        );
        port (
            Clk: in std_logic;
            Flush: in std_logic;
            WriteEnable: in std_logic;
            DataIn: in std_logic_vector(15 downto 0);
            DataOut: out std_logic_vector(15 downto 0) := DataInitial
        );
    end component;
    component FakeMemory is
        port (
            MemRead: in std_logic;
            MemWrite: in std_logic;
            Address: in std_logic_vector(15 downto 0);
            WriteData: in std_logic_vector(15 downto 0);
            ReadData: out std_logic_vector(15 downto 0)
        );
    end component;
    component Memory is
        port (
            Clk: in std_logic;
            MemRead: in std_logic;
            MemWrite: in std_logic;
            Address: in std_logic_vector(15 downto 0);
            WriteData: in std_logic_vector(15 downto 0);
            ReadData: out std_logic_vector(15 downto 0);
            OE: out std_logic;
            WE: out std_logic;
            EN: out std_logic;
            RamAddr: out std_logic_vector(17 downto 0);
            RamData: inout std_logic_vector(15 downto 0)
        );
    end component;
    component Decoder is
        port (
            ins       : in  STD_LOGIC_VECTOR (15 downto 0);
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
            Immediate : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    component Registers is
        port (
            Clk: in std_logic;
            RegWrite: in std_logic;
            ReadRegister1: in std_logic_vector(3 downto 0);
            ReadRegister2: in std_logic_vector(3 downto 0);
            WriteRegister: in std_logic_vector(3 downto 0);
            WriteData: in std_logic_vector(15 downto 0);
            ReadData1: out std_logic_vector(15 downto 0);
            ReadData2: out std_logic_vector(15 downto 0);
            outTemp: out RegisterArrayType
        );
    end component;
    component ALU is
        port (
            in_data1 : in  STD_LOGIC_VECTOR (15 downto 0);
            in_data2 : in  STD_LOGIC_VECTOR (15 downto 0);
            ALUOp : in  STD_LOGIC_VECTOR (3 downto 0);
            ALUResult : out  STD_LOGIC_VECTOR (15 downto 0);
            Branch : out  STD_LOGIC
        );
    end component;

end Components;

package body Components is

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
 
end Components;
