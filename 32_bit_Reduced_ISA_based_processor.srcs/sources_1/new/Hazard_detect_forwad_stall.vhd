library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hazard_Detect_Forward_Stall is
    Port (
        rs            : in  std_logic_vector(4 downto 0);
        rt            : in  std_logic_vector(4 downto 0);
        rd2_out       : in  std_logic_vector(4 downto 0); -- EX stage
        rd3_out       : in  std_logic_vector(4 downto 0); -- MEM stage
        rd4_out       : in  std_logic_vector(4 downto 0); -- WB stage
        reg_write_exe : in  std_logic;
        reg_write_mem : in  std_logic;
        reg_write_wb  : in  std_logic;
        mem_read_exe  : in  std_logic;

        stall         : out std_logic;
        fwdA          : out std_logic_vector(1 downto 0);
        fwdB          : out std_logic_vector(1 downto 0)
    );
end Hazard_Detect_Forward_Stall;

architecture Behavioral of Hazard_Detect_Forward_Stall is
begin

    process(rs, rt, rd2_out, rd3_out, rd4_out, reg_write_exe, reg_write_mem, reg_write_wb, mem_read_exe)
        variable stall_internal : std_logic := '0';
        variable fwdA_internal  : std_logic_vector(1 downto 0) := "00";
        variable fwdB_internal  : std_logic_vector(1 downto 0) := "00";
    begin
        -- ====== Stall detection ======
        -- Load-Use Hazard: if rs or rt == rd2_out and EX stage is loading
        if (mem_read_exe = '1') and
           ((rd2_out = rs and rs /= "00000") or (rd2_out = rt and rt /= "00000")) then
            stall_internal := '1';
        else
            stall_internal := '0';
        end if;

        -- ====== Forwarding for rs (fwdA) ======
        if (reg_write_exe = '1') and (rd2_out = rs) and (rd2_out /= "00000") then
            fwdA_internal := "01"; -- Forward from EX
        elsif (reg_write_mem = '1') and (rd3_out = rs) and (rd3_out /= "00000") then
            fwdA_internal := "10"; -- Forward from MEM
        elsif (reg_write_wb = '1') and (rd4_out = rs) and (rd4_out /= "00000") then
            fwdA_internal := "11"; -- Forward from WB
        else
            fwdA_internal := "00"; -- No forwarding (use original)
        end if;

        -- ====== Forwarding for rt (fwdB) ======
        if (reg_write_exe = '1') and (rd2_out = rt) and (rd2_out /= "00000") then
            fwdB_internal := "01"; -- Forward from EX
        elsif (reg_write_mem = '1') and (rd3_out = rt) and (rd3_out /= "00000") then
            fwdB_internal := "10"; -- Forward from MEM
        elsif (reg_write_wb = '1') and (rd4_out = rt) and (rd4_out /= "00000") then
            fwdB_internal := "11"; -- Forward from WB
        else
            fwdB_internal := "00"; -- No forwarding
        end if;

        -- Assign outputs
        stall <= stall_internal;
        fwdA  <= fwdA_internal;
        fwdB  <= fwdB_internal;
    end process;

end Behavioral;