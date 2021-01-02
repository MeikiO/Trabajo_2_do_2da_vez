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
    Port ( reset,clk: in std_logic;
            auk : in STD_LOGIC_VECTOR (1 downto 0);
            time1,time2: in std_logic;
           mandar : out STD_LOGIC_VECTOR (7 downto 0);
           enviar: out std_logic);
end deco_out;

architecture Behavioral of deco_out is



begin

process(reset,clk)
begin
if reset='1' then
    enviar<='0';
    mandar<=conv_std_logic_vector(character'pos('s'),8);
elsif clk'event and clk='1' then

   if time1='1' and time2='0' and auk= "00" then
   mandar<=conv_std_logic_vector(character'pos('d'),8);
   enviar<='0';
   end if;
   
   if time1='0' and time2='1' and auk= "00" then
    mandar<=conv_std_logic_vector(character'pos('i'),8);
    enviar<='0';
    end if;
   if auk= "10" then
    mandar<= conv_std_logic_vector(character'pos('g'),8);
    enviar<='1';
    end if;
   
   if auk="01" then

   mandar<=conv_std_logic_vector(character'pos('h'),8) ;   
   enviar<='1';
   end if;



end if;
end process;



end Behavioral;
