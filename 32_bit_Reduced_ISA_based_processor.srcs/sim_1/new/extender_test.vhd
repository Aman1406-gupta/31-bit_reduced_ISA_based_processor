library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Extender is
end tb_Extender;

architecture sim of tb_Extender is
    signal imm_in  : std_logic_vector(15 downto 0);
    signal ext_op  : std_logic;
    signal imm_out : std_logic_vector(31 downto 0);
begin
    -- Instantiate Extender
    uut: entity work.Extender
        port map (
            imm_in => imm_in,
            ext_op => ext_op,
            imm_out => imm_out
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Zero extension test
        imm_in <= x"00F0";
        ext_op <= '1';
        wait for 10 ns;

        -- Sign extension test (positive)
        imm_in <= x"007F";
        ext_op <= '0';
        wait for 10 ns;

        -- Sign extension test (negative)
        imm_in <= x"FF80";
        ext_op <= '0';
        wait for 10 ns;

        -- Zero extension of high-bit set
        imm_in <= x"FF80";
        ext_op <= '1';
        wait for 10 ns;

        wait;
    end process;
end sim;