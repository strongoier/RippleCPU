library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Definitions.all;
use work.Components.all;

entity RippleCPU is
    port (
        Clk: in std_logic;
        outPC: out std_logic_vector(15 downto 0);
        outTemp0: out std_logic_vector(15 downto 0);
        outTemp1: out std_logic_vector(15 downto 0);
        outTemp2: out std_logic_vector(15 downto 0);
        outTemp3: out std_logic_vector(15 downto 0);
        outTemp4: out std_logic_vector(15 downto 0);
        outTemp5: out std_logic_vector(15 downto 0);
        outTemp6: out std_logic_vector(15 downto 0);
        outTemp7: out std_logic_vector(15 downto 0);
        outTemp8: out std_logic_vector(15 downto 0);
        outTemp9: out std_logic_vector(15 downto 0);
        outTemp10: out std_logic_vector(15 downto 0);
        outTemp11: out std_logic_vector(15 downto 0);
        outTemp12: out std_logic_vector(15 downto 0);
        outTemp13: out std_logic_vector(15 downto 0);
        outTemp14: out std_logic_vector(15 downto 0);
        outTemp15: out std_logic_vector(15 downto 0)
    );
end RippleCPU;

architecture Behavioral of RippleCPU is
    --test
    signal outTemp: RegisterArrayType;
    -- PC
    signal PCWrite: std_logic;
    signal PC: std_logic_vector(15 downto 0);
    signal PCDataIn: std_logic_vector(15 downto 0);
    -- IF
    signal IF_PC: std_logic_vector(15 downto 0);
    signal IF_Instruction: std_logic_vector(15 downto 0);
    -- IF2ID
    signal IF2ID_Flush: std_logic;
    signal IF2ID_Write: std_logic;
    signal IF2ID_Instruction: std_logic_vector(15 downto 0);
    signal IF2ID_PC: std_logic_vector(15 downto 0);
    -- ID
    signal ID_RegWrite: std_logic;
    signal ID_MemToReg: std_logic;
    signal ID_MemRead: std_logic;
    signal ID_MemWrite: std_logic;
    signal ID_PCToReg: std_logic;
    signal ID_PCJump: std_logic;
    signal ID_ALUSrc: std_logic;
    signal ID_ALUOp: std_logic_vector(3 downto 0);
    signal ID_ReadData1: std_logic_vector(15 downto 0);
    signal ID_ReadData2: std_logic_vector(15 downto 0);
    signal ID_ExtendedImmediate: std_logic_vector(15 downto 0);
    signal ID_ReadRegister1: std_logic_vector(3 downto 0);
    signal ID_ReadRegister2: std_logic_vector(3 downto 0);
    signal ID_WriteRegister: std_logic_vector(3 downto 0);
    -- ID2EX
    signal ID2EX_Flush: std_logic;
    signal ID2EX_RegWrite: std_logic;
    signal ID2EX_MemToReg: std_logic;
    signal ID2EX_MemRead: std_logic;
    signal ID2EX_MemWrite: std_logic;
    signal ID2EX_PCToReg: std_logic;
    signal ID2EX_PCJump: std_logic;
    signal ID2EX_ALUSrc: std_logic;
    signal ID2EX_ALUOp: std_logic_vector(3 downto 0);
    signal ID2EX_ReadData1: std_logic_vector(15 downto 0);
    signal ID2EX_ReadData2: std_logic_vector(15 downto 0);
    signal ID2EX_PC: std_logic_vector(15 downto 0);
    signal ID2EX_ExtendedImmediate: std_logic_vector(15 downto 0);
    signal ID2EX_ReadRegister1: std_logic_vector(3 downto 0);
    signal ID2EX_ReadRegister2: std_logic_vector(3 downto 0);
    signal ID2EX_WriteRegister: std_logic_vector(3 downto 0);
    -- EX
    signal EX_Forward1Result: std_logic_vector(15 downto 0);
    signal EX_Forward2Result: std_logic_vector(15 downto 0);
    signal EX_ALUDataIn2: std_logic_vector(15 downto 0);
    signal EX_ALUResult: std_logic_vector(15 downto 0);
    signal EX_PCBranch: std_logic;
    -- EX2MEM
    signal EX2MEM_RegWrite: std_logic;
    signal EX2MEM_MemToReg: std_logic;
    signal EX2MEM_MemRead: std_logic;
    signal EX2MEM_MemWrite: std_logic;
    signal EX2MEM_PCToReg: std_logic;
    signal EX2MEM_ALUResult: std_logic_vector(15 downto 0);
    signal EX2MEM_Forward2Result: std_logic_vector(15 downto 0);
    signal EX2MEM_PC: std_logic_vector(15 downto 0);
    signal EX2MEM_WriteRegister: std_logic_vector(3 downto 0);
    -- MEM
    signal MEM_ReadDataFromMem: std_logic_vector(15 downto 0);
    signal MEM_WriteDataToReg: std_logic_vector(15 downto 0);
    -- MEM2WB
    signal MEM2WB_RegWrite: std_logic;
    signal MEM2WB_MemToReg: std_logic;
    signal MEM2WB_ReadDataFromMem: std_logic_vector(15 downto 0);
    signal MEM2WB_WriteDataToReg: std_logic_vector(15 downto 0);
    signal MEM2WB_WriteRegister: std_logic_vector(3 downto 0);
    -- WB
    signal WB_WriteDataToReg: std_logic_vector(15 downto 0);
    -- Forwarding
    signal Forward1: std_logic_vector(1 downto 0);
    signal Forward2: std_logic_vector(1 downto 0);
