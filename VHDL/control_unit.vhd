---------------------------------------------------------------------------
-- control_unit.vhd - Control Unit Implementation
--
-- Notes: refer to headers in single_cycle_core.vhd for the supported ISA.
--
--  control signals:
--     reg_dst    : asserted for ADD instructions, so that the register
--                  destination number for the 'write_register' comes from
--                  the rd field (bits 3-0). 
--     reg_write  : asserted for ADD and LOAD instructions, so that the
--                  register on the 'write_register' input is written with
--                  the value on the 'write_data' port.
--     alu_src    : asserted for LOAD and STORE instructions, so that the
--                  second ALU operand is the sign-extended, lower 4 bits
--                  of the instruction.
--     mem_write  : asserted for STORE instructions, so that the data 
--                  memory contents designated by the address input are
--                  replaced by the value on the 'write_data' input.
--     mem_to_reg : asserted for LOAD instructions, so that the value fed
--                  to the register 'write_data' input comes from the
--                  data memory.
--
--
-- Copyright (C) 2006 by Lih Wen Koh (lwkoh@cse.unsw.edu.au)
-- All Rights Reserved. 
--
-- The single-cycle processor core is provided AS IS, with no warranty of 
-- any kind, express or implied. The user of the program accepts full 
-- responsibility for the application of the program and the use of any 
-- results. This work may be downloaded, compiled, executed, copied, and 
-- modified solely for nonprofit, educational, noncommercial research, and 
-- noncommercial scholarship purposes provided that this notice in its 
-- entirety accompanies all copies. Copies of the modified software can be 
-- delivered to persons who use it solely for nonprofit, educational, 
-- noncommercial research, and noncommercial scholarship purposes provided 
-- that this notice in its entirety accompanies all copies.
--
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
    port ( opcode     : in  std_logic_vector(3 downto 0);
           reg_dst    : out std_logic;
           reg_write  : out std_logic;
           alu_src    : out std_logic;
           mem_write  : out std_logic;
           mem_to_reg : out std_logic;
           ex_reg     : out std_logic_vector(2 downto 0);
           cmp_mode   : out std_logic;
           branch_jmp : out std_logic_vector(1 downto 0);
           mem_read   : out std_logic;
           shift_mode : out std_logic;
           alu_mode   : out std_logic);
end control_unit;

architecture behavioural of control_unit is

constant OP_LOAD  : std_logic_vector(3 downto 0) := "0001";
constant OP_STORE : std_logic_vector(3 downto 0) := "0010";
constant OP_SWAP  : std_logic_vector(3 downto 0) := "0011";
constant OP_ROLB  : std_logic_vector(3 downto 0) := "0100";
constant OP_XORB  : std_logic_vector(3 downto 0) := "0101";
constant OP_ADD   : std_logic_vector(3 downto 0) := "0110";
constant OP_JMP   : std_logic_vector(3 downto 0) := "0111";
constant OP_BNE   : std_logic_vector(3 downto 0) := "1000";
constant OP_BEQ   : std_logic_vector(3 downto 0) := "1001";
constant OP_ADDI  : std_logic_vector(3 downto 0) := "1010";
constant OP_SLLV  : std_logic_vector(3 downto 0) := "1011";
constant OP_SRLV  : std_logic_vector(3 downto 0) := "1100";
constant OP_SUB   : std_logic_vector(3 downto 0) := "1101";

begin

    reg_dst    <= '1' when (opcode = OP_ADD
                            or opcode = OP_SWAP
                            or opcode = OP_ROLB
                            or opcode = OP_XORB
                            or opcode = OP_SLLV
                            or opcode = OP_SRLV
                            or opcode = OP_SUB) else
                  '0';

    reg_write  <= '1' when (opcode = OP_ADD 
                            or opcode = OP_LOAD
                            or opcode = OP_SWAP
                            or opcode = OP_ROLB
                            or opcode = OP_XORB
                            or opcode = OP_ADDI
                            or opcode = OP_SLLV
                            or opcode = OP_SRLV
                            or opcode = OP_SUB) else
                  '0';
    
    alu_src    <= '1' when (opcode = OP_LOAD 
                           or opcode = OP_STORE
                           or opcode = OP_ADDI) else
                  '0';
                 
    mem_write  <= '1' when opcode = OP_STORE else
                  '0';
                 
    mem_to_reg <= '1' when (opcode = OP_LOAD) else
                  '0';
                  
    ex_reg     <= "001" when opcode = OP_ROLB else
                  "010" when opcode = OP_SWAP else
                  "011" when opcode = OP_XORB else
                  "100" when (opcode = OP_SLLV or opcode = OP_SRLV) else
                  "000";
    
    cmp_mode  <=  '1' when opcode = OP_BEQ else
                  '0';
                  
    branch_jmp     <= "01" when opcode = OP_JMP else
                      "10" when (opcode = OP_BNE or opcode = OP_BEQ) else
                      "00";
                      
    mem_read <= '1' when opcode = OP_LOAD else
                '0';
                
    shift_mode <= '1' when opcode = OP_SRLV else
                  '0';
                  
    alu_mode <= '1' when opcode = OP_SUB else
                '0';
                
end behavioural;
