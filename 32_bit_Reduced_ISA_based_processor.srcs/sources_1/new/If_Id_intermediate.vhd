library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_ID_Register is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        
        instruction   : in  std_logic_vector(30 downto 0);

        -- Outputs to Register File
        rs_addr       : out std_logic_vector(25 downto 21);
        rt_addr       : out std_logic_vector(20 downto 16);
        rd_addr       : out std_logic_vector(15 downto 11);

        -- Opcode and Function Field
        Op5           : out std_logic_vector(30 downto 26);
        func6         : out std_logic_vector(5 downto 0);

        -- Immediate
        imm26         : out std_logic_vector(25 downto 0);
        
        -- NPC
        npc_in        : in std_logic_vector(31 downto 0);
        npc_out       : out std_logic_vector(31 downto 0)
    );
end IF_ID_Register;

architecture Behavioral of IF_ID_Register is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            Op5     <= instruction(30 downto 26);
            rs_addr <= instruction(25 downto 21);
            rt_addr <= instruction(20 downto 16);
            rd_addr <= instruction(15 downto 11);
            func6   <= instruction(5 downto 0);
            imm26   <= instruction(25 downto 0);
            npc_out <= npc_in;
        end if;
    end process;
end Behavioral;