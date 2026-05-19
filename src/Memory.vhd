library ieee;
use ieee.std_logic_1164.all;

entity Memory is
	generic (n : integer := 8);
	port (
			position: in std_logic_vector(n-1 downto 0);
			
			instruction: out std_logic_vector (n-1 downto 0)
			);
	end entity Memory;
	
architecture bhv of Memory is
	begin
	end architecture bhv;