begin

    --test
    outPC <= PC;
    outTemp0 <= outTemp(0);
    outTemp1 <= outTemp(1);
    outTemp2 <= outTemp(2);
    outTemp3 <= outTemp(3);
    outTemp4 <= outTemp(4);
    outTemp5 <= outTemp(5);
    outTemp6 <= outTemp(6);
    outTemp7 <= outTemp(7);
    outTemp8 <= outTemp(8);
    outTemp9 <= outTemp(9);
    outTemp10 <= outTemp(10);
    outTemp11 <= outTemp(11);
    outTemp12 <= outTemp(12);
    outTemp13 <= outTemp(13);
    outTemp14 <= outTemp(14);
    outTemp15 <= outTemp(15);

    -- PC
    PCDataIn <= EX_Forward1Result when ID2EX_PCJump = '1' else
                ID2EX_PC + ID2EX_ExtendedImmediate when EX_PCBranch = '1' else
                PC + 1;
    cPC: RegVector generic map(16) port map(Clk, '0', PCWrite, ZERO_16, PCDataIn, PC);
    -- IF
    IF_PC <= PC + 1;
    cInstructionMemory: FakeMemory port map('1', '0', PC, ZERO_16, IF_Instruction);
    cIF2ID_PC: RegVector generic map(16) port map(Clk, IF2ID_Flush, IF2ID_Write, ZERO_16, IF_PC, IF2ID_PC);
    cIF2ID_Instruction: RegVector generic map(16) port map(Clk, IF2ID_Flush, IF2ID_Write, INSTRUCTION_NOP, IF_Instruction, IF2ID_Instruction);
    -- ID
    cDecoder: Decoder port map(IF2ID_Instruction, ID_ALUOp, ID_ALUSrc, ID_MemRead, ID_MemWrite, ID_PCToReg, ID_RegWrite, ID_MemToReg, ID_PCJump, ID_ReadRegister1, ID_ReadRegister2, ID_WriteRegister, ID_ExtendedImmediate);
    cRegisters: Registers port map(Clk, MEM2WB_RegWrite, ID_ReadRegister1, ID_ReadRegister2, MEM2WB_WriteRegister, WB_WriteDataToReg, ID_ReadData1, ID_ReadData2, outTemp);
    cID2EX_RegWrite: Reg port map(Clk, ID2EX_Flush, '1', ID_RegWrite, ID2EX_RegWrite);
    cID2EX_MemToReg: Reg port map(Clk, ID2EX_Flush, '1', ID_MemToReg, ID2EX_MemToReg);
    cID2EX_MemRead: Reg port map(Clk, ID2EX_Flush, '1', ID_MemRead, ID2EX_MemRead);
    cID2EX_MemWrite: Reg port map(Clk, ID2EX_Flush, '1', ID_MemWrite, ID2EX_MemWrite);
    cID2EX_PCToReg: Reg port map(Clk, ID2EX_Flush, '1', ID_PCToReg, ID2EX_PCToReg);
    cID2EX_PCJump: Reg port map(Clk, ID2EX_Flush, '1', ID_PCJump, ID2EX_PCJump);
    cID2EX_ALUSrc: Reg port map(Clk, ID2EX_Flush, '1', ID_ALUSrc, ID2EX_ALUSrc);
    cID2EX_ALUOp: RegVector generic map(4) port map(Clk, ID2EX_Flush, '1', ALUOp_ADD, ID_ALUOp, ID2EX_ALUOp);
    cID2EX_ReadData1: RegVector generic map(16) port map(Clk, ID2EX_Flush, '1', ZERO_16, ID_ReadData1, ID2EX_ReadData1);
    cID2EX_ReadData2: RegVector generic map(16) port map(Clk, ID2EX_Flush, '1', ZERO_16, ID_ReadData2, ID2EX_ReadData2);
    cID2EX_PC: RegVector generic map(16) port map(Clk, ID2EX_Flush, '1', ZERO_16, IF2ID_PC, ID2EX_PC);
    cID2EX_ExtendedImmediate: RegVector generic map(16) port map(Clk, ID2EX_Flush, '1', ZERO_16, ID_ExtendedImmediate, ID2EX_ExtendedImmediate);
    cID2EX_ReadRegister1: RegVector generic map(4) port map(Clk, ID2EX_Flush, '1', ZERO_4, ID_ReadRegister1, ID2EX_ReadRegister1);
    cID2EX_ReadRegister2: RegVector generic map(4) port map(Clk, ID2EX_Flush, '1', ZERO_4, ID_ReadRegister2, ID2EX_ReadRegister2);
    cID2EX_WriteRegister: RegVector generic map(4) port map(Clk, ID2EX_Flush, '1', ZERO_4, ID_WriteRegister, ID2EX_WriteRegister);
    -- EX
    EX_Forward1Result <= EX2MEM_ALUResult when Forward1 = FORWARD_EX2MEM else
                         WB_WriteDataToReg when Forward1 = FORWARD_MEM2WB else
                         ID2EX_ReadData1;
    EX_Forward2Result <= EX2MEM_ALUResult when Forward2 = FORWARD_EX2MEM else
                         WB_WriteDataToReg when Forward2 = FORWARD_MEM2WB else
                         ID2EX_ReadData2;
    EX_ALUDataIn2 <= ID2EX_ExtendedImmediate when ID2EX_ALUSrc = ALUSrc_Immediate else EX_Forward2Result;
    cALU: ALU port map(EX_Forward1Result, EX_ALUDataIn2, ID2EX_ALUOp, EX_ALUResult, EX_PCBranch);
    cEX2MEM_RegWrite: Reg port map(Clk, '0', '1', ID2EX_RegWrite, EX2MEM_RegWrite);
    cEX2MEM_MemToReg: Reg port map(Clk, '0', '1', ID2EX_MemToReg, EX2MEM_MemToReg);
    cEX2MEM_MemRead: Reg port map(Clk, '0', '1', ID2EX_MemRead, EX2MEM_MemRead);
    cEX2MEM_MemWrite: Reg port map(Clk, '0', '1', ID2EX_MemWrite, EX2MEM_MemWrite);
    cEX2MEM_PCToReg: Reg port map(Clk, '0', '1', ID2EX_PCToReg, EX2MEM_PCToReg);
    cEX2MEM_ALUResult: RegVector generic map(16) port map(Clk, '0', '1', ZERO_16, EX_ALUResult, EX2MEM_ALUResult);
    cEX2MEM_Forward2Result: RegVector generic map(16) port map(Clk, '0', '1', ZERO_16, EX_Forward2Result, EX2MEM_Forward2Result);
    cEX2MEM_PC: RegVector generic map(16) port map(Clk, '0', '1', ZERO_16, ID2EX_PC, EX2MEM_PC);
    cEX2MEM_WriteRegister: RegVector generic map(4) port map(Clk, '0', '1', ZERO_4, ID2EX_WriteRegister, EX2MEM_WriteRegister);
    -- MEM
    MEM_WriteDataToReg <= EX2MEM_PC when EX2MEM_PCToReg = '1' else EX2MEM_ALUResult;
    cDataMemory: FakeMemory port map(EX2MEM_MemRead, EX2MEM_MemWrite, EX2MEM_ALUResult, EX2MEM_Forward2Result, MEM_ReadDataFromMem);
    cMEM2WB_RegWrite: Reg port map(Clk, '0', '1', EX2MEM_RegWrite, MEM2WB_RegWrite);
    cMEM2WB_MemToReg: Reg port map(Clk, '0', '1', EX2MEM_MemToReg, MEM2WB_MemToReg);
    cMEM2WB_ReadDataFromMem: RegVector generic map(16) port map(Clk, '0', '1', ZERO_16, MEM_ReadDataFromMem, MEM2WB_ReadDataFromMem);
    cMEM2WB_WriteDataToReg: RegVector generic map(16) port map(Clk, '0', '1', ZERO_16, MEM_WriteDataToReg, MEM2WB_WriteDataToReg);
    cMEM2WB_WriteRegister: RegVector generic map(4) port map(Clk, '0', '1', ZERO_4, EX2MEM_WriteRegister, MEM2WB_WriteRegister);
    -- WB
    WB_WriteDataToReg <= MEM2WB_ReadDataFromMem when MEM2WB_MemToReg = '1' else
                         MEM2WB_WriteDataToReg;
    -- Forwarding & HazardDetection (Data)
    cForwarding: Forwarding port map(ID2EX_ReadRegister1, ID2EX_ReadRegister2, EX2MEM_RegWrite, EX2MEM_WriteRegister, MEM2WB_RegWrite, MEM2WB_WriteRegister, Forward1, Forward2);
    cHazardDetection: HazardDetection port map(ID_ReadRegister1, ID_ReadRegister2, ID2EX_MemRead, ID2EX_WriteRegister, PCWrite, IF2ID_Write, ID2EX_Flush);
    -- HazardDetection (Control)
    IF2ID_Flush <= ID2EX_PCJump or EX_PCBranch;
end Behavioral;
