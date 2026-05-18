library ieee;
use ieee.std_logic_1164;

entity UC is
	port (
			CLOCK_50, reset : in  std_logic;
			
			OP_CODE: in std_logic_vector (
			
			bus_select: out std_logic_vector (2 downto 0);
			
			R0in, R1in, Ain : out std_logic;
			
			ALU_op_code: out std_logic_vector (2 downto 0)
			);
	end entity UC;
	
architecture bhv of UC is
	
	type t_State is (Fetch, Decode, Operend_fetch, Execution);
	
	signal current_state : t_State;
	
	begin
		
		process (CLOCK_50)
			begin
				if rising_edge(CLOCK_50) then
					if reset = '1' then
						
						current_state <= Fetch;
					
					else 
						
						case current_state is
							
							when Fetch => 
							
								current_state <= Decode;
							
							when Decode =>
							
								current_state <= Operend_fetch;		
							
							when Operend_fetch =>
							
								current_state <= Execution;
							
							when Execution =>
						
								current_state <= Fetch;
						
						end case;
					end if;
				end if;
			end process;
		end architecture bhv;
		