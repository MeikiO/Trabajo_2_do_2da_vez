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
        LED: out STD_LOGIC_VECTOR (15 downto 0);
       seg : out STD_LOGIC_VECTOR (6 downto 0); 
       an : out STD_LOGIC_VECTOR (3 downto 0); 
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

component kcuart_rx is
    Port (            serial_in : in std_logic;  
                 data_out : out std_logic_vector(7 downto 0);
              data_strobe : out std_logic;
             en_16_x_baud : in std_logic;
                      clk : in std_logic);
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
type egoera is (init,sendReset);
signal oraingoa, hurrengoa: egoera;

-- Segmentuan letrak idazteko erabiltzen diren bariableak
signal binenviar,segmentua,contLet,contLetraSEG: Integer;

-- LED-ak parpadeatzeko erabiltzen den seinalea
signal BLINK: std_logic; 

-- Denboraren menpe dauden kontagailu guztiak
signal contblink,contseg,denboraseg1,denboraR: integer;

-- Segmentu bakoitzean zenbaki desberdin bat erakusteko erabiltzen diren bariableak
signal seg1,seg2,seg3,seg4,contseg1,contsegR: integer;

-- Erabiltzaileak aukeratzen duen moduaren arabera ezartzen den denbora
signal denborain: integer;

-- UART komunikaziorako erabiltzen diren seinaleak
signal etorritakoa,bidalibeharra,memoetorri,memoetorritemp: std_logic_vector(7 downto 0);
signal finllegada,en_16_x_baud,bidali,finbidali: std_logic;
signal baud_count : integer range 0 to 54:=0; --651

begin



-- enviar:
tx_recive: kcuart_tx port map(data_in=>bidalibeharra,send_character=>bidali, en_16_x_baud=> en_16_x_baud,serial_out=>tx,Tx_complete=>finbidali,clk=>clk);


sek: process (clk,reset)
begin
if reset='1' then
zero<="ZZZZZZ"; -- Erabiltzen ez diren pin-ak inpedantzia altuan jarri
oraingoa<=init;
elsif clk'event and clk ='1' then
    oraingoa<=hurrengoa;
end if;

end process;

----------------------------------------------------------------------------------------------------------
-- Informazioa zein abiaduratan bidali/jasotzen den kontrolatzeko erabilzen da,
-- komunikazioa Bluetooth bidez eginda baud_count 54-ra iritsi behar da (baud ratioa 115200 izateko)
-- eta komunikazioa Bluetooth gabe egiteko baud_count 651 arte iritsi behar da (baud ratioa 9200 izateko)
baud_timer: process(clk)
    begin
        if clk'event and clk='1' then
           -- if baud_count=54 then--115200
            if baud_count=651 then--9200 bluetooth gabe konektatzeko
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
konb: process (oraingoa)
begin

case oraingoa is 

    when init=>
        bidalibeharra<="00000000";
        bidali<='0';
       
        if(reset<='0' and denboraR>=2)then
            hurrengoa<=sendReset;
        else
            hurrengoa<=oraingoa;
        end if;
    
    when sendReset => -- 'reset' botoia zapaltzerakoan 'r' bidaltzen dio ordenagailuari
        bidalibeharra<="01110010";
        bidali<='1';
        if(finbidali='1')then
           hurrengoa<=init;
        else
         hurrengoa<=oraingoa;
        end if;

    
end case;

end process;

------------------------------------------------------------------------------------------
-- Segundu kontadore bat, 'reset' zapaltzerakoan 2 segundu ondoren seinale bat bidaltzeko ordenagailuari

segunduR: process (clk,reset,oraingoa)
begin

    if reset ='1' then 
       contsegR<=0;
       denboraR<=0;
    elsif clk'event and clk='1' then
        if (oraingoa=init or oraingoa= sendReset)  then
            if contsegR >=100000000 then
                contsegR<=0;
                denboraR<=denboraR+1;
            else
                contsegR<=contsegR+1;
            end if;
        
        else 
            denboraR<=0;
            contsegR<=0;
        end if;
     end if;
end process;


end Behavioral;
