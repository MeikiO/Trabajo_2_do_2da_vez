----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 17:59:34
-- Design Name: 
-- Module Name: mux2 - Behavioral
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

entity mux2 is
    Port ( v1 : in STD_LOGIC_VECTOR (6 downto 0);
           v2 : in STD_LOGIC_VECTOR (6 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           izquierda : out STD_LOGIC_VECTOR (6 downto 0);
           derecha : out STD_LOGIC_VECTOR (6 downto 0));
end mux2;

architecture Behavioral of mux2 is

begin

izquierda<= v1 when sel="01" else v2;
derecha <= v2 when sel="10" else v1;

end Behavioral;
