----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 17:59:20
-- Design Name: 
-- Module Name: temp - Behavioral
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

entity temp is
    Port ( rst : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end temp;

architecture Behavioral of temp is

signal kont: std_logic_vector(26 downto 0);

begin

process(rst, clk_in)
begin
if rst='1' then
    kont<=(others=>'0');
elsif clk_in'event and clk_in='1' then
    if kont="101111101011110000100000000" then --100.000.000
     -- if kont="000000000000000000000000001" then  --simulacion
        kont<=(others=>'0');
    else
        kont<=kont+1;
    end if;
    if kont<"010111110101111000010000000" then -- 6250000
   -- if kont="000000000000000000000000001" then --simulacion
        clk_out<='1';
    else
        clk_out<='0';
        
    end if;
end if;
end process;

--clk_out<='1' when kont<"010111110101111000010000000" else  --50.000.000
--        '0';

end Behavioral;
