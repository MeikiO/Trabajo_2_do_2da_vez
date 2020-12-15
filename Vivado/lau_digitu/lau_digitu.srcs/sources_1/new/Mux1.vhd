----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 17:34:53
-- Design Name: 
-- Module Name: Mux1 - Behavioral
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

entity Mux1 is
    Port ( t1 : in STD_LOGIC_VECTOR (6 downto 0);
           t2 : in STD_LOGIC_VECTOR (6 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           fijo : out STD_LOGIC_VECTOR (6 downto 0);
           quitar : out STD_LOGIC_VECTOR (6 downto 0));
end Mux1;

architecture Behavioral of Mux1 is

begin

fijo<= t2 when sel="10" else t1;
quitar<=t1 when sel="10" else t2;

end Behavioral;
