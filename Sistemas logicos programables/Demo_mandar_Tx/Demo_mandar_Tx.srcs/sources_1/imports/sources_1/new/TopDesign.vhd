library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TopDesign  is
    Port ( clk : in STD_LOGIC; 
        reset: in STD_LOGIC; 
        time1,time2: in std_logic;
        fin: in std_logic_vector(1 downto 0);
       tx: out std_logic); 
end TopDesign;

architecture Behavioral of TopDesign is

 component kcuart_tx is
        Port (        data_in : in std_logic_vector(7 downto 0);
               send_character : in std_logic;
                 en_16_x_baud : in std_logic;
                   serial_out : out std_logic;
                  Tx_complete : out std_logic;
                          clk : in std_logic);
        end component;


-- UART komunikaziorako erabiltzen diren seinaleak
signal etorritakoa,bidalibeharra: std_logic_vector(7 downto 0);
signal finllegada,en_16_x_baud,bidali,finbidali: std_logic;
signal baud_count : integer; --651


type egoera is (init,send);
signal oraingoa, hurrengoa: egoera;

begin
-- enviar:
tx_recive: kcuart_tx port map(data_in=>bidalibeharra,send_character=>bidali, en_16_x_baud=> en_16_x_baud,serial_out=>tx,Tx_complete=>finbidali,clk=>clk);


sek: process (clk,reset)
begin
if reset='1' then
bidalibeharra<="00000000";

elsif  clk'event and clk='1' then
    if(time1='0' and time2='0')and fin="00"  then 
           bidalibeharra<=conv_std_logic_vector(character'pos('a'),8);
    end if;
   
    if(time1='1' and time2='0')and fin="00"  then 
           bidalibeharra<=conv_std_logic_vector(character'pos('b'),8);
         
    end if;
    
    if(time1='0' and time2='1')and fin="00"  then 
    bidalibeharra<=conv_std_logic_vector(character'pos('c'),8);
    end if;
    
    if(fin="10")  then 
    bidalibeharra<=conv_std_logic_vector(character'pos('d'),8);
    end if;
    
     if(fin="01")  then 
     bidalibeharra<=conv_std_logic_vector(character'pos('e'),8);
     end if;
    
end if;

end process;

----------------------------------------------------------------------------------------------------------
-- Informazioa zein abiaduratan bidali/jasotzen den kontrolatzeko erabilzen da,
-- komunikazioa Bluetooth bidez eginda baud_count 54-ra iritsi behar da (baud ratioa 115200 izateko)
-- eta komunikazioa Bluetooth gabe egiteko baud_count 651 arte iritsi behar da (baud ratioa 9600 izateko)
baud_timer: process(clk)
    begin
        if clk'event and clk='1' then
            --if baud_count=54 then--115200    
            if baud_count=651 then--9200
                baud_count<=0;
                en_16_x_baud<='1';
            else
                baud_count <= baud_count +1;
                en_16_x_baud <= '0';
            end if;
         end if;
     end process baud_timer;



konb: process (oraingoa,hurrengoa)
begin

case oraingoa is 

    when init=>
        bidali<='0';
       
        if(en_16_x_baud='1')then
            hurrengoa<=send;
        else
            hurrengoa<=oraingoa;
        end if;
    
    when send => -- 'reset' botoia zapaltzerakoan 'r' bidaltzen dio ordenagailuari
        
        bidali<='1';
        if(finbidali='1')then
           hurrengoa<=init;
        else
         hurrengoa<=oraingoa;
        end if;

    
end case;


end process;

end Behavioral;