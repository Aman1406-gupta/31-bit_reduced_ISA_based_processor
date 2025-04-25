library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Extender is
    Port (
        imm_in    : in  std_logic_vector(15 downto 0);
        ext_op    : in  std_logic;  -- '0' for sign-extend, '1' for zero-extend
        imm_out   : out std_logic_vector(31 downto 0)
    );
end Extender;

architecture Behavioral of Extender is
begin
    process(imm_in, ext_op)
    begin
        if ext_op = '0' then
            -- Zero extension
            imm_out <= (others => '0');
            imm_out(15 downto 0) <= imm_in;
        else
            -- Sign extension
            if imm_in(15) = '1' then
                imm_out <= (15 downto 0 => '1') & imm_in;
            else
                imm_out <= (15 downto 0 => '0') & imm_in;
            end if;
        end if;
    end process;
end Behavioral;