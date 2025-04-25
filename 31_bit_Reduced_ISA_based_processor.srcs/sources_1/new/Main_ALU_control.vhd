library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Main_And_ALU_Control is
    Port (
        op5             : in  std_logic_vector(4 downto 0);
        func6           : in  std_logic_vector(5 downto 0);
        RegDst          : out std_logic;
        control_signals : out std_logic_vector(18 downto 0)
    );
end Main_And_ALU_Control;

architecture Behavioral of Main_And_ALU_Control is
    signal ext_op       : std_logic := '0';         -- 18
    signal alu_src      : std_logic := '0';         -- 17
    signal alu_ctrl     : std_logic_vector(9 downto 0) := (others => '0'); -- 16 to 7
    signal beq          : std_logic := '0';         -- 6
    signal bne          : std_logic := '0';         -- 5
    signal j            : std_logic := '0';         -- 4
    signal mem_read     : std_logic := '0';         -- 3
    signal mem_write    : std_logic := '0';         -- 2
    signal mem_to_reg   : std_logic := '0';         -- 1
    signal reg_write    : std_logic := '0';         -- 0

    signal if_imm       : std_logic := '0';
    signal alu_mode_sel : std_logic_vector(1 downto 0) := "00";
    signal arith_sel    : std_logic_vector(2 downto 0) := "000";
    signal logic_sel    : std_logic_vector(1 downto 0) := "00";
    signal shift_sel    : std_logic_vector(1 downto 0) := "00";
begin

    process(op5, func6)
    begin
        -- Default values
        RegDst       <= '0';
        ext_op       <= '0';
        alu_src      <= '0';
        if_imm       <= '0';  
        alu_mode_sel <= "10"; -- Default to arithmetic
        arith_sel    <= "000"; -- Default ADD
        logic_sel    <= "00";
        shift_sel    <= "00";
        beq          <= '0';
        bne          <= '0';
        j            <= '0';
        mem_read     <= '0';
        mem_write    <= '0';
        mem_to_reg   <= '0';
        reg_write    <= '0';

        case op5 is
            -- R-type
            when "00000" =>
                RegDst    <= '1';
                reg_write <= '1';
                ext_op    <= '0';
                alu_src   <= '1';
                case func6 is
                    when "000000" => alu_mode_sel <= "10"; arith_sel <= "000"; -- ADD
                    when "000001" => alu_mode_sel <= "10"; arith_sel <= "001"; -- ADDu
                    when "000010" => alu_mode_sel <= "10"; arith_sel <= "010"; -- SUB
                    when "000011" => alu_mode_sel <= "10"; arith_sel <= "011"; -- SUBU
                    when "000100" => alu_mode_sel <= "11"; logic_sel <= "00";  -- AND
                    when "000101" => alu_mode_sel <= "11"; logic_sel <= "01";  -- OR
                    when "000110" => alu_mode_sel <= "11"; logic_sel <= "10";  -- XOR
                    when "000111" => alu_mode_sel <= "11"; logic_sel <= "11";  -- NOR   
                    when "001000" => alu_mode_sel <= "00"; shift_sel <= "00";  -- SLL
                    when "001001" => alu_mode_sel <= "00"; shift_sel <= "01";  -- SRL
                    when "001010" => alu_mode_sel <= "00"; shift_sel <= "10";  -- SRA
                    when "001011" => alu_mode_sel <= "00"; shift_sel <= "11";  -- ROR
                    when "001100" => alu_mode_sel <= "01"; arith_sel <= "100"; -- SLT
                    when "001101" => alu_mode_sel <= "01"; arith_sel <= "101"; -- SLTu
                    when others =>
                        alu_mode_sel <= "10"; arith_sel <= "000"; -- Default ADD
                end case;
                
            -- ADDi
            when "00001" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
             
             -- ADDiu
            when "00010" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "001"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
             
             -- Andi
            when "00011" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "11"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
            
            -- Ori
            when "00100" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "11"; 
                arith_sel    <= "000"; 
                logic_sel    <= "01";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
            
            -- Xori
            when "00101" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "11"; 
                arith_sel    <= "000"; 
                logic_sel    <= "10";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
             
            -- Lui
            when "00110" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '1';
                alu_mode_sel <= "00"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1'; 
                
            -- Load Word (lw)
            when "00111" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '1';
                mem_write    <= '0';
                mem_to_reg   <= '1';
                reg_write    <= '1';

            -- Store Word (sw)
            when "01000" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '1';
                mem_to_reg   <= '0';
                reg_write    <= '0';

            -- BEQ
            when "01001" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '1';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "010"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '1';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '0';

            -- BNE
            when "01010" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '1';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "010"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '1';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '0';
            
            -- Slti
            when "01111" =>
                RegDst       <= '0';
                ext_op       <= '1';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "01"; 
                arith_sel    <= "100";
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
            
            -- Sltiu
            when "10000" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "01"; 
                arith_sel    <= "101";
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '0';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '1';
            
            -- JUMP
            when "10001" =>
                RegDst       <= '0';
                ext_op       <= '0';
                alu_src      <= '0';
                if_imm       <= '0';
                alu_mode_sel <= "10"; 
                arith_sel    <= "000"; 
                logic_sel    <= "00";
                shift_sel    <= "00";
                beq          <= '0';
                bne          <= '0';
                j            <= '1';
                mem_read     <= '0';
                mem_write    <= '0';
                mem_to_reg   <= '0';
                reg_write    <= '0';

            -- Default/fallback
            when others =>
                null;
        end case;

        -- Combine control signals
        
    end process;
    
    alu_ctrl <= if_imm & logic_sel & arith_sel & shift_sel & alu_mode_sel;
    control_signals <= ext_op & alu_src & alu_ctrl & beq & bne & j & mem_read & mem_write & mem_to_reg & reg_write;

end Behavioral;