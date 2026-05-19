Library ieee;
use ieee.std_logic_1164.all;
use work.four_adder.all;

entity comparator_4_bits is 
			port (
					Comp: in std_logic_vector (3 downto 0);
					Overflow: in std_logic;
					EQU, GRT, LST: out std_logic
					);
			end entity comparator_4_bits;
			
architecture bhv_comparator of comparator_4_bits is
	signal EQU_interno: std_logic;
	
		begin 
			
			EQU_interno <= NOT (Comp(0) OR Comp(1) OR Comp(2) OR Comp(3));
			
			GRT <= NOT EQU_interno AND (Overflow XNOR Comp(3));
			
			LST <= NOT EQU_interno AND (Overflow XOR Comp(3));
			
			EQU <= EQU_interno;
			
	end architecture bhv_comparator;