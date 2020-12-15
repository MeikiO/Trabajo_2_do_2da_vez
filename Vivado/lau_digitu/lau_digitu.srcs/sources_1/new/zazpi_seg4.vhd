----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2020 17:28:06
-- Design Name: 
-- Module Name: zazpi_seg4 - Behavioral
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

entity zazpi_seg4 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           bin_h_i,bin_b_i,bin_h_d,bin_b_d: in STD_LOGIC_VECTOR (6 downto 0);
           anodo : out STD_LOGIC_VECTOR (3 downto 0);
           katodo : out STD_LOGIC_VECTOR (6 downto 0));
end zazpi_seg4;

architecture Behavioral of zazpi_seg4 is
type egoera is (reset, bateko, hamarreko, ehuneko, milako);
signal oraingoa, hurrengoa: egoera;

begin
SEQ: process (rst,clk)
begin
if rst='1' then
    oraingoa<=reset;
elsif clk'event and clk='1' then
    oraingoa<=hurrengoa;
end if;
end process;
COMB: process (oraingoa)
begin
case oraingoa is
when reset=>
    anodo<="1111";
    katodo<="1111111";
    hurrengoa<=bateko;
when bateko=>
    anodo<="1110";
    katodo<=bin_b_d;
    hurrengoa<=hamarreko;
when hamarreko=>
    anodo<="1101";
    katodo<=bin_h_d;
    hurrengoa<=ehuneko;
when ehuneko=>
    anodo<="1011";
    katodo<=bin_b_i;
    hurrengoa<=milako;
when milako=>
    anodo<="0111";
    katodo<=bin_h_i;
    hurrengoa<=bateko;
when others=>
    anodo<="1111";
    katodo<="1111111";
    hurrengoa<=reset;
end case;
end process;

end Behavioral;
