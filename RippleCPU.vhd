library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.Definitions.all;
use work.Components.all;

entity RippleCPU is
    port (
        Clk50M: in std_logic;
        Clk11M: in std_logic;
        ClkHand: in std_logic;
--        KeyboardClk: in std_logic;
--        KeyboardData: in std_logic;
        Rst: in std_logic;
        TBRE: in std_logic;
        TSRE: in std_logic;
        DataReady: in std_logic;
        WRN: out std_logic;
        RDN: out std_logic;
        Ram1OE: out std_logic;
        Ram1WE: out std_logic;
        Ram1EN: out std_logic;
        Ram1Addr: out std_logic_vector(17 downto 0);
        Ram1Data: inout std_logic_vector(15 downto 0);
        Ram2OE: out std_logic;
        Ram2WE: out std_logic;
        Ram2EN: out std_logic;
        Ram2Addr: out std_logic_vector(17 downto 0);
        Ram2Data: inout std_logic_vector(15 downto 0);
        FlashByte: out std_logic;
        FlashVpen: out std_logic;
        FlashCE: out std_logic;
        FlashOE: out std_logic := '1';
        FlashWE: out std_logic := '1';
        FlashRP: out std_logic;
        FlashAddr: out std_logic_vector(22 downto 0);
        FlashData: inout std_logic_vector(15 downto 0);
        Red: out std_logic_vector(2 downto 0);
        Green: out std_logic_vector(2 downto 0);
        Blue: out std_logic_vector(2 downto 0);
        Hs: out std_logic;
        Vs: out std_logic;
        DYP1: out std_logic_vector(6 downto 0);
        DYP0: out std_logic_vector(6 downto 0);
        L: out std_logic_vector(15 downto 0)
    );
end RippleCPU;

architecture Behavioral of RippleCPU is
    -- Clk 
    signal Clk50MBuf: std_logic;
    signal Clk200M: std_logic;
    signal ClkMagic: std_logic := '1';
    signal ClkSerial: std_logic := '1';
    signal Clk25M: std_logic;
    signal Clk12p5M: std_logic;
    signal Clk6p25M: std_logic;
    signal Clk5M: std_logic;
    signal Clk: std_logic;
    -- Boot
    signal Booted: std_logic := '0';
    signal NextRam2Addr: std_logic_vector(17 downto 0) := (others => '0');
    -- Global
    signal Global_Flush: std_logic := '1';
    -- PC
    signal PCWrite: std_logic;
    signal PCDataIn: std_logic_vector(15 downto 0);
    signal PC: std_logic_vector(15 downto 0);
    -- IF
    signal IF_Instruction: std_logic_vector(15 downto 0);
    signal IF_PC: std_logic_vector(15 downto 0);
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
    signal ID2EX_ExtendedImmediate: std_logic_vector(15 downto 0);
    signal ID2EX_ReadRegister1: std_logic_vector(3 downto 0);
    signal ID2EX_ReadRegister2: std_logic_vector(3 downto 0);
    signal ID2EX_WriteRegister: std_logic_vector(3 downto 0);
    signal ID2EX_PC: std_logic_vector(15 downto 0);
    -- EX
    signal EX_Forward1Result: std_logic_vector(15 downto 0);
    signal EX_Forward2Result: std_logic_vector(15 downto 0);
    signal EX_ALUDataIn2: std_logic_vector(15 downto 0);
    signal EX_ALUResult: std_logic_vector(15 downto 0);
    signal EX_PCBranch: std_logic;
    -- EX2MEM
    signal EX2MEM_Flush: std_logic;
    signal EX2MEM_Forward2Result: std_logic_vector(15 downto 0);
    signal EX2MEM_ALUResult: std_logic_vector(15 downto 0);
    signal EX2MEM_RegWrite: std_logic;
    signal EX2MEM_MemToReg: std_logic;
    signal EX2MEM_MemRead: std_logic;
    signal EX2MEM_MemWrite: std_logic;
    signal EX2MEM_PCToReg: std_logic;
    signal EX2MEM_WriteRegister: std_logic_vector(3 downto 0);
    signal EX2MEM_PC: std_logic_vector(15 downto 0);
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
    -- Data Forwarding
    signal Forward1: std_logic_vector(1 downto 0);
    signal Forward2: std_logic_vector(1 downto 0);
    -- Hazard Detection
    signal DataHazardDetected: std_logic;
    signal ControlHazardDetected: std_logic;
    signal ArchitectureHazardDetected: std_logic;
	-- Keyboard
    signal KeyboardOut: std_logic_vector(7 downto 0);
    -- VGA
    signal ROMAddr: std_logic_vector(13 downto 0);
    signal VGAData: std_logic_vector(9 downto 0);
    signal text: matrix;
