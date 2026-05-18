library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
port (
		a, b, cin: in std_logic;
		sum, cout: out std_logic
		);
	end entity full_adder;

architecture bhv_full_add of full_adder is
	begin 
	
		sum <= a XOR b XOR cin;
	
		cout <= (cin AND (a OR b)) OR (a AND b);

	end architecture bhv_full_add;