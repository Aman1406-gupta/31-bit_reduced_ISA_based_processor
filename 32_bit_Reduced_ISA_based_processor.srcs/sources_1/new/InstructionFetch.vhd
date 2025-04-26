library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ISA_Pkg.all;

entity InstructionFetch is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        pc_enable   : in  std_logic;
        disable_pc  : in  std_logic;
        pc_npc      : in  std_logic_vector(31 downto 0);
        pc_src      : in  std_logic;  -- 0 = PC+4, 1 = branch address
        program     : in  mem_array;
        instruction : out std_logic_vector(30 downto 0);
        pc_out      : out std_logic_vector(31 downto 0)
    );
end InstructionFetch;

architecture Structural of InstructionFetch is
    signal pc_next    : std_logic_vector(31 downto 0);
    signal pc_current : std_logic_vector(31 downto 0);
    signal pc_plus4   : std_logic_vector(31 downto 0);
begin
    -- PC Unit
    U_PC: entity work.PC
        port map (
            clk       => clk,
            reset     => reset,
            pc_enable => pc_enable,
            disable_pc => disable_pc,
            pc_in     => pc_next,
            pc_out    => pc_current
        );

    -- PC Adder
    U_Adder: entity work.PC_Adder
        port map (
            pc_in     => pc_current,
            pc_plus4  => pc_plus4
        );

    -- PC MUX
    U_PC_MUX: entity work.PC_MUX
        port map (
            pc_plus4  => pc_plus4,
            pc_npc    => pc_npc,
            pc_src    => pc_src,
            pc_next   => pc_next
        );

    -- Instruction Memory
    U_IMEM: entity work.InstructionMemory
        port map (
            address     => pc_current,
            program     => program,
            instruction => instruction
        );

    pc_out <= pc_plus4;
end Structural;