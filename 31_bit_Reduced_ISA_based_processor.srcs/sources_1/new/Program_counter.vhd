library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        pc_enable  : in  std_logic;
        disable_pc : in  std_logic;
        pc_in      : in  std_logic_vector(31 downto 0);
        pc_out     : out std_logic_vector(31 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal pc_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            if pc_enable = '1' and disable_pc = '0' then
                pc_reg <= pc_in;
            elsif disable_pc = '1' then
                pc_reg <= pc_reg;
            end if;
        end if;
    end process;

    pc_out <= pc_reg;
end Behavioral;
