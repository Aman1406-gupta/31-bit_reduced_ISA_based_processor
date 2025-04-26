library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Stall_Mux is
    Port (
        control_signals    : in  std_logic_vector(18 downto 0);
        stall              : in  std_logic;                      
        stall_mux_out      : out std_logic_vector(18 downto 0)
    );
end Stall_Mux;

architecture Behavioral of Stall_Mux is
begin
    stall_mux_out <= "0000000000000000000" when stall = '1' else control_signals;
end Behavioral;