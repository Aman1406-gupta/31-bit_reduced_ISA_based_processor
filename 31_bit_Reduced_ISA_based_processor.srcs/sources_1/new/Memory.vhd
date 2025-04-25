library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory is
    Port (
        -- Inputs from EX/MEM stage
        clk          : in  std_logic;
        mem_read     : in  std_logic;
        mem_write    : in  std_logic;
        Mem_to_reg   : in  std_logic;
        data_inp     : in  std_logic_vector(31 downto 0); -- to write to memory
        ALU_result   : in  std_logic_vector(31 downto 0); -- also used for write-back

        -- Outputs to WB stage
        wb_data_final: out std_logic_vector(31 downto 0)  -- final data to write back
    );
end Memory;

architecture Structural of Memory is
    signal mem_data : std_logic_vector(31 downto 0);
begin

    -- Instantiate Data Memory
    mem_inst: entity work.Data_Mem
        port map (
            address   => ALU_result,
            data_inp  => data_inp,
            clk       => clk,
            mem_read  => mem_read,
            mem_write => mem_write,
            data_out  => mem_data
        );

    -- Instantiate WB Mux
    wb_mux_inst: entity work.Wb_Mux
        port map (
            ALU_result    => ALU_result,
            data_out      => mem_data,
            Mem_to_reg    => Mem_to_reg,
            wb_data_final => wb_data_final
        );

end Structural;