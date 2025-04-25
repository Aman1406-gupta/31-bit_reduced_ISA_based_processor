library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity destinationMux is
    Port (
        rt_add : in  std_logic_vector(4 downto 0);  
        rd_add : in  std_logic_vector(4 downto 0);  
        regdst : in  std_logic;                      
        rd_final: out std_logic_vector(4 downto 0)
    );
end destinationMux;

architecture Behavioral of destinationMux is
begin
    rd_final <= rd_add when regdst = '1' else rt_add;
end Behavioral;
