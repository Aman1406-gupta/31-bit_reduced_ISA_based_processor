library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Forwarding_Stage is
    Port (
        ra_data    : in  std_logic_vector(31 downto 0);
        rb_data    : in  std_logic_vector(31 downto 0);
        fwdaluA    : in  std_logic_vector(31 downto 0);
        fwdmemA    : in  std_logic_vector(31 downto 0);
        fwdwbA     : in  std_logic_vector(31 downto 0);
        fwdaluB    : in  std_logic_vector(31 downto 0);
        fwdmemB    : in  std_logic_vector(31 downto 0);
        fwdwbB     : in  std_logic_vector(31 downto 0);
        fwdA       : in  std_logic_vector(1 downto 0);
        fwdB       : in  std_logic_vector(1 downto 0);
        outpA      : out std_logic_vector(31 downto 0);
        outpB      : out std_logic_vector(31 downto 0)
    );
end Forwarding_Stage;

architecture Structural of Forwarding_Stage is
begin

    -- Forwarding for ALU input A
    muxA: entity work.ForwardingMUX
        port map (
            input0 => ra_data,
            input1 => fwdaluA,
            input2 => fwdmemA,
            input3 => fwdwbA,
            selec  => fwdA,
            outp   => outpA
        );

    -- Forwarding for ALU input B
    muxB: entity work.ForwardingMUX
        port map (
            input0 => rb_data,
            input1 => fwdaluB,
            input2 => fwdmemB,
            input3 => fwdwbB,
            selec  => fwdB,
            outp   => outpB
        );

end Structural;