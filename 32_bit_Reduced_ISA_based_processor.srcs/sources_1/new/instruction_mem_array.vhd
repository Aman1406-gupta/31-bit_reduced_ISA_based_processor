-- File: ISA_Pkg.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ISA_Pkg is
    type mem_array is array (0 to 255) of std_logic_vector(31 downto 0);
end ISA_Pkg;

package body ISA_Pkg is
end ISA_Pkg;