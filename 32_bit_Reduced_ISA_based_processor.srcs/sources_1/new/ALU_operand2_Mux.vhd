library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_operand2_MUX is
    Port (
        extended_imm    : in  std_logic_vector(31 downto 0);  
        operandB        : in  std_logic_vector(31 downto 0); 
        ALU_src         : in  std_logic;                      
        operand2_final  : out std_logic_vector(31 downto 0)
    );
end ALU_operand2_MUX;

architecture Behavioral of ALU_operand2_MUX is
begin
    process(extended_imm, operandB, ALU_src)
    begin
    
        if ALU_src = '1' then
            operand2_final <= operandB;
        else
            operand2_final <= extended_imm;
        end if;
    
    end process;
end Behavioral;