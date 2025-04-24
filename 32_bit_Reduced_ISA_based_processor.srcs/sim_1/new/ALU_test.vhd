library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    signal A, B           : std_logic_vector(31 downto 0);
    signal shift_sel      : std_logic_vector(1 downto 0);
    signal arith_sel      : std_logic_vector(2 downto 0);
    signal logic_sel      : std_logic_vector(1 downto 0);
    signal alu_mode_sel   : std_logic_vector(1 downto 0);
    signal outp           : std_logic_vector(31 downto 0);
    signal zero           : std_logic;

    component ALU
        Port (
            A            : in  std_logic_vector(31 downto 0);
            B            : in  std_logic_vector(31 downto 0);
            shift_sel    : in  std_logic_vector(1 downto 0);
            arith_sel    : in  std_logic_vector(2 downto 0);
            logic_sel    : in  std_logic_vector(1 downto 0);
            alu_mode_sel : in  std_logic_vector(1 downto 0);
            outp         : out std_logic_vector(31 downto 0);
            zero         : out std_logic
        );
    end component;

begin

    uut: ALU
        port map (
            A            => A,
            B            => B,
            shift_sel    => shift_sel,
            arith_sel    => arith_sel,
            logic_sel    => logic_sel,
            alu_mode_sel => alu_mode_sel,
            outp         => outp,
            zero         => zero
        );

    stimulus: process
    begin
        -- Logic operations
        A <= x"AAAAAAAA"; B <= x"55555555";
        alu_mode_sel <= "11"; -- Logic
        logic_sel <= "00"; wait for 10 ns; -- AND
        logic_sel <= "01"; wait for 10 ns; -- OR
        logic_sel <= "10"; wait for 10 ns; -- NOR
        logic_sel <= "11"; wait for 10 ns; -- XOR
        
        logic_sel <= "00";

        -- Arithmetic operations
        A <= x"00000003"; B <= x"FFFFFFF5";
        alu_mode_sel <= "10"; -- Arithmetic
        arith_sel <= "000"; wait for 10 ns; -- ADD
        arith_sel <= "001"; wait for 10 ns; -- ADDu
        arith_sel <= "010"; wait for 10 ns; -- SUB
        arith_sel <= "011"; wait for 10 ns; -- SUBu

        -- SLT operations
        A <= x"00000003"; B <= x"FFFFFFF5";
        alu_mode_sel <= "01";
        arith_sel <= "100"; wait for 10 ns; -- SLT (signed)
        arith_sel <= "101"; wait for 10 ns; -- SLTu (unsigned)

        -- Shift operations
        B <= x"000000F8";  -- where bits 10:6 = "00011"
        A <= x"80000001";

        alu_mode_sel <= "00"; -- Shift mode
        shift_sel <= "00"; wait for 10 ns; -- SLL
        shift_sel <= "01"; wait for 10 ns; -- SRL
        shift_sel <= "10"; wait for 10 ns; -- SRA
        shift_sel <= "11"; wait for 10 ns; -- ROR

        wait;
    end process;

end Behavioral;