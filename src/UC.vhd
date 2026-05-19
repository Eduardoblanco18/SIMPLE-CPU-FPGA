library ieee;
use ieee.std_logic_1164.all;

entity UC is
	generic (n: integer :=8);
	port (
			clock_UC, reset_UC : in  std_logic;

			SW: in std_logic_vector (15 downto 0);
			
			bus_select: out std_logic_vector (2 downto 0);
			
			R0in, R1in, Ain : out std_logic;
			
			ALU_op_code: out std_logic_vector (2 downto 0)
			);
	end entity UC;
	
architecture bhv of UC is
	
	type t_State is (Fetch, Decode, Operand_fetch, Execution);
	
	signal current_state : t_State;

	signal OP_CODE: std_logic_vector(3 downto 0);
	signal reg1, reg2: std_logic_vector (1 downto 0);
	signal Operand: std_logic_vector(n-1 downto 0);
	
	begin
		
		process (clock_UC)
			begin
				if rising_edge(clock_UC) then
					if reset_UC = '1' then
						
						current_state <= Fetch;
						
						bus_select <= (others => '0');
						R0in <= '0';
						R1in <= '0';
						Ain <= '0';
						ALU_op_code <= (others => '0');
						
						
					
					else 
						
						case current_state is
							
							when Fetch => 
								
								OP_CODE <= SW (15 downto 12);
								
								current_state <= Decode;
							
							when Decode =>

								case OP_CODE is
									when "0000" =>
								end case;
							
								current_state <= Operand_fetch;		
							
							when Operand_fetch =>
							
								current_state <= Execution;
							
							when Execution =>
						
								current_state <= Fetch;
						
						end case;
					end if;
				end if;
			end process;
		end architecture bhv;
		