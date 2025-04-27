library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Execution is
    Port (
        -- Inputs
        A, B             : in  std_logic_vector(31 downto 0);
        imm26            : in  std_logic_vector(25 downto 0);
        pc_plus4         : in  std_logic_vector(31 downto 0);
        ALU_ctrl         : in  std_logic_vector(9 downto 0);
        ALU_src          : in  std_logic;
        ext_op           : in  std_logic;
        J, BEQ, BNE      : in  std_logic;

        -- Outputs
        alu_result       : out std_logic_vector(31 downto 0);
        pc_next          : out std_logic_vector(31 downto 0);
        pc_src           : out std_logic;
        flush_out        : out std_logic
    );
end Execution;

architecture Behavioral of Execution is
    -- Internal signals
    signal extended_imm  : std_logic_vector(31 downto 0);
    signal operand2_final: std_logic_vector(31 downto 0);
    signal zero          : std_logic;
begin

    -- Extender
    extender_inst: entity work.Extender
        port map (
            imm_in  => imm26(15 downto 0),
            ext_op  => ext_op,
            imm_out => extended_imm
        );

    -- ALU Operand2 Mux
    alu_mux_inst: entity work.ALU_operand2_MUX
        port map (
            extended_imm   => extended_imm,
            operandB       => B,
            ALU_src        => ALU_src,
            operand2_final => operand2_final
        );

    -- ALU
    alu_inst: entity work.ALU
        port map (
            A            => A,
            B            => operand2_final,
            ALU_ctrl     => ALU_ctrl,
            sa           => imm26(10 downto 6),
            outp         => alu_result,
            zero         => zero
        );

    -- Next PC
    nextpc_inst: entity work.NextPC
        port map (
            pc_plus4     => pc_plus4,
            immediate_26 => imm26,
            J            => J,
            BEQ          => BEQ,
            BNE          => BNE,
            zero         => zero,
            pc_next      => pc_next,
            pc_src       => pc_src,
            flush_out    => flush_out
        );

end Behavioral;