begin
    ---
    --- Debug
    ---

    cDigital7_Low: Digital7 port map(PC(3 downto 0), DYP1);
    cDigital7_High: Digital7 port map(PC(7 downto 4), DYP0);
    L <= IF_Instruction;

    process (Rst)
    begin
        for i in 0 to 29 loop
            for j in 0 to 79 loop
                text(i)(j) <= std_logic_vector(to_unsigned(i + 1, 8));
            end loop;
        end loop;
    end process;

    -- 
    -- Clk
    --

    cClkGen: ClkGen port map(CLKIN_IN => Clk50M, CLKFX_OUT => Clk200M, CLKIN_IBUFG_OUT => Clk50MBuf);

    --Clk <= Clk6p25M when Booted = '0' else ClkHand;
    Clk <= Clk6p25M when Booted = '0' else ClkMagic;

    DivideClkMagic: process (Clk200M)
        variable Count: integer := 0;
    begin
        if rising_edge(Clk200M) then
            Count := Count + 1;
            if Count = 1 then
                ClkMagic <= '0';
                ClkSerial <= '0';
            elsif Count = 2 then
                ClkSerial <= '1';
            elsif Count = 4 then
                ClkMagic <= '1';
                Count := 0;
            end if;
        end if;
    end process;

    DivideClk25M: process (Clk50MBuf)
    begin
        if rising_edge(Clk50MBuf) then
            Clk25M <= not Clk25M;
        end if;
    end process;

    DivideClk12p5M: process (Clk25M)
    begin
        if rising_edge(Clk25M) then
            Clk12p5M <= not Clk12p5M;
        end if;
    end process;

    DivideClk6p25M: process (Clk12p5M)
    begin
        if rising_edge(Clk12p5M) then
            Clk6p25M <= not Clk6p25M;
        end if;
    end process;

    DivideClk5M: process (Clk50MBuf)
        variable Count: integer :=0;
    begin
        if rising_edge(Clk50MBuf) then
            Count := Count + 1;
            if Count = 5 then
                Clk5M <= not Clk5M;
                Count := 0;
            end if;
        end if;
    end process;


    ---
    --- External Devices
    ---

    cVGA: VGA port map(Clk25M, Rst, text, VGAData, ROMAddr, Red, Green, Blue, Hs, Vs);
    cCharPicROM: CharPicROM port map(Clk50MBuf, ROMAddr, VGAData);
    --cKeyBoard: Keyboard port map(KeyboardData, KeyboardClk, Clk5M, KeyboardOut);


    ---
    --- Boot From Flash
    ---

    FlashByte <= '1';
    FlashVpen <= '1';
    FlashCE <= '0';
    FlashRP <= '1';

    BootFromFlash: process (Clk6p25M, Rst)
        variable Status: integer := 0;
        variable Count: integer := 0;
        variable NextFlashAddr: std_logic_vector(22 downto 0) := (others => '0');
    begin
        if Rst = '0' then
            Booted <= '0';
            FlashOE <= '1';
            FlashWE <= '1';
            NextFlashAddr := (others => '0');
            NextRam2Addr <= (others => '0');
            Count := 0;
            Status := 0;
        elsif rising_edge(Clk6p25M) and Booted = '0' then
            case Status is
                when 0 =>
                    FlashWE <= '0';
                    FlashData <= "0000000011111111";
                    Status := 1;
                when 1 =>
                    FlashWE <= '1';
                    Status := 2;
                when 2 =>
                    FlashAddr <= NextFlashAddr;
                    FlashData <= (others => 'Z');
                    FlashOE <= '0';
                    Status := 3;
                when 3 =>
                    FlashOE <= '1';
                    Status := 4;
                when 4 =>
                    NextRam2Addr <= NextRam2Addr + 1;
                    NextFlashAddr := NextFlashAddr + 2;
                    FlashAddr <= NextFlashAddr;
                    FlashData <= (others => 'Z');
                    FlashOE <= '0';
                    Count := Count + 1;
                    if Count < COUNT_INSTRUCTION then
                        Status := 3;
                    else
                        Status := 5;
                    end if;
                when 5 =>
                    FlashOE <= '1';
                    Booted <= '1';
                when others =>
            end case;
        end if;
    end process;


    ---
    --- Ram2: Instruction Memory
    ---

    Ram2OE <= Clk or not Booted or (ArchitectureHazardDetected and EX2MEM_MemWrite);
    Ram2WE <= Clk or (Booted and not(ArchitectureHazardDetected and EX2MEM_MemWrite));
    Ram2EN <= '0';
    Ram2Addr <= NextRam2Addr when Booted = '0' else
                "00" & EX2MEM_ALUResult when ArchitectureHazardDetected = '1' else
                "00" & PC;
    Ram2Data <= FlashData when Booted = '0' else
                EX2MEM_Forward2Result when ArchitectureHazardDetected = '1' and EX2MEM_MemWrite = '1' else
                (others => 'Z');
    IF_Instruction <= Ram2Data;


    ---
    --- Ram1: Data Memory & Serial Port
    ---

    Ram1: process (Clk, ClkSerial, Booted, EX2MEM_ALUResult, EX2MEM_MemRead, EX2MEM_MemWrite, EX2MEM_Forward2Result, ArchitectureHazardDetected, Ram2Data, DataReady, TBRE, TSRE)
    begin
        if EX2MEM_ALUResult = "1011111100000001" then
            Ram1OE <= '1';
            Ram1WE <= '1';
            Ram1EN <= '1';
            Ram1Addr <= (others => '0');
            Ram1Data <= (others => 'Z');
            MEM_ReadDataFromMem <= "00000000000000" & DataReady & (TBRE and TSRE);
            RDN <= '1';
            WRN <= '1';
        elsif EX2MEM_ALUResult = "1011111100000000" then
            Ram1OE <= '1';
            Ram1WE <= '1';
            Ram1EN <= '1';
            Ram1Addr <= (others => '0');
            if EX2MEM_MemWrite = '1' then
                Ram1Data <= EX2MEM_Forward2Result;
            else
                Ram1Data <= (others => 'Z');
            end if;
            MEM_ReadDataFromMem <= Ram1Data;
            RDN <= Clk or not Booted or not EX2MEM_MemRead;
            WRN <= ClkSerial or not Booted or not EX2MEM_MemWrite;
        else
            Ram1OE <= Clk or not Booted or ArchitectureHazardDetected or not EX2MEM_MemRead;
            Ram1WE <= Clk or not Booted or ArchitectureHazardDetected or not EX2MEM_MemWrite;
            Ram1EN <= '0';
            Ram1Addr <= "00" & EX2MEM_ALUResult;
            if ArchitectureHazardDetected = '0' and EX2MEM_MemWrite = '1' then
                Ram1Data <= EX2MEM_Forward2Result;
            else
                Ram1Data <= (others => 'Z');
            end if;
            if ArchitectureHazardDetected = '1' then
                MEM_ReadDataFromMem <= Ram2Data;
            else
                MEM_ReadDataFromMem <= Ram1Data;
            end if;
            RDN <= '1';
            WRN <= '1';
        end if;
    end process;


    ---
    --- PC
    ---

    PCWrite <= (not DataHazardDetected) or ArchitectureHazardDetected;
    PCDataIn <= PC - 2 when ArchitectureHazardDetected = '1' else
                EX_Forward1Result when ID2EX_PCJump = '1' else
                ID2EX_PC + ID2EX_ExtendedImmediate when EX_PCBranch = '1' else
                PC + 1;
    cPC: RegVector16 generic map(PC_INITIAL) port map(Clk, Global_Flush, PCWrite, PCDataIn, PC);


    ---
    --- IF
    ---

    IF_PC <= PC + 1;


    ---
    --- IF2ID
    ---

    IF2ID_Flush <= ControlHazardDetected or ArchitectureHazardDetected or Global_Flush;
    IF2ID_Write <= not DataHazardDetected;
    cIF2ID_Instruction: RegVector16 generic map(INSTRUCTION_NOP) port map(Clk, IF2ID_Flush, IF2ID_Write, IF_Instruction, IF2ID_Instruction);
    cIF2ID_PC: RegVector16 generic map(PC_INITIAL) port map(Clk, IF2ID_Flush, IF2ID_Write, IF_PC, IF2ID_PC);


    ---
    --- ID
    ---

    cDecoder: Decoder port map(IF2ID_Instruction, ID_ALUOp, ID_ALUSrc, ID_MemRead, ID_MemWrite, ID_PCToReg, ID_RegWrite, ID_MemToReg, ID_PCJump, ID_ReadRegister1, ID_ReadRegister2, ID_WriteRegister, ID_ExtendedImmediate);
    cRegisters: Registers port map(Clk, MEM2WB_RegWrite, ID_ReadRegister1, ID_ReadRegister2, MEM2WB_WriteRegister, WB_WriteDataToReg, ID_ReadData1, ID_ReadData2);


    ---
    --- ID2EX
    ---

    ID2EX_Flush <= DataHazardDetected or ArchitectureHazardDetected or Global_Flush;
    cID2EX_RegWrite: Reg port map(Clk, ID2EX_Flush, '1', ID_RegWrite, ID2EX_RegWrite);
    cID2EX_MemToReg: Reg port map(Clk, ID2EX_Flush, '1', ID_MemToReg, ID2EX_MemToReg);
    cID2EX_MemRead: Reg port map(Clk, ID2EX_Flush, '1', ID_MemRead, ID2EX_MemRead);
    cID2EX_MemWrite: Reg port map(Clk, ID2EX_Flush, '1', ID_MemWrite, ID2EX_MemWrite);
    cID2EX_PCToReg: Reg port map(Clk, ID2EX_Flush, '1', ID_PCToReg, ID2EX_PCToReg);
    cID2EX_PCJump: Reg port map(Clk, ID2EX_Flush, '1', ID_PCJump, ID2EX_PCJump);
    cID2EX_ALUSrc: Reg port map(Clk, ID2EX_Flush, '1', ID_ALUSrc, ID2EX_ALUSrc);
    cID2EX_ALUOp: RegVector4 generic map(ALUOp_DEFAULT) port map(Clk, ID2EX_Flush, '1', ID_ALUOp, ID2EX_ALUOp);
    cID2EX_ReadData1: RegVector16 generic map(ZERO_16) port map(Clk, ID2EX_Flush, '1', ID_ReadData1, ID2EX_ReadData1);
    cID2EX_ReadData2: RegVector16 generic map(ZERO_16) port map(Clk, ID2EX_Flush, '1', ID_ReadData2, ID2EX_ReadData2);
    cID2EX_PC: RegVector16 generic map(PC_INITIAL) port map(Clk, ID2EX_Flush, '1', IF2ID_PC, ID2EX_PC);
    cID2EX_ExtendedImmediate: RegVector16 generic map(ZERO_16) port map(Clk, ID2EX_Flush, '1', ID_ExtendedImmediate, ID2EX_ExtendedImmediate);
    cID2EX_ReadRegister1: RegVector4 generic map(REG_ZERO) port map(Clk, ID2EX_Flush, '1', ID_ReadRegister1, ID2EX_ReadRegister1);
    cID2EX_ReadRegister2: RegVector4 generic map(REG_ZERO) port map(Clk, ID2EX_Flush, '1', ID_ReadRegister2, ID2EX_ReadRegister2);
    cID2EX_WriteRegister: RegVector4 generic map(REG_ZERO) port map(Clk, ID2EX_Flush, '1', ID_WriteRegister, ID2EX_WriteRegister);


    ---
    --- EX
    ---

    EX_Forward1Result <= MEM_WriteDataToReg when Forward1 = FORWARD_EX2MEM else
                         WB_WriteDataToReg when Forward1 = FORWARD_MEM2WB else
                         ID2EX_ReadData1;
    EX_Forward2Result <= MEM_WriteDataToReg when Forward2 = FORWARD_EX2MEM else
                         WB_WriteDataToReg when Forward2 = FORWARD_MEM2WB else
                         ID2EX_ReadData2;
    EX_ALUDataIn2 <= ID2EX_ExtendedImmediate when ID2EX_ALUSrc = ALUSrc_IMMEDIATE else
                     EX_Forward2Result;
    cALU: ALU port map(EX_Forward1Result, EX_ALUDataIn2, ID2EX_ALUOp, EX_ALUResult, EX_PCBranch);


    ---
    --- EX2MEM
    ---

    EX2MEM_Flush <= ArchitectureHazardDetected or Global_Flush;
    cEX2MEM_Forward2Result: RegVector16 generic map(ZERO_16) port map(Clk, EX2MEM_Flush, '1', EX_Forward2Result, EX2MEM_Forward2Result);
    cEX2MEM_ALUResult: RegVector16 generic map(ZERO_16) port map(Clk, EX2MEM_Flush, '1', EX_ALUResult, EX2MEM_ALUResult);
    cEX2MEM_RegWrite: Reg port map(Clk, EX2MEM_Flush, '1', ID2EX_RegWrite, EX2MEM_RegWrite);
    cEX2MEM_MemToReg: Reg port map(Clk, EX2MEM_Flush, '1', ID2EX_MemToReg, EX2MEM_MemToReg);
    cEX2MEM_MemRead: Reg port map(Clk, EX2MEM_Flush, '1', ID2EX_MemRead, EX2MEM_MemRead);
    cEX2MEM_MemWrite: Reg port map(Clk, EX2MEM_Flush, '1', ID2EX_MemWrite, EX2MEM_MemWrite);
    cEX2MEM_PCToReg: Reg port map(Clk, EX2MEM_Flush, '1', ID2EX_PCToReg, EX2MEM_PCToReg);
    cEX2MEM_PC: RegVector16 generic map(PC_INITIAL) port map(Clk, EX2MEM_Flush, '1', ID2EX_PC, EX2MEM_PC);
    cEX2MEM_WriteRegister: RegVector4 generic map(REG_ZERO) port map(Clk, EX2MEM_Flush, '1', ID2EX_WriteRegister, EX2MEM_WriteRegister);


    ---
    --- MEM
    ---

    MEM_WriteDataToReg <= EX2MEM_PC when EX2MEM_PCToReg = '1' else
                          EX2MEM_ALUResult;


    ---
    --- MEM2WB
    ---

    cMEM2WB_ReadDataFromMem: RegVector16 generic map(ZERO_16) port map(Clk, Global_Flush, '1', MEM_ReadDataFromMem, MEM2WB_ReadDataFromMem);
    cMEM2WB_WriteDataToReg: RegVector16 generic map(ZERO_16) port map(Clk, Global_Flush, '1', MEM_WriteDataToReg, MEM2WB_WriteDataToReg);
    cMEM2WB_RegWrite: Reg port map(Clk, Global_Flush, '1', EX2MEM_RegWrite, MEM2WB_RegWrite);
    cMEM2WB_MemToReg: Reg port map(Clk, Global_Flush, '1', EX2MEM_MemToReg, MEM2WB_MemToReg);
    cMEM2WB_WriteRegister: RegVector4 generic map(REG_ZERO) port map(Clk, Global_Flush, '1', EX2MEM_WriteRegister, MEM2WB_WriteRegister);


    ---
    --- WB
    ---

    WB_WriteDataToReg <= MEM2WB_ReadDataFromMem when MEM2WB_MemToReg = '1' else
                         MEM2WB_WriteDataToReg;


    ---
    --- Data Forwarding
    ---

    Forward1 <= FORWARD_EX2MEM when (EX2MEM_RegWrite = '1' and EX2MEM_WriteRegister = ID2EX_ReadRegister1) else
                FORWARD_MEM2WB when (MEM2WB_RegWrite = '1' and MEM2WB_WriteRegister = ID2EX_ReadRegister1) else
                FORWARD_ID2EX;
    Forward2 <= FORWARD_EX2MEM when (EX2MEM_RegWrite = '1' and EX2MEM_WriteRegister = ID2EX_ReadRegister2) else
                FORWARD_MEM2WB when (MEM2WB_RegWrite = '1' and MEM2WB_WriteRegister = ID2EX_ReadRegister2) else
                FORWARD_ID2EX;


    ---
    --- Hazard Detection
    ---

    DataHazardDetected <= '1' when ID2EX_MemRead = '1' and (ID2EX_WriteRegister = ID_ReadRegister1 or ID2EX_WriteRegister = ID_ReadRegister2) else '0';
    ControlHazardDetected <= ID2EX_PCJump or EX_PCBranch;
    ArchitectureHazardDetected <= '1' when (EX2MEM_MemRead = '1' or EX2MEM_MemWrite = '1') and EX2MEM_ALUResult < "1000000000000000" else '0';


    ---
    --- Asynchronized Reset -> Synchronized Flush
    ---
    
    ResetToFlush: process (Clk, Rst)
    begin
        if Rst = '0' then
            Global_Flush <= '1';
        elsif rising_edge(Clk) and Booted = '1' then
            Global_Flush <= '0';
        end if;
    end process;

end Behavioral;
