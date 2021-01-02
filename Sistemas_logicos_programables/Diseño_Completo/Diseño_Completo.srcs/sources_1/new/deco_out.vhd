----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2021 13:16:22
-- Design Name: 
-- Module Name: deco_out - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deco_out is
    Port ( auk : in STD_LOGIC_VECTOR (1 downto 0);
           mandar : out STD_LOGIC_VECTOR (7 downto 0));
end deco_out;

architecture Behavioral of deco_out is

begin

mandar<=conv_std_logic_vector(character'pos('i'),8) when auk="10" else   --i
        conv_std_logic_vector(character'pos('d'),8) when auk="01" ;      --d


end Behavioral;
