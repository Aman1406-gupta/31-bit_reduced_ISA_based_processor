library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_ID_Register is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        flush_if_id : in  std_logic;
        stall       : in std_logic;
        instruction : in  std_logic_vector(30 downto 0);

        -- Outputs to Register File
        rs_addr     : out std_logic_vector(25 downto 21);
        rt_addr     : out std_logic_vector(20 downto 16);
        rd_addr     : out std_logic_vector(15 downto 11);

        -- Opcode and Function Field
        Op5         : out std_logic_vector(30 downto 26);
        func6       : out std_logic_vector(5 downto 0);

        -- Immediate
        imm26       : out std_logic_vector(25 downto 0);
        
        -- NPC
        npc_in      : in std_logic_vector(31 downto 0);
        npc_out     : out std_logic_vector(31 downto 0)
    );
end IF_ID_Register;

architecture Behavioral of IF_ID_Register is
    signal instr_reg : std_logic_vector(30 downto 0);
    signal npc_reg   : std_logic_vector(31 downto 0);
begin
    process(clk, reset, flush_if_id)
    begin
        if reset = '1' then
            instr_reg <= (others => '0');
            npc_reg   <= (others => '0');
        elsif rising_edge(clk) then
            if stall = '1' then
                instr_reg <= instr_reg;
                npc_reg   <= npc_reg;
            elsif flush_if_id = '1' then
                instr_reg <= (others => '0');
                npc_reg   <= (others => '0');
            else
                instr_reg <= instruction;
                npc_reg   <= npc_in;
            end if;
        end if;
    end process;

    Op5     <= instr_reg(30 downto 26);
    rs_addr <= instr_reg(25 downto 21);
    rt_addr <= instr_reg(20 downto 16);
    rd_addr <= instr_reg(15 downto 11);
    func6   <= instr_reg(5 downto 0);
    imm26   <= instr_reg(25 downto 0);
    npc_out <= npc_reg;
end Behavioral;