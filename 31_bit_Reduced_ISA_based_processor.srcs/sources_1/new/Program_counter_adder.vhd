library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_Adder is
    Port (
        pc_in     : in  std_logic_vector(31 downto 0);
        pc_plus4  : out std_logic_vector(31 downto 0)
    );
end PC_Adder;

architecture Behavioral of PC_Adder is
begin
    pc_plus4 <= std_logic_vector(unsigned(pc_in) + 4);
end Behavioral;