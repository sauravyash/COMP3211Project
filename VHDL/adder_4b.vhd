---------------------------------------------------------------------------
-- adder_4b.vhd - 4-bit Adder Implementation
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

entity adder_8b is
    port ( src_a     : in  std_logic_vector(7 downto 0);
           src_b     : in  std_logic_vector(7 downto 0);
           stall     : in std_logic;
           sum       : out std_logic_vector(7 downto 0);
           carry_out : out std_logic );
end adder_8b;

architecture behavioural of adder_8b is

signal sig_result : std_logic_vector(8 downto 0);

begin

    sig_result <= ('0' & src_a) + ('0' & src_b);
    sum        <= sig_result(7 downto 0) when stall = '0' else
                  src_a;
    carry_out  <= sig_result(8);
    
end behavioural;
