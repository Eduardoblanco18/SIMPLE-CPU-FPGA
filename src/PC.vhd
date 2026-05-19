library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PC is
	generic (n: integer := 8);
	port (
			clock_pc: in std_logic;
			load_pc, reset_pc: in std_logic;
			data_in_pc: in std_logic_vector (n-1 downto 0);
			
			pc_position: out std_logic_vector (n-1 downto 0)
			);
	end entity PC;
	
architecture bhv of PC is
	signal pc_temp: std_logic_vector (n-1 downto 0) := (others => '0');
	
	begin
		
		process (clock_pc)
			begin
				if rising_edge (clock_pc) then
					if reset_pc = '1' then
						pc_temp <= (others => '0');
					elsif load_pc = '1' then
						pc_temp <= data_in_pc;
					else 
						pc_temp <= pc_temp + 1;
					end if;
				end if;
			end process;
		
		pc_position <= pc_temp;
	end architecture bhv;