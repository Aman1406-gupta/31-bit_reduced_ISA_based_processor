library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    Port (
        op5            : in  std_logic_vector(4 downto 0);
        func6          : in  std_logic_vector(5 downto 0);
        stall          : in  std_logic;
        RegDst         : out std_logic;
        stall_mux_out  : out std_logic_vector(18 downto 0)
    );
end Control_Unit;

architecture Structural of Control_Unit is

    -- Internal signal to connect outputs of Main_And_ALU_Control to Stall_Mux
    signal control_signals_internal : std_logic_vector(18 downto 0);

begin

    -- Instantiate Main_And_ALU_Control
    MainCtrl: entity work.Main_And_ALU_Control
        port map (
            op5             => op5,
            func6           => func6,
            RegDst          => RegDst,
            control_signals => control_signals_internal
        );

    -- Instantiate Stall_Mux
    StallMux: entity work.Stall_Mux
        port map (
            control_signals => control_signals_internal,
            stall           => stall,
            stall_mux_out   => stall_mux_out
        );

end Structural;