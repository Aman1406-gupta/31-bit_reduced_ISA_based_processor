library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Write_Back is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        wb_data_final: in  std_logic_vector(31 downto 0);
        rd3_out      : in  std_logic_vector(4 downto 0);
        mem_reg_out  : in  std_logic;
        
        wb_data      : out std_logic_vector(31 downto 0);
        rd4_out      : out std_logic_vector(4 downto 0);
        reg_write    : out std_logic
    );
end Write_Back;

architecture Behavioral of Write_Back is
    -- Stage 1: Capture inputs into internal registers
    signal wb_data_in_reg : std_logic_vector(31 downto 0);
    signal rd4_in_reg     : std_logic_vector(4 downto 0);
    signal wb_reg_in      : std_logic;

    -- Stage 2: Output registers (delayed update)
    signal wb_data_reg    : std_logic_vector(31 downto 0);
    signal rd4_reg        : std_logic_vector(4 downto 0);
    signal wb_reg         : std_logic;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            wb_data_reg <= (others => '0');
            rd4_reg     <= (others => '0');
            wb_reg      <= '0';
        elsif rising_edge(clk) then
            wb_data_reg <= wb_data_final;
            rd4_reg     <= rd3_out;
            wb_reg      <= mem_reg_out;
        end if;
    end process;

    -- Output assignments
    wb_data   <= wb_data_reg;
    rd4_out   <= rd4_reg;
    reg_write <= wb_reg;

end Behavioral;