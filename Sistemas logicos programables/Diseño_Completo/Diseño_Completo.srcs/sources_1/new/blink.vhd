----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 22:18:16
-- Design Name: 
-- Module Name: blink - Behavioral
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

entity blink is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sig: in std_logic;
           fin : in STD_LOGIC_VECTOR (1 downto 0);
           irt : out STD_LOGIC_VECTOR (1 downto 0));
end blink;

architecture Behavioral of blink is

signal izquierda,derecha:std_logic;

begin


blink: process(reset,clk,fin)
begin
if reset='1' then
izquierda<='0';
derecha<='0';

elsif clk' event and clk='1' then
    if(fin="10") then---------------------2
    izquierda<=sig;
    elsif(fin="01") then
    derecha<=sig; 
    else
    izquierda<=izquierda;
    derecha<=derecha;
    end if;
                        


end if;


irt(1)<=izquierda;
irt(0)<=derecha;

end process blink;



end Behavioral;