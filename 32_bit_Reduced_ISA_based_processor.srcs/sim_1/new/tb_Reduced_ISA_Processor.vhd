library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.ISA_Pkg.all;

entity tb_Reduced_ISA_Processor is
end tb_Reduced_ISA_Processor;

architecture sim of tb_Reduced_ISA_Processor is
    -- Clock and reset
    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';

    -- Register file outputs
    signal r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15 : std_logic_vector(31 downto 0);
    signal r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31 : std_logic_vector(31 downto 0);

    -- Program memory
    signal program_mem : mem_array := (
        -- Sample program: mix of instructions (must be written as per your encoding)
        -- I-Type Instructions
        0  => "000001" & "00010" & "00011" & "0000000000001010",  -- ADDI  $s1 = $s2 + 10
        1  => "000010" & "00010" & "00011" & "0000000000001010",  -- ADDIU $s1 = $s2 + 10
        2  => "000011" & "00010" & "00011" & "0000000000001010",  -- ANDI
        3  => "000100" & "00010" & "00011" & "0000000000001010",  -- ORI
        4  => "000101" & "00010" & "00011" & "0000000000001010",  -- XORI
        5  => "000110" & "00000" & "00011" & "0000000000001010",  -- LUI
        6  => "000111" & "00010" & "00011" & "0000000000000100",  -- LW   $s3 <- MEM[$s2 + 4]
        7  => "001000" & "00010" & "00011" & "0000000000000100",  -- SW   MEM[$s2 + 4] <- $s3
        8  => "001001" & "00010" & "00011" & "0000000000000001",  -- BEQ  $s2 == $s3
        9  => "001010" & "00010" & "00011" & "0000000000000001",  -- BNE  $s2 != $s3
        10 => "001111" & "00010" & "00011" & "0000000000000001",  -- SLTI
        11 => "010000" & "00010" & "00011" & "0000000000000001",  -- SLTIU
        -- J-Type Instructions
        12 => "010001" & "00000000000000000000000001",            -- JUMP
        -- R-Type Instructions
        13 => "000000" & "00010" & "00011" & "00100" & "00000" & "000000", -- ADD
        14 => "000000" & "00010" & "00011" & "00100" & "00000" & "000001", -- ADDU
        15 => "000000" & "00010" & "00011" & "00100" & "00000" & "000010", -- SUB
        16 => "000000" & "00010" & "00011" & "00100" & "00000" & "000011", -- SUBU
        17 => "000000" & "00010" & "00011" & "00100" & "00000" & "000100", -- AND
        18 => "000000" & "00010" & "00011" & "00100" & "00000" & "000101", -- OR
        19 => "000000" & "00010" & "00011" & "00100" & "00000" & "000110", -- XOR
        20 => "000000" & "00010" & "00011" & "00100" & "00000" & "000111", -- NOR
        21 => "000000" & "00000" & "00011" & "00100" & "01010" & "001000", -- SLL
        22 => "000000" & "00000" & "00011" & "00100" & "01010" & "001001", -- SRL
        23 => "000000" & "00000" & "00011" & "00100" & "01010" & "001010", -- SRA
        24 => "000000" & "00010" & "00011" & "00100" & "00000" & "001100", -- SLT
        25 => "000000" & "00010" & "00011" & "00100" & "00000" & "001101", -- SLTU
        others => (others => '0')
    );

begin
    -- Clock generation
    clk_process: process
    begin
        while now < 5000 ns loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Reset logic
    stim_proc: process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait;
    end process;

    -- Instantiate the processor
    DUT: entity work.Reduced_ISA_Processor
        port map (
            clk     => clk,
            reset   => reset,
            program => program_mem,
            r0 => r0, r1 => r1, r2 => r2, r3 => r3, r4 => r4, r5 => r5, r6 => r6, r7 => r7,
            r8 => r8, r9 => r9, r10 => r10, r11 => r11, r12 => r12, r13 => r13, r14 => r14, r15 => r15,
            r16 => r16, r17 => r17, r18 => r18, r19 => r19, r20 => r20, r21 => r21, r22 => r22, r23 => r23,
            r24 => r24, r25 => r25, r26 => r26, r27 => r27, r28 => r28, r29 => r29, r30 => r30, r31 => r31
        );
end sim;