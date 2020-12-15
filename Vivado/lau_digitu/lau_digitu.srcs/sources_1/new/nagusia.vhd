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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nagusia is
    Port ( clk : in STD_LOGIC;
           reset , w19,t17 : in STD_LOGIC;
           fin: out std_logic_vector(1 downto 0);
           anodo : out STD_LOGIC_VECTOR (3 downto 0);
           katodo : out STD_LOGIC_VECTOR (6 downto 0));
end nagusia;

architecture Behavioral of nagusia is

component FSTM is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           w19 : in STD_LOGIC;
           t17 : in STD_LOGIC;
           t1 : in STD_LOGIC_vector (6 downto 0);
           t2 : in STD_LOGIC_vector (6 downto 0);
           time1 :out STD_LOGIC_vector (6 downto 0);
           time2 : out STD_LOGIC_vector (6 downto 0);
           resta : out STD_LOGIC_vector (1 downto 0));
end component;



component f_zat 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component Mux1 is
    Port ( t1 : in STD_LOGIC_VECTOR (6 downto 0);
           t2 : in STD_LOGIC_VECTOR (6 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           fijo : out STD_LOGIC_VECTOR (6 downto 0);
           quitar : out STD_LOGIC_VECTOR (6 downto 0));
end component;


component adder_resta is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sel : in std_logic_vector(1 downto 0);
           val : in STD_LOGIC_VECTOR (6 downto 0);
           irt : out STD_LOGIC_VECTOR (6 downto 0);
           fin : out STD_LOGIC_vector(1 downto 0));
end component;


component mux2 is
    Port ( v1 : in STD_LOGIC_VECTOR (6 downto 0);
           v2 : in STD_LOGIC_VECTOR (6 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           izquierda : out STD_LOGIC_VECTOR (6 downto 0);
           derecha : out STD_LOGIC_VECTOR (6 downto 0));
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


signal sizquierda,sderecha,sfijo,squitar,stime1,stime2,samartar_i
,sbatekoa_i,samartar_d,sbatekoa_d,snewvalue : std_logic_vector(6 downto 0);

signal sresta,sfin :std_logic_vector(1 downto 0);

signal san :std_logic_vector(3 downto 0);
signal sseg:std_logic_vector(6 downto 0);

signal sig: std_logic;

begin


component1: FSTM Port map ( clk => clk ,
           reset  =>reset  ,
           w19  => w19 ,
           t17  => t17 ,
           t1  => sizquierda ,
           t2 =>  sderecha,
           time1  => stime1 ,
           time2  => stime2 ,
           resta =>  sresta);

component2: f_zat  Port map ( clk  => clk ,
           rst  => reset ,
           clk_out  => sig );


component3: Mux1 Port map ( t1  => stime1 ,
           t2  =>  stime2,
           sel  =>  sresta,
           fijo  => sfijo ,
           quitar => squitar );



component4: adder_resta Port map ( clk =>sig  ,
           reset  => reset ,
           sel => sresta ,
           val  => squitar ,
           irt => snewvalue ,
           fin  =>  sfin);



component5: mux2 Port map ( v1  => sfijo  ,
           v2  =>  squitar,
           sel  =>  sresta,
           izquierda  => sizquierda ,
           derecha  => sderecha );


component6: deco_bin Port map ( va1  =>sizquierda  ,
           amartarra  => samartar_i ,
           batekoa  => sbatekoa_i );

component7: deco_bin Port map ( va1  =>sderecha  ,
           amartarra  => samartar_d ,
           batekoa  => sbatekoa_d );


component8: zazpi_seg4  Port map ( rst => reset   ,
           clk => clk   ,
           bin_h_i=> samartar_i   ,
           bin_b_i=>sbatekoa_i    ,
           bin_h_d=> samartar_d   ,
           bin_b_d=> sbatekoa_d   ,
           anodo => san   ,
           katodo => sseg );

fin<=sfin;

katodo<=sseg;

anodo<=san;


end Behavioral;
