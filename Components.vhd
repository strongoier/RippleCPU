library ieee;
use ieee.std_logic_1164.all;

package Components is

    ---
    --- Debug
    ---

    component Digital7 is
        port (
            key: in std_logic_vector(3 downto 0);
            display: out std_logic_vector(6 downto 0)
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


    ---
    --- Regs
    ---

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


    ---
    --- Main components
    ---

    component Registers is
        port (
            Clk: in std_logic;
            RegWrite: in std_logic;
            ReadRegister1: in std_logic_vector(3 downto 0);
            ReadRegister2: in std_logic_vector(3 downto 0);
            WriteRegister: in std_logic_vector(3 downto 0);
            WriteData: in std_logic_vector(15 downto 0);
            ReadData1: out std_logic_vector(15 downto 0);
            ReadData2: out std_logic_vector(15 downto 0)
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

    component ALU is
        port (
            in_data1  : in  STD_LOGIC_VECTOR (15 downto 0);
            in_data2  : in  STD_LOGIC_VECTOR (15 downto 0);
            ALUOp     : in  STD_LOGIC_VECTOR (3 downto 0);
            ALUResult : out STD_LOGIC_VECTOR (15 downto 0);
            Branch    : out STD_LOGIC
        );
    end component;

end Components;

package body Components is
end Components;
