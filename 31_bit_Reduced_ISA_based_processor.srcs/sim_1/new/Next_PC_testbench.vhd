library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_NextPC is
end tb_NextPC;

architecture sim of tb_NextPC is
    signal pc_plus4       : std_logic_vector(31 downto 0);
    signal immediate_26   : std_logic_vector(25 downto 0);
    signal J              : std_logic;
    signal BEQ            : std_logic;
    signal BNE            : std_logic;
    signal zero           : std_logic;
    signal pc_next        : std_logic_vector(31 downto 0);
    signal pc_src         : std_logic;
begin
    uut: entity work.NextPC
        port map (
            pc_plus4 => pc_plus4,
            immediate_26 => immediate_26,
            J => J,
            BEQ => BEQ,
            BNE => BNE,
            zero => zero,
            pc_next => pc_next,
            pc_src => pc_src
        );

    stim_proc: process
    begin
        -- Default case (pc + 4)
        pc_plus4 <= "01110000000000000000111111000100";
        immediate_26 <= "00000000001111111111111111";
        J <= '0';
        BEQ <= '0';
        BNE <= '0';
        zero <= '0';
        wait for 10 ns;

        -- JUMP case
        J <= '1';
        wait for 10 ns;
        J <= '0';

        -- BEQ taken (zero = 1)
        BEQ <= '1';
        zero <= '1';
        wait for 10 ns;
        BEQ <= '0';
        
        -- BEQ not taken (zero = 0)
        BEQ <= '1';
        zero <= '0';
        wait for 10 ns;
        BEQ <= '0';
        
        immediate_26 <= "00000000000111111111111111";
        
        -- BNE taken (zero = 0)
        BNE <= '1';
        zero <= '0';
        wait for 10 ns;
        BNE <= '0';
        
        -- BNE not taken (zero = 1)
        BNE <= '1';
        zero <= '1';
        wait for 10 ns;
        BNE <= '0';

        wait;
    end process;
end sim;