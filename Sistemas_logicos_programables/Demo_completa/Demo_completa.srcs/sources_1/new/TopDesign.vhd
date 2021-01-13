----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2020 17:50:37
-- Design Name: 
-- Module Name: nagusia - Behavioral
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

entity TopDesign is
    Port ( clk : in STD_LOGIC;
           reset , izq,der : in STD_LOGIC;
           sel: out std_logic_vector(1 downto 0);
           fin: out std_logic_vector(1 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           
           rx : in  std_logic;
           tx : out std_logic
           );
end TopDesign;

architecture Behavioral of TopDesign is

component fstm is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           w19 : in STD_LOGIC;
           t17 : in STD_LOGIC;
           time1 :out STD_LOGIC;
           time2 : out STD_LOGIC);
end component;



component f_zat 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component temp is
    Port ( rst : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component adder_resta is
  Port ( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          val1 : in STD_LOGIC;
          val2 : in STD_LOGIC;
          balioa:in STD_LOGIC_VECTOR (6 downto 0);
          izquierda : out STD_LOGIC_VECTOR (6 downto 0);
          derecha : out STD_LOGIC_VECTOR (6 downto 0);
          fin : out STD_LOGIC_vector(1 downto 0));
end component;


component blink is
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       sig: in std_logic;
       fin : in STD_LOGIC_VECTOR (1 downto 0);
       irt : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component deco_bin is
    Port ( va1 : in STD_LOGIC_VECTOR (6 downto 0);
           amartarra : out STD_LOGIC_VECTOR (6 downto 0);
           batekoa : out STD_LOGIC_VECTOR (6 downto 0));
end component;


component zazpi_seg4 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           bin_h_i,bin_b_i,bin_h_d,bin_b_d: in STD_LOGIC_VECTOR (6 downto 0);
           anodo : out STD_LOGIC_VECTOR (3 downto 0);
           katodo : out STD_LOGIC_VECTOR (6 downto 0));
end component;




 component button_debounce
        port(
            clk        : in  std_logic;
            reset      : in  std_logic;
            button_in  : in  std_logic;
            button_out : out std_logic
            );
end component;


component verificador is
    Port ( derecha : in STD_LOGIC;
           izquierda : in STD_LOGIC;
           enviar : in STD_LOGIC;
           irt : out STD_LOGIC);
end component;

    component UART
        port(
            clk            : in  std_logic;
            reset          : in  std_logic;
            tx_start       : in  std_logic;

            data_in        : in  std_logic_vector (7 downto 0);
            data_out       : out std_logic_vector (7 downto 0);

            rx             : in  std_logic;
            tx             : out std_logic
            );
    end component;

component deco_out is
      Port ( clk,reset: in std_logic;
        auk : in STD_LOGIC_VECTOR (1 downto 0);
        time1,time2: in std_logic;
       mandar : out STD_LOGIC_VECTOR (7 downto 0);
       enviar: out std_logic);
end component;

component selector is
    Port ( entrada : in STD_LOGIC_VECTOR (7 downto 0);
       valor : out STD_LOGIC_VECTOR (6 downto 0));
end component;


--erlojuaren kontroleko seinaleak
signal sizquierda,sderecha,samartar_i
,sbatekoa_i,samartar_d,sbatekoa_d : std_logic_vector(6 downto 0);

signal sfin,sirt :std_logic_vector(1 downto 0);

signal sig,segundu,stime1,stime2: std_logic;


--7segmentuaren seinaleak
signal san :std_logic_vector(3 downto 0);
signal sseg:std_logic_vector(6 downto 0);


-- linea seriarentzako seinaleak
signal smandar,sirakurritakoa: std_logic_vector(7 downto 0);
signal svalor: std_logic_vector(6 downto 0);

signal sder,sizq,senviar,smandado,spulsado: std_logic;

begin


component1: FSTM Port map ( clk => clk ,
           reset  =>reset  ,
           w19  => izq ,
           t17  => der ,
           time1  => stime1 ,
           time2  => stime2 );



component2: f_zat  Port map ( clk  => clk ,
           rst  => reset ,
           clk_out  => sig );

component3:temp  Port map ( rst =>reset   ,
           clk_in =>  clk ,
           clk_out =>  segundu );





component4: adder_resta Port map ( clk =>segundu  ,
           reset  => reset ,
           val1  => stime1 ,
           val2  => stime2 ,
           balioa=>svalor,
           izquierda=>sizquierda,
           derecha=>sderecha,
           fin  =>  sfin);

component5: blink Port map ( clk =>clk  ,
           reset  =>  reset ,
           sig=> segundu,
           fin  =>  sfin ,
           irt  =>  sirt );


component6: deco_bin Port map ( va1  =>sizquierda  ,
           amartarra  => samartar_i ,
           batekoa  => sbatekoa_i );

component7: deco_bin Port map ( va1  =>sderecha  ,
           amartarra  => samartar_d ,
           batekoa  => sbatekoa_d );


component8: zazpi_seg4  
Port map (
 rst => reset   ,
clk => sig  ,
bin_h_i=> samartar_i   ,
bin_b_i=>sbatekoa_i    ,
bin_h_d=> samartar_d   ,
bin_b_d=> sbatekoa_d   ,
anodo => san   ,
katodo => sseg );


sel(0)<=stime1;
sel(1)<=stime2;

fin<=sirt;

seg<=sseg;

an<=san;




component9:  deco_out  
Port map ( 
clk=>clk,
reset=>reset,
auk => sfin,
time1=>stime1,
time2=>stime2,
mandar =>smandar,
enviar=>senviar
);


 component10: button_debounce
       port map(
           clk  =>clk ,
           reset =>reset ,
           button_in  =>senviar ,
           button_out => smandado
           );


 component11: button_debounce
        port map(
            clk  =>clk ,
            reset =>reset ,
            button_in  =>izq ,
            button_out => sizq
            );
 component12: button_debounce
       port map(
           clk  =>clk ,
           reset =>reset ,
           button_in  =>der ,
           button_out => sder
           );
           


component13: verificador 
    Port map( derecha =>sder,
           izquierda =>sizq,
           enviar =>smandado,
           irt =>spulsado);


component14: UART
    port map(
            clk            => clk,
            reset          => reset,
            tx_start       => spulsado,
            data_in        => smandar,
            data_out       => sirakurritakoa,
            rx             => rx,
            tx             => tx
            );

component15: selector 
    Port map ( entrada =>sirakurritakoa,
           valor =>svalor );

end Behavioral;
