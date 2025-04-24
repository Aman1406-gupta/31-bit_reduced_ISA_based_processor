library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shifter is
    Port (
        inp_data  : in  std_logic_vector(31 downto 0);
        sa        : in  std_logic_vector(4 downto 0);
        selec     : in  std_logic_vector(1 downto 0); -- "00"=SLL, "01"=SRL, "10"=SRA, "11"=ROR
        outp      : out std_logic_vector(31 downto 0)
    );
end Shifter;

architecture Behavioral of Shifter is
begin
    process(inp_data, sa, selec)
        variable temp_sa       : integer;
        variable temp_in  : signed(31 downto 0);
        variable temp_res : signed(31 downto 0);
    begin
        temp_sa := to_integer(unsigned(sa));
        temp_in := signed(inp_data);

        case selec is
            when "00" => -- SLL (logical left)
                outp <= std_logic_vector(shift_left(unsigned(inp_data), temp_sa));

            when "01" => -- SRL (logical right)
                outp <= std_logic_vector(shift_right(unsigned(inp_data), temp_sa));

            when "10" => -- SRA (arithmetic right)
                temp_res := shift_right(temp_in, temp_sa);
                outp <= std_logic_vector(temp_res);

            when "11" => -- ROR (rotate right)
                outp <= std_logic_vector((unsigned(inp_data) ror temp_sa));

            when others =>
                outp <= (others => '0');
        end case;
    end process;
end Behavioral;