library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Decode is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;

        -- Register File: input from instruction decode
        ra_addr    : in  std_logic_vector(4 downto 0);
        rb_addr    : in  std_logic_vector(4 downto 0);
        rw_addr    : in  std_logic_vector(4 downto 0);
        rw_data    : in  std_logic_vector(31 downto 0);
        reg_write  : in  std_logic;

        -- Forwarding inputs
        fwdaluA    : in  std_logic_vector(31 downto 0);
        fwdmemA    : in  std_logic_vector(31 downto 0);
        fwdwbA     : in  std_logic_vector(31 downto 0);
        fwdaluB    : in  std_logic_vector(31 downto 0);
        fwdmemB    : in  std_logic_vector(31 downto 0);
        fwdwbB     : in  std_logic_vector(31 downto 0);
        fwdA       : in  std_logic_vector(1 downto 0);
        fwdB       : in  std_logic_vector(1 downto 0);

        -- Output to ALU
        outpA      : out std_logic_vector(31 downto 0);
        outpB      : out std_logic_vector(31 downto 0);

        -- Destination MUX
        -- rt_add same as rb_addr
        rd_add     : in  std_logic_vector(4 downto 0);
        regdst     : in  std_logic;
        rd_final   : out std_logic_vector(4 downto 0);
        
        -- Register file outputs for debugging or monitoring
        r0         : out std_logic_vector(31 downto 0);
        r1         : out std_logic_vector(31 downto 0);
        r2         : out std_logic_vector(31 downto 0);
        r3         : out std_logic_vector(31 downto 0);
        r4         : out std_logic_vector(31 downto 0);
        r5         : out std_logic_vector(31 downto 0);
        r6         : out std_logic_vector(31 downto 0);
        r7         : out std_logic_vector(31 downto 0);
        r8         : out std_logic_vector(31 downto 0);
        r9         : out std_logic_vector(31 downto 0);
        r10        : out std_logic_vector(31 downto 0);
        r11        : out std_logic_vector(31 downto 0);
        r12        : out std_logic_vector(31 downto 0);
        r13        : out std_logic_vector(31 downto 0);
        r14        : out std_logic_vector(31 downto 0);
        r15        : out std_logic_vector(31 downto 0);
        r16        : out std_logic_vector(31 downto 0);
        r17        : out std_logic_vector(31 downto 0);
        r18        : out std_logic_vector(31 downto 0);
        r19        : out std_logic_vector(31 downto 0);
        r20        : out std_logic_vector(31 downto 0);
        r21        : out std_logic_vector(31 downto 0);
        r22        : out std_logic_vector(31 downto 0);
        r23        : out std_logic_vector(31 downto 0);
        r24        : out std_logic_vector(31 downto 0);
        r25        : out std_logic_vector(31 downto 0);
        r26        : out std_logic_vector(31 downto 0);
        r27        : out std_logic_vector(31 downto 0);
        r28        : out std_logic_vector(31 downto 0);
        r29        : out std_logic_vector(31 downto 0);
        r30        : out std_logic_vector(31 downto 0);
        r31        : out std_logic_vector(31 downto 0)
    );
end Instruction_Decode;

architecture Structural of Instruction_Decode is

    signal ra_data_internal, rb_data_internal : std_logic_vector(31 downto 0);

begin

    -- Register File instance
    regfile: entity work.RegisterFile
        port map (
            clk        => clk,
            reset      => reset,
            ra_addr    => ra_addr,
            rb_addr    => rb_addr,
            rw_addr    => rw_addr,
            rw_data    => rw_data,
            reg_write  => reg_write,
            ra_data    => ra_data_internal,
            rb_data    => rb_data_internal,
            r0         => r0,
            r1         => r1,
            r2         => r2,
            r3         => r3,
            r4         => r4,
            r5         => r5,
            r6         => r6,
            r7         => r7,
            r8         => r8,
            r9         => r9,
            r10        => r10,
            r11        => r11,
            r12        => r12,
            r13        => r13,
            r14        => r14,
            r15        => r15,
            r16        => r16,
            r17        => r17,
            r18        => r18,
            r19        => r19,
            r20        => r20,
            r21        => r21,
            r22        => r22,
            r23        => r23,
            r24        => r24,
            r25        => r25,
            r26        => r26,
            r27        => r27,
            r28        => r28,
            r29        => r29,
            r30        => r30,
            r31        => r31
        );

    -- Forwarding stage muxes
    fwdmuxes: entity work.Forwarding_Stage
        port map (
            ra_data    => ra_data_internal,
            rb_data    => rb_data_internal,
            fwdaluA    => fwdaluA,
            fwdmemA    => fwdmemA,
            fwdwbA     => fwdwbA,
            fwdaluB    => fwdaluB,
            fwdmemB    => fwdmemB,
            fwdwbB     => fwdwbB,
            fwdA       => fwdA,
            fwdB       => fwdB,
            outpA      => outpA,
            outpB      => outpB
        );

    -- Destination register mux
    destmux: entity work.destinationMux
        port map (
            rt_add   => rb_addr,
            rd_add   => rd_add,
            regdst   => regdst,
            rd_final => rd_final
        );

end Structural;