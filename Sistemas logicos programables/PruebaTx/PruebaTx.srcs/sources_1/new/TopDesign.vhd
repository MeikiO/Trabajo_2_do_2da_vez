library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--------------------------------------
--/*
--    Erabiltzaileak pultsatu dezakeen botoi bakarra 'reset' botoia da,
--    BTNC (U18) dena, honek edozein momentutan programa bukatzen du hasierara bueltatuz.
--    Beste edozein sarrerak ez du ezer egiten, sekuentzia hasteko eta modu horretan
--    LED-ak eta segmentuak pizteko linea-serie konektatuz eta Bluetooth bitartez
--    '1' , '2', '3', '4' edo '5' pasatu behar zaio zenbakiaren arabera intentsitate
--    batean hasteko. Bluetooth barik funtzionatzeko eta linea-serie bitartez
--    funtzionatzeko baud_timer prozesuan komentatuta dagoen lerroa aldatu behar da.
--*/
--------------------------------------

entity ProFit is
    Port ( clk : in STD_LOGIC; 
        reset: in STD_LOGIC; 
        time1,time2: in std_logic;
       rx: in std_logic; 
       tx: out std_logic; 
       zero: out std_logic_vector(5 downto 0)); 
end ProFit;

architecture Behavioral of ProFit is
component seg_decod is
    Port ( bin : integer;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           anodo : out STD_LOGIC_VECTOR (3 downto 0));
end component;

    
 component kcuart_tx is
        Port (        data_in : in std_logic_vector(7 downto 0);
               send_character : in std_logic;
                 en_16_x_baud : in std_logic;
                   serial_out : out std_logic;
                  Tx_complete : out std_logic;
                          clk : in std_logic);
        end component;

-- Sekuentzia egiteko erabiltzen diren egoerak


-- UART komunikaziorako erabiltzen diren seinaleak
signal etorritakoa,bidalibeharra,memoetorri,memoetorritemp: std_logic_vector(7 downto 0);
signal finllegada,en_16_x_baud,bidali,finbidali: std_logic;
signal baud_count : integer range 0 to 54:=0; --651

begin

-- enviar:
tx_recive: kcuart_tx port map(data_in=>bidalibeharra,
send_character=>bidali, 
en_16_x_baud=> en_16_x_baud,
serial_out=>tx,
Tx_complete=>finbidali,
clk=>clk);



----------------------------------------------------------------------------------------------------------
-- Informazioa zein abiaduratan bidali/jasotzen den kontrolatzeko erabilzen da,
-- komunikazioa Bluetooth bidez eginda baud_count 54-ra iritsi behar da (baud ratioa 115200 izateko)
-- eta komunikazioa Bluetooth gabe egiteko baud_count 651 arte iritsi behar da (baud ratioa 9600 izateko)

baud_timer: process(clk)
    begin
        if clk'event and clk='1' then
            if baud_count=651 then
                baud_count<=0;
                en_16_x_baud<='1';
            else
                baud_count <= baud_count +1;
                en_16_x_baud <= '0';
            end if;
         end if;
     end process baud_timer;
------------------------------------------------------------------------------------------------------
-- Egoera bakoitzean zer egiten den eta hurrengora pasatzeko zer egin behar den kontrolatzen du
konb: process (bidali,bidalibeharra,clk)
begin

if reset='1' then
bidalibeharra<="00000000";
bidali<='0';

elsif clk'event and clk='1' then
      bidalibeharra<="01110010";
      bidali<='1';
      if(finbidali='1')then
        
      end if;

end if;

end process;



end Behavioral;