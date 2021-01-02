----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2020 17:47:05
-- Design Name: 
-- Module Name: f_zat - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity f_zat is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end f_zat;

architecture Behavioral of f_zat is
signal kont:std_logic_vector(16 downto 0);

begin
process(rst,clk)
begin
if rst='1' then
    kont<=(others=>'0');
elsif clk'event and clk='1' then
    if kont<100000 then
        kont<=kont+1;
    else
        kont<=(others=>'0');
    end if;
    if kont<50000 then
        clk_out<='1';
    else
        clk_out<='0';
    end if;
end if;
end process;


end Behavioral;
