library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.general_adder.all;

entity adder_4_bits is
		port (
				a, b: in std_logic_vector (3 downto 0);
				cin: in std_logic;
				soma: out std_logic_vector (3 downto 0);
				cout, overflow: out std_logic
				);
		end entity adder_4_bits;
		
architecture bhv_add_4_bits of adder_4_bits is
		signal CARRY_IN: std_logic;
		signal A_int, B_int, CARRY_OUT, SUM: std_logic_vector (3 downto 0);
		
		begin 
		A_int <= a;
		B_int <= b;
		CARRY_IN <= cin;
		
		FA0: full_adder port map (a => A_int(0), b => B_int(0), cin => CARRY_IN, sum => SUM(0), cout => CARRY_OUT(0));
		
		FA1: full_adder port map (a => A_int(1), b => B_int(1), cin => CARRY_OUT(0), sum => SUM(1), cout => CARRY_OUT(1));
		
		FA2: full_adder port map (a => A_int(2), b => B_int(2), cin => CARRY_OUT(1), sum => SUM(2), cout => CARRY_OUT(2));
		
		FA3: full_adder port map (a => A_int(3), b => B_int(3), cin => CARRY_OUT(2), sum => SUM(3), cout => CARRY_OUT(3));
		
		soma <= SUM;
		
		cout<=CARRY_OUT(3);
		
		overflow <= CARRY_OUT(2) XOR CARRY_OUT(3);
		
		end architecture bhv_add_4_bits;