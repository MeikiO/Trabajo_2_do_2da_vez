----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2020 20:13:43
-- Design Name: 
-- Module Name: FSTM - Behavioral
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

entity FSTM is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           w19 : in STD_LOGIC;
           t17 : in STD_LOGIC;
           time1 :out STD_LOGIC;
           time2 : out STD_LOGIC);
end FSTM;

architecture Behavioral of FSTM is
type egoera is (init,ezker,eskuin);
signal oraingoa, hurrengoa: egoera;

begin

sek: process(clk,reset)
begin
if reset='1' then
    oraingoa<= init       ;       --------primera egoera despues de reset
elsif clk'event and clk='1' then
    oraingoa<=hurrengoa;
end if;
end process;



egoerak: process( w19,t17) 
begin

case oraingoa is


when init  =>       --egoeras
time1<='0';
time2<='0';

if( w19  ='0' and  t17  ='1' ) then 
hurrengoa<=ezker  ;
elsif( w19='1' and t17  ='0' ) then 
hurrengoa<=eskuin  ;
else
hurrengoa<= init ;   --para quedarse en la misma egoera
end if;


when ezker  =>       --egoeras
time1<='1';
time2<='0';


if(  w19  ='1' and t17='0') then 
hurrengoa<=eskuin     ;
else
hurrengoa<= ezker ;   --para quedarse en la misma egoera
end if;


when eskuin  =>       --egoeras
time1<='0';
time2<='1';


if( w19  ='0' and t17='1') then 
hurrengoa<=ezker      ;
else
hurrengoa<= eskuin ;   --para quedarse en la misma egoera
end if;



end case;


end process;





end Behavioral;
