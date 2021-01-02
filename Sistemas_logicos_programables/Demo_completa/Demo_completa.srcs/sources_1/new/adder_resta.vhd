----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 17:43:29
-- Design Name: 
-- Module Name: adder_resta - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_resta is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           val1 : in STD_LOGIC;
           val2 : in STD_LOGIC;
           balioa:in STD_LOGIC_VECTOR (6 downto 0);
           izquierda : out STD_LOGIC_VECTOR (6 downto 0);
           derecha : out STD_LOGIC_VECTOR (6 downto 0);
           fin : out STD_LOGIC_vector(1 downto 0));
end adder_resta;

architecture Behavioral of adder_resta is

signal blok : std_logic;
signal elementu_d,elementu_i: STD_LOGIC_VECTOR (6 downto 0);

begin

contar: process(reset,clk)
begin
if reset='1' then
elementu_d<=balioa;
elementu_i<=balioa;
fin<="00";
blok<='0';


elsif clk' event and clk='1' then
    if(val1='1' and val2='0') and blok='0' then---------------------2
        if (elementu_d<=0)then    ---------------3
        fin<="01";
        elementu_d<="0000000";
        blok<='1';
        else 
        elementu_d<=elementu_d-1;
        fin<="00";
    end if;                     ------------3

  elsif(val1='0' and val2='1') and blok='0' then---------------------2
    if (elementu_i<=0)then    ---------------3
    fin<="10";
    elementu_i<="0000000";
    blok<='1';
    else 
    elementu_i<=elementu_i-1;
    fin<="00";
end if;

end if;

end if;


derecha<=elementu_d;
izquierda<=elementu_i;

end process contar;


end Behavioral;