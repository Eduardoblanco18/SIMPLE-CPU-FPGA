library ieee;
use ieee.std_logic_1164.all;

package comparator is
			component comparator_4_bits is 
				port (
					   Comp: in std_logic_vector (3 downto 0);
						Overflow: in std_logic;
						EQU, GRT, LST: out std_logic
						);
			end component comparator_4_bits;
			
		end package comparator;