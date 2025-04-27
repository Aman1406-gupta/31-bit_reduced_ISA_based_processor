library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Wb_Mux is
    Port (
        ALU_result    : in  std_logic_vector(31 downto 0);  
        data_out      : in  std_logic_vector(31 downto 0); 
        Mem_to_reg    : in  std_logic;                      
        wb_data_final : out std_logic_vector(31 downto 0)
    );
end Wb_Mux;

architecture Behavioral of Wb_Mux is
begin
    wb_data_final <= data_out when Mem_to_reg = '1' else ALU_result;
end Behavioral;