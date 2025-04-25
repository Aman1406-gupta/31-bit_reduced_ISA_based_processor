library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ID_EX_Register is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;

        -- Inputs from ID stage
        npc          : in  std_logic_vector(31 downto 0);
        imm26        : in  std_logic_vector(25 downto 0);
        operandA     : in  std_logic_vector(31 downto 0);
        operandB     : in  std_logic_vector(31 downto 0);
        rd_final     : in  std_logic_vector(4 downto 0);
        stall_mux_out: in  std_logic_vector(18 downto 0);

        -- Outputs to EX stage
        npc2_out     : out std_logic_vector(31 downto 0);
        imm26_out    : out std_logic_vector(25 downto 0);
        imm16_out    : out std_logic_vector(15 downto 0);
        operandA_out : out std_logic_vector(31 downto 0);
        operandB_out : out std_logic_vector(31 downto 0);
        rd2_out      : out std_logic_vector(4 downto 0);
        ext_op       : out std_logic;
        Alu_src      : out std_logic;
        Alu_ctrl     : out std_logic_vector(9 downto 0);
        beq          : out std_logic;
        bne          : out std_logic;
        j            : out std_logic;
        mem_read     : out std_logic;
        reg_write    : out std_logic;
        exe_reg_out  : out std_logic_vector(3 downto 0)
    );
end ID_EX_Register;

architecture Behavioral of ID_EX_Register is
    signal npc2_reg_in, operandA_reg_in, operandB_reg_in : std_logic_vector(31 downto 0);
    signal rd2_reg_in : std_logic_vector(4 downto 0);
    signal imm26_reg_in  : std_logic_vector(25 downto 0);
    signal exe_reg_in    : std_logic_vector(18 downto 0);

    signal npc2_reg, operandA_reg, operandB_reg : std_logic_vector(31 downto 0);
    signal rd2_reg     : std_logic_vector(4 downto 0);
    signal imm26_reg   : std_logic_vector(25 downto 0);
    signal exe_reg     : std_logic_vector(18 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            npc2_reg_in      <= (others => '0');
            imm26_reg_in    <= (others => '0');
            operandA_reg_in <= (others => '0');
            operandB_reg_in <= (others => '0');
            rd2_reg_in       <= (others => '0');
            exe_reg_in      <= (others => '0');
        elsif rising_edge(clk) then
            npc2_reg_in      <= npc;
            imm26_reg_in    <= imm26;
            operandA_reg_in <= operandA;
            operandB_reg_in <= operandB;
            rd2_reg_in       <= rd_final;
            exe_reg_in      <= stall_mux_out;
        end if;
    end process;

--    process(clk, reset)
--    begin
--        if reset = '1' then
--            npc2_reg      <= (others => '0');
--            imm26_reg     <= (others => '0');
--            operandA_reg  <= (others => '0');
--            operandB_reg  <= (others => '0');
--            rd2_reg       <= (others => '0');
--            exe_reg       <= (others => '0');
--        elsif rising_edge(clk) then
--            npc2_reg      <= npc_reg_in;
--            imm26_reg     <= imm26_reg_in;
--            operandA_reg  <= operandA_reg_in;
--            operandB_reg  <= operandB_reg_in;
--            rd2_reg       <= rd_reg_in;
--            exe_reg       <= exe_reg_in;
--        end if;
--    end process;

    npc2_out      <= npc2_reg_in;
    imm26_out     <= imm26_reg_in;
    imm16_out     <= imm26_reg_in(15 downto 0);
    operandA_out  <= operandA_reg_in;
    operandB_out  <= operandB_reg_in;
    rd2_out       <= rd2_reg_in;
    ext_op        <= exe_reg_in(18);
    Alu_src       <= exe_reg_in(17);
    Alu_ctrl      <= exe_reg_in(16 downto 7);
    beq           <= exe_reg_in(6);
    bne           <= exe_reg_in(5);
    j             <= exe_reg_in(4);
    mem_read      <= exe_reg_in(3);
    reg_write     <= exe_reg_in(0);
    exe_reg_out   <= exe_reg_in(3 downto 0);
end Behavioral;