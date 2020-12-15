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
           sel : in std_logic_vector(1 downto 0);
           val : in STD_LOGIC_VECTOR (6 downto 0);
           irt : out STD_LOGIC_VECTOR (6 downto 0);
           fin : out STD_LOGIC_vector(1 downto 0));
end adder_resta;

architecture Behavioral of adder_resta is

signal elementu: STD_LOGIC_VECTOR (6 downto 0);

begin

contar: process(reset,clk)
begin
if reset='1' then
elementu<="0000000";

elsif clk' event and clk='1' then
    elementu<=val;
    if(elementu > "0000000") then 
        elementu<=elementu-1;
        fin<="00";
    else
    fin<=sel;
    end if;

end if;


  irt<=val;

end process contar;


end Behavioral;