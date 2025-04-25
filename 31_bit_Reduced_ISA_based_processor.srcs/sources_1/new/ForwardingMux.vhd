library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ForwardingMUX is
    Port (
        input0 : in  std_logic_vector(31 downto 0);  
        input1 : in  std_logic_vector(31 downto 0); 
        input2 : in  std_logic_vector(31 downto 0);  
        input3 : in  std_logic_vector(31 downto 0);   
        selec  : in  std_logic_vector(1 downto 0);
        outp   : out std_logic_vector(31 downto 0)
    );
end ForwardingMUX;

architecture Behavioral of ForwardingMUX is
begin
    process(selec, input0, input1, input2, input3)
    begin
    
    if selec = "00" then
        outp <= input0;
    elsif selec = "01" then
        outp <= input1;
    elsif selec = "10" then
        outp <= input2;
    elsif selec = "11" then
        outp <= input3;
    else 
        outp <= (others => '0');
    end if;
    
    end process;
    
end Behavioral;