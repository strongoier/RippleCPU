library ieee;
use ieee.std_logic_1164.all;
use work.Definitions.all;

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
    --- Clk
    ---

    component ClkGen is
       port ( CLKIN_IN        : in    std_logic; 
              CLKFX_OUT       : out   std_logic; 
              CLKIN_IBUFG_OUT : out   std_logic; 
              CLK0_OUT        : out   std_logic);
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


    ---
    --- External Devices
    ---

    component Keyboard is
        port (
            KeyboardData: in std_logic;
            KeyboardClk: in std_logic;
            FilterClk5M: in std_logic;
            KeyboardOut: out std_logic_vector(7 downto 0)
        );
    end component;

    component CharPicROM is
        port (
            clka : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    end component;
    
    component VGARAM is
        port (
            clka : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            clkb : IN STD_LOGIC;
            addrb : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;
    
    component VGA is
        port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            PicData : in STD_LOGIC_VECTOR (9 downto 0);
            CharData : in STD_LOGIC_VECTOR (7 downto 0);
            Pos : in STD_LOGIC_VECTOR (11 downto 0);
            CharAddr : out STD_LOGIC_VECTOR (11 downto 0);
            PicAddr : out STD_LOGIC_VECTOR (13 downto 0);
            Red : out  STD_LOGIC_VECTOR (2 downto 0);
            Green : out  STD_LOGIC_VECTOR (2 downto 0);
            Blue : out  STD_LOGIC_VECTOR (2 downto 0);
            Hs : out  STD_LOGIC;
            Vs : out  STD_LOGIC
        );
    end component;

end Components;

package body Components is
end Components;
