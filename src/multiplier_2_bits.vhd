library ieee;
use ieee.std_logic_1164.all;

entity multiplier_2_bits is
				port (
						a, b: in std_logic_vector (1 downto 0);
						Res: out std_logic_vector (3 downto 0)
						);
			end entity multiplier_2_bits;
			
architecture bhv_multiply_2_bits of multiplier_2_bits is
	signal cin: std_logic_vector (1 downto 0);
	
	begin
		Res(0) <= a(0) AND b(0);
		
		Res(1) <= (a(0) AND b(1)) XOR (a(1) AND b(0));
		
		cin(0) <= (a(0) AND b(1)) AND (a(1) AND b(0));
		
		Res(2) <= (a(1) AND b(1)) XOR cin(0);
		
		cin(1) <= (a(1) AND b(1)) AND cin(0);
		
		Res(3) <= cin(1);
		
	end architecture bhv_multiply_2_bits;