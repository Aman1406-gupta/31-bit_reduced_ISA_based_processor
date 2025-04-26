library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EX_MEM_Register is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;

        -- Inputs from Execution stage
        ALU_out         : in  std_logic_vector(31 downto 0);
        operandB_out    : in  std_logic_vector(31 downto 0);
        rd2_out         : in  std_logic_vector(4 downto 0);
        exe_reg_out     : in  std_logic_vector(3 downto 0);

        -- Outputs to Memory stage
        ALU_result      : out std_logic_vector(31 downto 0);
        data_inp        : out std_logic_vector(31 downto 0);
        rd3_out         : out std_logic_vector(4 downto 0);
        mem_read        : out std_logic;
        mem_write       : out std_logic;
        Mem_to_reg      : out std_logic;
        reg_write       : out std_logic
    );
end EX_MEM_Register;

architecture Behavioral of EX_MEM_Register is
    signal alu_reg      : std_logic_vector(31 downto 0);
    signal data_reg     : std_logic_vector(31 downto 0);
    signal rd3_reg       : std_logic_vector(4 downto 0);
    signal mem_reg      : std_logic_vector(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            alu_reg   <= (others => '0');
            data_reg  <= (others => '0');
            rd3_reg   <= (others => '0');
            mem_reg   <= (others => '0');
        elsif rising_edge(clk) then
            alu_reg   <= ALU_out;
            data_reg  <= operandB_out;
            rd3_reg   <= rd2_out;
            mem_reg   <= exe_reg_out;
        end if;
    end process;

    ALU_result   <= alu_reg;
    data_inp     <= data_reg;
    rd3_out      <= rd3_reg;
    mem_read     <= mem_reg(3);
    mem_write    <= mem_reg(2);
    Mem_to_reg   <= mem_reg(1);
    reg_write    <= mem_reg(0);
end Behavioral;