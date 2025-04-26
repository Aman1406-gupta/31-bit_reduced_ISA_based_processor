library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ISA_Pkg.all;

entity InstructionMemory is
    Port (
        address      : in  std_logic_vector(31 downto 0);
        program      : in  mem_array; -- external instruction array
        instruction  : out std_logic_vector(30 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
begin
    process(address)
        variable word_addr : integer;
    begin
        word_addr := to_integer(unsigned(address(9 downto 2))); -- word-aligned access
        instruction <= program(word_addr)(30 downto 0);
    end process;
end Behavioral;