library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NextPC is
    Port (
        pc_plus4       : in  std_logic_vector(31 downto 0);
        immediate_26   : in  std_logic_vector(25 downto 0);
        J              : in  std_logic;
        BEQ            : in  std_logic;
        BNE            : in  std_logic;
        zero           : in  std_logic;
        pc_next        : out std_logic_vector(31 downto 0);
        pc_src         : out std_logic
    );
end NextPC;

architecture Behavioral of NextPC is
begin
    process(J, BEQ, BNE, zero, pc_plus4, immediate_26)
    begin
        if J = '1' then
            pc_next <= pc_plus4(31 downto 28) & immediate_26 & "00";
            pc_src  <= '1';
        elsif BEQ = '1' and zero = '1' then
            if immediate_26(15)='1' then
                pc_next <= std_logic_vector(signed(pc_plus4) + signed("11111111111111" & immediate_26(15 downto 0) & "00")); -- taking pc_plus4 as signed so max pc_next will be 2^31.
            else 
                pc_next <= std_logic_vector(signed(pc_plus4) + signed("00000000000000" & immediate_26(15 downto 0) & "00")); -- taking pc_plus4 as signed so max pc_next will be 2^31.
            end if;
            pc_src  <= '1';
        elsif BNE = '1' and zero = '0' then
            if immediate_26(15)='1' then
                pc_next <= std_logic_vector(signed(pc_plus4) + signed("11111111111111" & immediate_26(15 downto 0) & "00")); -- taking pc_plus4 as signed so max pc_next will be 2^31.
            else 
                pc_next <= std_logic_vector(signed(pc_plus4) + signed("00000000000000" & immediate_26(15 downto 0) & "00")); -- taking pc_plus4 as signed so max pc_next will be 2^31.
            end if;
            pc_src  <= '1';
        else
            pc_next <= pc_plus4;
            pc_src <= '0';
        end if;
    end process;
end Behavioral;