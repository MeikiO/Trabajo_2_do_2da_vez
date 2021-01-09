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
           rst : in STD_LOGIC;
           anodo : out STD_LOGIC_VECTOR (3 downto 0);
           katodo : out STD_LOGIC_VECTOR (7 downto 0));
end nagusia;

architecture Behavioral of nagusia is

component zazpi_seg4 
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           anodo : out STD_LOGIC_VECTOR (3 downto 0);
           katodo : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component f_zat 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

signal tart_clk: std_logic;

begin

U1:zazpi_seg4 port map
(rst=>rst,
clk=>tart_clk,
anodo=>anodo,
katodo=>katodo
);

U2:f_zat port map
(clk=>clk,
rst=>rst,
clk_out=>tart_clk);


end Behavioral;
