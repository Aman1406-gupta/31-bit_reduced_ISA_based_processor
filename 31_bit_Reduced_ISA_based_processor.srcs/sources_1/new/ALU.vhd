library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A            : in  std_logic_vector(31 downto 0);
        B            : in  std_logic_vector(31 downto 0);
        ALU_ctrl     : in  std_logic_vector(9 downto 0);
        sa           : in std_logic_vector(4 downto 0);
        outp         : out std_logic_vector(31 downto 0);
        zero         : out std_logic
    );
end ALU;

architecture Behavioral of ALU is
    
    signal if_imm       : std_logic;                    -- 0: R-type, 1: I-type
    signal logic_sel    : std_logic_vector(1 downto 0); -- 00: AND, 01: OR, 10: NOR, 11: XOR
    signal arith_sel    : std_logic_vector(2 downto 0); -- 000: ADD, 001: ADDu, 010: SUB, 011: SUBu, 100: SLT, 101: SLTu
    signal shift_sel    : std_logic_vector(1 downto 0); -- 00: SLL, 01: SRL, 10: SRA, 11: ROR
    signal alu_mode_sel : std_logic_vector(1 downto 0); -- 00: Shift, 01: SLT, 10: Arith, 11: Logic

    signal shift_out : std_logic_vector(31 downto 0);
    signal logic_out : std_logic_vector(31 downto 0);
    signal arith_out : std_logic_vector(31 downto 0);
    signal slt_out   : std_logic_vector(31 downto 0);
    signal temp_sub  : signed(31 downto 0);
    signal temp_subu : unsigned(31 downto 0);
    signal A_u, B_u  : unsigned(31 downto 0);
    signal A_s, B_s  : signed(31 downto 0);
    signal result    : std_logic_vector(31 downto 0);
begin
    A_s <= signed(A);
    B_s <= signed(B);
    A_u <= unsigned(A);
    B_u <= unsigned(B);
    
    -- retrieving select lines from ALU_ctrl
    if_imm          <= ALU_ctrl(9);
    logic_sel       <= ALU_ctrl(8 downto 7);
    arith_sel       <= ALU_ctrl(6 downto 4);
    shift_sel       <= ALU_ctrl(3 downto 2);
    alu_mode_sel    <= ALU_ctrl(1 downto 0);

    -- Logic operations
    process(A, B, logic_sel)
    begin
        case logic_sel is
            when "00" => logic_out <= A and B;                   -- AND
            when "01" => logic_out <= A or B;                    -- OR
            when "10" => logic_out <= A xor B;                   -- XOR
            when "11" => logic_out <= not (A or B);              -- NOR
            when others => logic_out <= (others => '0');
        end case;
    end process;
    
    -- Arithmetic Operations
    process(A_s, B_s, A_u, B_u, arith_sel)
    begin
        case arith_sel is
            when "000" => 
                arith_out <= std_logic_vector(A_s + B_s);-- ADD
            when "001" => 
                arith_out <= std_logic_vector(A_u + B_u);-- ADDu
            when "010" => 
                arith_out <= std_logic_vector(A_s - B_s);-- SUB
                if arith_out = x"00000000" then
                    zero <= '1';                          -- Zero flag
                else
                    zero <= '0'; 
                end if;
            when "011" => 
                arith_out <= std_logic_vector(A_u - B_u);-- SUBu
            when others => arith_out <= (others => '0');
        end case;
    end process;

    -- SLT/SLTu Operations
    process(A_s, B_s, A_u, B_u, arith_sel)
    begin
        case arith_sel is
            when "100" =>  -- SLT
                if A_s < B_s then
                    slt_out <= (31 downto 1 => '0') & '1';
                else
                    slt_out <= (others => '0');
                end if;
            when "101" =>  -- SLTu
                if A_u < B_u then
                    slt_out <= (31 downto 1 => '0') & '1';
                else
                    slt_out <= (others => '0');
                end if;
            when others =>
                slt_out <= (others => '0');  -- Ensure it's cleared
        end case;
    end process;
    
    -- Shifter
    process(A, B, if_imm, shift_sel)
        variable temp_sa       : integer;
        variable temp_in  : signed(31 downto 0);
        variable temp_res : signed(31 downto 0);
    begin
        if if_imm ='1' then
            temp_sa := 16;
        else
            temp_sa := to_integer(unsigned(sa));
        end if;
        temp_in := signed(B);

        case shift_sel is
            when "00" => -- SLL (logical left)
                if if_imm = '1' then
                    shift_out <= std_logic_vector(shift_left(unsigned(B), 16));
                else
                    shift_out <= std_logic_vector(shift_left(unsigned(B), temp_sa));
                end if;

            when "01" => -- SRL (logical right)
                shift_out <= std_logic_vector(shift_right(unsigned(B), temp_sa));

            when "10" => -- SRA (arithmetic right)
                temp_res := shift_right(temp_in, temp_sa);
                shift_out <= std_logic_vector(temp_res);

            when "11" => -- ROR (rotate right)
                shift_out <= std_logic_vector((unsigned(B) ror temp_sa));

            when others =>
                shift_out <= (others => '0');
        end case;
    end process;
        
    -- Main ALU operation select
    process(alu_mode_sel, shift_out, slt_out, arith_out, logic_out)
    begin
        case alu_mode_sel is
            when "00" => result <= shift_out;
            when "01" => result <= slt_out;
            when "10" => result <= arith_out;
            when "11" => result <= logic_out;
            when others => result <= (others => '0');
        end case;
    end process;

    -- output
    outp <= result;
    
end Behavioral;