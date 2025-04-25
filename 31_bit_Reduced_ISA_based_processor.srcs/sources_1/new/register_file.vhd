library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;

        -- Read register addresses
        ra_addr    : in  std_logic_vector(4 downto 0);
        rb_addr    : in  std_logic_vector(4 downto 0);

        -- Write register address and data
        rw_addr    : in  std_logic_vector(4 downto 0);
        rw_data    : in  std_logic_vector(31 downto 0);
        reg_write  : in  std_logic;

        -- Read outputs
        ra_data    : out std_logic_vector(31 downto 0);
        rb_data    : out std_logic_vector(31 downto 0);
        
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
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    -- Combinational read
    ra_data <= regs(to_integer(unsigned(ra_addr)));
    rb_data <= regs(to_integer(unsigned(rb_addr)));

    -- Synchronous write
    process(clk, reset)
    begin
        if reset = '1' then
            regs <= (10 => "11111111111111111111111111111110",
                     others => (others => '0'));
        elsif falling_edge(clk) then
            if reg_write = '1' and rw_addr /= "00000" then
                regs(to_integer(unsigned(rw_addr))) <= rw_data;
            end if;
        end if;
    end process;

    -- Map each register to its output port
    r0  <= regs(0);
    r1  <= regs(1);
    r2  <= regs(2);
    r3  <= regs(3);
    r4  <= regs(4);
    r5  <= regs(5);
    r6  <= regs(6);
    r7  <= regs(7);
    r8  <= regs(8);
    r9  <= regs(9);
    r10 <= regs(10);
    r11 <= regs(11);
    r12 <= regs(12);
    r13 <= regs(13);
    r14 <= regs(14);
    r15 <= regs(15);
    r16 <= regs(16);
    r17 <= regs(17);
    r18 <= regs(18);
    r19 <= regs(19);
    r20 <= regs(20);
    r21 <= regs(21);
    r22 <= regs(22);
    r23 <= regs(23);
    r24 <= regs(24);
    r25 <= regs(25);
    r26 <= regs(26);
    r27 <= regs(27);
    r28 <= regs(28);
    r29 <= regs(29);
    r30 <= regs(30);
    r31 <= regs(31);

end Behavioral;