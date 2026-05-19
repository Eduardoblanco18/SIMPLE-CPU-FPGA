library ieee;
use ieee.std_logic_1164.all;

package four_adder is
	component adder_4_bits is
		port (
				a, b: in std_logic_vector (3 downto 0);
				cin: in std_logic;
				soma: out std_logic_vector (3 downto 0);
				cout, overflow: out std_logic
				);
		end component adder_4_bits;
	end package four_adder;	