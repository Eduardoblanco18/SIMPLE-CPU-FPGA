library ieee;
use ieee.std_logic_1164.all;

package multiplier is
			component multiplier_2_bits is
				port (
						a, b: in std_logic_vector (1 downto 0);
						Res: out std_logic_vector (3 downto 0)
						);
			end component multiplier_2_bits;
		
		end package multiplier;