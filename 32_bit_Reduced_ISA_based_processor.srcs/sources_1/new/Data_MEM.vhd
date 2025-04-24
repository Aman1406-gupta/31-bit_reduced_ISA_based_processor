library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Mem is
    Port (
        address     : in  std_logic_vector(31 downto 0);
        data_inp    : in  std_logic_vector(31 downto 0);
        clk         : in  std_logic;
        mem_read    : in  std_logic;
        mem_write   : in  std_logic;
        data_out    : out std_logic_vector(31 downto 0)
    );
end Data_Mem;

architecture Behavioral of Data_Mem is
    type ram_type is array (0 to 255) of std_logic_vector(31 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
begin

    -- Memory read (combinational)
    process(address, mem_read, RAM)
        variable addr_idx : integer range 0 to 255;
    begin
        if mem_read = '1' then
            addr_idx := to_integer(unsigned(address(9 downto 2))); -- word-aligned
            data_out <= RAM(addr_idx);
        else
            data_out <= (others => '0');
        end if;
    end process;

    -- Memory write (synchronous)
    process(clk)
        variable addr_idx : integer range 0 to 255;
    begin
        if rising_edge(clk) then
            if mem_write = '1' then
                addr_idx := to_integer(unsigned(address(9 downto 2))); -- word-aligned
                RAM(addr_idx) <= data_inp;
            end if;
        end if;
    end process;

end Behavioral;