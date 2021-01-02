----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2021 17:21:56
-- Design Name: 
-- Module Name: mux1 - Behavioral
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

entity mux1 is
    Port ( derecha : in STD_LOGIC;
           izquierda : in STD_LOGIC;
           enviar : in STD_LOGIC;
           irt : out STD_LOGIC);
end mux1;

architecture Behavioral of mux1 is

signal temp: std_logic;

begin

temp<= derecha or izquierda;

irt<=enviar or temp;


end Behavioral;
