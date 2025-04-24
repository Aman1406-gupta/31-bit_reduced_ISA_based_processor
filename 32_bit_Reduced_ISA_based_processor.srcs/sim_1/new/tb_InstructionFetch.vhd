library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_InstructionFetch is
end tb_InstructionFetch;

architecture sim of tb_InstructionFetch is
    -- Signals for ports
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal pc_enable   : std_logic := '1';
    signal disable_pc  : std_logic := '0';
    signal pc_src      : std_logic := '0';  -- 0 = PC+4, 1 = pc_branch
    signal pc_npc      : std_logic_vector(31 downto 0) := (others => '0');
    signal instruction : std_logic_vector(31 downto 0);
    signal pc_out      : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;
begin

    -- Instantiate Instruction Fetch Unit
    uut: entity work.InstructionFetch
        port map (
            clk         => clk,
            reset       => reset,
            pc_enable   => pc_enable,
            disable_pc   => disable_pc,
            pc_npc      => pc_npc,
            pc_src      => pc_src,
            instruction => instruction,
            pc_out      => pc_out
        );

    -- Clock process
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Step 1: Reset
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Step 2: Normal increment (PC + 4)
        wait for clk_period;

        -- Step 3: Branch to address 0x00000022
        pc_npc <= x"00000010";
        pc_src <= '1';
        wait for clk_period;

        -- Step 4: Back to normal increment
        pc_src <= '0';
        wait for clk_period;
        
        disable_pc <= '1';
        wait for clk_period;

        -- Step 5: End simulation
        wait;
    end process;

end sim;