----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2022 06:48:11 PM
-- Design Name: 
-- Module Name: xor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xor_module is
    Port (  vote_record : in std_logic_vector(31 downto 0);
            data_out    : out std_logic_vector(7 downto 0));
end xor_module;

architecture Behavioral of xor_module is

begin

    data_out <= vote_record(31 downto 24) xor vote_record(23 downto 16) xor vote_record(15 downto 8) xor vote_record(7 downto 0);

end Behavioral;
