library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ISA_Pkg.all;

entity Reduced_ISA_Processor is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        program : in  mem_array;
        
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
end Reduced_ISA_Processor;

architecture Structural of Reduced_ISA_Processor is

    -- === Wires for each stage ===

    -- IF stage
    signal pc_out      : std_logic_vector(31 downto 0);
    signal instruction : std_logic_vector(30 downto 0);
    signal pc_src      : std_logic;

    -- IF/ID
    signal rs, rt, rd, op5 : std_logic_vector(4 downto 0);
    signal func6           : std_logic_vector(5 downto 0);
    signal imm26           : std_logic_vector(25 downto 0);
    signal npc_out         : std_logic_vector(31 downto 0);

    -- ID stage
    signal operandA, operandB : std_logic_vector(31 downto 0);
    signal rd_final : std_logic_vector(4 downto 0);

    -- ID/EX
    signal npc2_out    : std_logic_vector(31 downto 0);
    signal operandA_out, operandB_out : std_logic_vector(31 downto 0);
    signal imm26_out  : std_logic_vector(25 downto 0);
    signal imm16_out  : std_logic_vector(15 downto 0);
    signal rd2_out   : std_logic_vector(4 downto 0);
    signal ext_op, alu_src, beq, bne, j, mem_read_exe, reg_write_exe : std_logic;
    signal alu_ctrl  : std_logic_vector(9 downto 0);
    signal exe_reg_out : std_logic_vector(3 downto 0);

    -- EX stage
    signal alu_result_ex, pc_npc : std_logic_vector(31 downto 0);

    -- EX/MEM
    signal alu_result, data_inp : std_logic_vector(31 downto 0);
    signal rd3_out : std_logic_vector(4 downto 0);
    signal mem_read_mem, mem_write_mem, mem_to_reg_mem, reg_write_mem : std_logic;
    
    -- Mem stage

    -- MEM/WB
    signal wb_data_final : std_logic_vector(31 downto 0);
    signal rd4_out : std_logic_vector(4 downto 0);
    signal reg_write_wb : std_logic;
    signal wb_data : std_logic_vector(31 downto 0);
    
    
    -- Control
    signal stall, regdst : std_logic;
    signal stall_mux_out : std_logic_vector(18 downto 0);

    -- Forwarding
    signal fwdA, fwdB : std_logic_vector(1 downto 0);

begin

    -- ===== Instruction Fetch Stage =====
    IFetch: entity work.InstructionFetch
        port map (
            clk         => clk,
            reset       => reset,
            pc_enable   => '1',
            disable_pc  => stall,
            pc_npc      => pc_npc,
            pc_src      => pc_src,
            program     => program,
            instruction => instruction,
            pc_out      => pc_out
        );

    -- ===== IF/ID Register =====
    IFID: entity work.IF_ID_Register
        port map (
            clk         => clk,
            reset       => reset,
            stall       => stall,
            instruction => instruction,
            rs_addr     => rs,
            rt_addr     => rt,
            rd_addr     => rd,
            Op5         => op5,
            func6       => func6,
            imm26       => imm26,
            npc_in      => pc_out,
            npc_out     => npc_out
        );

    -- ===== Instruction Decode Stage =====
    ID: entity work.Instruction_Decode
        port map (
            clk        => clk,
            reset      => reset,
            ra_addr    => rs,
            rb_addr    => rt,
            rw_addr    => rd4_out,
            rw_data    => wb_data,
            reg_write  => reg_write_wb,
            fwdaluA    => alu_result_ex,
            fwdmemA    => wb_data_final,
            fwdwbA     => wb_data,
            fwdaluB    => alu_result_ex,
            fwdmemB    => wb_data_final,
            fwdwbB     => wb_data,
            fwdA       => fwdA,
            fwdB       => fwdB,
            outpA      => operandA,
            outpB      => operandB,
            rd_add     => rd,
            regdst     => regdst,
            rd_final   => rd_final,
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

    -- ===== ID/EX Register =====
    IDEX: entity work.ID_EX_Register
        port map (
            clk           => clk,
            reset         => reset,
            npc           => npc_out,
            imm26         => imm26,
            operandA      => operandA,
            operandB      => operandB,
            rd_final      => rd_final,
            stall_mux_out => stall_mux_out,
            npc2_out      => npc2_out,
            imm26_out     => imm26_out,
            imm16_out     => imm16_out,
            operandA_out  => operandA_out,
            operandB_out  => operandB_out,
            rd2_out       => rd2_out,
            ext_op        => ext_op,
            Alu_src       => alu_src,
            Alu_ctrl      => alu_ctrl,
            beq           => beq,
            bne           => bne,
            j             => j,
            mem_read      => mem_read_exe,
            reg_write     => reg_write_exe,
            exe_reg_out   => exe_reg_out
        );

    -- ===== Execution Stage =====
    EXE: entity work.Execution
        port map (
            A           => operandA_out,
            B           => operandB_out,
            imm26       => imm26_out,
            pc_plus4    => npc2_out,
            ALU_ctrl    => alu_ctrl,
            ALU_src     => alu_src,
            ext_op      => ext_op,
            J           => j,
            BEQ         => beq,
            BNE         => bne,
            alu_result  => alu_result_ex,
            pc_next     => pc_npc,
            pc_src      => pc_src
        );

    -- ===== EX/MEM Register =====
    EXMEM: entity work.EX_MEM_Register
        port map (
            clk         => clk,
            reset       => reset,
            ALU_out     => alu_result_ex,
            operandB_out=> operandB_out,
            rd2_out     => rd2_out,
            exe_reg_out => exe_reg_out,
            ALU_result  => alu_result,
            data_inp    => data_inp,
            rd3_out     => rd3_out,
            mem_read    => mem_read_mem,
            mem_write   => mem_write_mem,
            Mem_to_reg  => mem_to_reg_mem,
            reg_write   => reg_write_mem
        );

    -- ===== Memory Stage =====
    MEM: entity work.Memory
        port map (
            clk           => clk,
            mem_read      => mem_read_mem,
            mem_write     => mem_write_mem,
            Mem_to_reg    => mem_to_reg_mem,
            data_inp      => data_inp,
            ALU_result    => alu_result,
            wb_data_final => wb_data_final
        );

    -- ===== Write Back Stage =====
    WB: entity work.Write_Back
        port map (
            clk           => clk,
            reset         => reset,
            wb_data_final => wb_data_final,
            rd3_out       => rd3_out,
            mem_reg_out   => reg_write_mem,
            wb_data       => wb_data,
            rd4_out       => rd4_out,
            reg_write     => reg_write_wb
        );
        
    -- ===== Control Unit =====
    CU: entity work.Control_Unit
        port map (
            op5            => op5,
            func6          => func6,
            stall          => stall,
            RegDst         => regdst,
            stall_mux_out  => stall_mux_out
        );

    -- ===== Hazard Detection and Forwarding =====
    HDS: entity work.Hazard_Detect_Forward_Stall
        port map (
            rs            => rs,
            rt            => rt,
            rd2_out       => rd2_out,
            rd3_out       => rd3_out,
            rd4_out       => rd4_out,
            reg_write_exe => reg_write_exe,
            reg_write_mem => reg_write_mem,
            reg_write_wb  => reg_write_wb,
            mem_read_exe  => mem_read_exe,
            stall         => stall,
            fwdA          => fwdA,
            fwdB          => fwdB
        );

end Structural;