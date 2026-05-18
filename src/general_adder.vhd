library ieee;
use ieee.std_logic_1164.all;

package general_adder is
		component full_adder is
			port (
					a, b, cin: in std_logic;
					sum, cout: out std_logic
					);
		end component full_adder;

	end package general_adder;
					