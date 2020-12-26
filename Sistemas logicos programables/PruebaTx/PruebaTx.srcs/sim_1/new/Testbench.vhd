----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.12.2020 12:07:51
-- Design Name: 
-- Module Name: Testbench - Behavioral
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

entity Testbench is
--  Port ( );
end Testbench;

architecture Behavioral of Testbench is

component ProFit is
    Port ( clk : in STD_LOGIC; 
        reset: in STD_LOGIC; 
        time1,time2: in std_logic;
       rx: in std_logic; 
       tx: out std_logic; 
       zero: out std_logic_vector(5 downto 0)); 
end component;

signal clk , reset,time1,time2,rx,tx:  std_logic; 
signal zero:  std_logic_vector(5 downto 0); 

begin

sim: ProFit Port map ( clk =>clk  ,
        reset=> reset ,
        time1=> time1 ,
        time2=>time2  ,
       rx=> rx ,
       tx=> tx , 
       zero=>  zero); 

simulacion_clock: process
begin

clk<='1';
wait for 5ns;

clk<='0';
wait for 5ns;

end process;


simulacion: process
begin


reset<= '0';
time1<= '0';
time2<= '0';
rx<= '0';
tx<= '0'; 
zero<= "zzzzzz";
wait for 50ns;


       
end process;

end Behavioral;
