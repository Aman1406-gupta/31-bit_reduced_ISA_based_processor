library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_MUX is
    Port (
        pc_plus4   : in  std_logic_vector(31 downto 0);
        pc_npc  : in  std_logic_vector(31 downto 0);
        pc_src     : in  std_logic;  -- 0 = pc+4, 1 = branch
        pc_next    : out std_logic_vector(31 downto 0)
    );
end PC_MUX;

architecture Behavioral of PC_MUX is
begin
    pc_next <= pc_plus4 when Pc_src = '0' else pc_npc;
end Behavioral;