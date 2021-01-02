----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2021 13:16:22
-- Design Name: 
-- Module Name: selector - Behavioral
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

entity selector is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
           valor : out STD_LOGIC_VECTOR (6 downto 0));
end selector;

architecture Behavioral of selector is

begin

valor<="0100001" when entrada=conv_std_logic_vector(character'pos('a'),8) else  -- valor=33 cuando entrada=a
       "1000010" when entrada=conv_std_logic_vector(character'pos('b'),8) else -- valor=66 cuando entrada=b
       "1100011" when entrada=conv_std_logic_vector(character'pos('c'),8) ; -- valor=99 cuando entrada =c

end Behavioral;
