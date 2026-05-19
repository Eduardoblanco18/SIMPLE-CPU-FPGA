Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.comparator.all;
use work.multiplier.all;
use work.four_adder.all;
use work.general_adder.all;

entity ALU is
		port (
				SW: in std_logic_vector (10 downto 0);
				LEDR: out std_logic_vector (5 downto 0);
				
				HEX0: out std_logic_vector (6 downto 0); -- Display da ALU
				
				HEX2: out std_logic_vector (6 downto 0); -- Valor do número A
				HEX3: out std_logic_vector (6 downto 0);
				
				HEX4: out std_logic_vector (6 downto 0); -- Valor do número B
				HEX5: out std_logic_vector (6 downto 0);
				
				HEX6: out std_logic_vector (6 downto 0); -- Valor do resultado
				HEX7: out std_logic_vector (6 downto 0)
				);
		end entity ALU;
		
architecture BHV_ALU of ALU is
	
	signal Num_A, Num_B, Result: std_logic_vector (3 downto 0);
	signal OP_CODE: std_logic_vector (2 downto 0);
	signal Greater, Lesser, Equal, OFW, CF, ZF: std_logic;
	
	signal SOMA_RES, SUB_RES, MUL_RES, AND_RES, OR_RES, NOT_RES: std_logic_vector (3 downto 0);
	signal SOMA_OF, SUB_OF, SOMA_CF, SUB_CF: std_logic;
	
	signal SINAL_A, SINAL_B, SINAL_RESULT: std_logic;
	signal VALOR_ABS_A, VALOR_ABS_B, VALOR_ABS_RESULT: std_logic_vector (3 downto 0); 
	
		begin
			
			OP_CODE <= SW(2 downto 0);
			Num_A <= "0000" when OP_CODE = "000" else 
						"00" & SW(8 downto 7) when OP_CODE = "110" else 
						SW (10 downto 7);
			Num_B <= "0000" when OP_CODE = "000" else 
						"00" & SW(4 downto 3) when OP_CODE = "110" else
						SW (6 downto 3);
			
			SOMADOR: adder_4_bits port map (a => Num_A, b => Num_B, cin => '0', soma => SOMA_RES, cout => SOMA_CF, overflow => SOMA_OF);
			
			SUBTRATOR: adder_4_bits port map (a => Num_A, b => NOT Num_B, cin => '1', soma => SUB_RES, cout => SUB_CF, overflow => SUB_OF);
			
			MULTIPLICADOR: multiplier_2_bits port map (a => Num_A (1 downto 0), b => Num_B (1 downto 0), Res => MUL_RES);
		
			COMPARADOR: comparator_4_bits port map (Comp => SUB_RES, Overflow => SUB_OF, EQU => Equal, GRT => Greater, LST => Lesser);
			
			AND_RES <= Num_A AND Num_B;
			
			OR_RES <= Num_A OR Num_B;
			
			NOT_RES <= NOT Num_B;
			
			with OP_CODE select  --seleção do resultado de acordo com o códigos operacional da ULA
				Result <=
					"0000" when "000",
					AND_RES when "001",
					OR_RES when "010",
					NOT_RES when "011",
					SOMA_RES when "100",
					SUB_RES when "101",
					MUL_RES when "110",
					"0000" when others;
			
			with OP_CODE select	--seleção da utilização do carry flag de acordo com o códigos operacional da ULA
				CF <= 
					SOMA_CF when "100",
					SUB_CF when "101",
					'0' when others;
					
			with OP_CODE select 	--seleção da utilização do overflow de acordo com o códigos operacional da ULA
				OFW <= 
					SOMA_OF when "100",
					SUB_OF when "101",
					'0' when others;	
			
			with Result select	--seleção da utilização do zero flag de acordo com o códigos operacional da ULA
				ZF <= 
					'1' when "0000",
					'0' when others;
						
			with OP_CODE select	--seleção de qual led utilizar de acordo com o resultado vindo da função de comparar presente na ULA
				LEDR(5) <= 
						  Lesser when "111",
						  '0' when others;
							  
			with OP_CODE select
				LEDR(4) <= 
						  Greater when "111",
						  '0' when others;
			
			with OP_CODE select
				LEDR(3) <= 
						  Equal when "111",
						  '0' when others;
							  
			LEDR(2) <= OFW;	-- direcionamento do sinal da overflow flag para seu respectivo led
			LEDR(1) <= '0' when OP_CODE = "000" OR OP_CODE = "111" else ZF;  -- direcionamento do sinal da zero flag para seu respectivo led e seleção da representação do zaero flag no led de acordo com a escolha de código operacional
			LEDR(0) <= CF;		-- direcionamento do sinal da carry flag para seu respectivo led
			
			--Representação do OP_CODE
			
			with OP_CODE select
				HEX0 <= 
						  "1000000" when "000",
						  "1111001" when "001",
						  "0100100" when "010",
						  "0110000" when "011",
						  "0011001" when "100",
						  "0010010" when "101",
						  "0000010" when "110",
						  "1111000" when "111",
						  "1111111" when others;
			
			--Representação do Número A
			
			SINAL_A <= Num_A(3);
			
			with SINAL_A select
				HEX5 <= 
						  "0111111" when '1',
						  "1111111" when others;
			
			VALOR_ABS_A <= Num_A when SINAL_A = '0' else std_logic_vector(unsigned(NOT Num_A) + 1); --passa o valor para complemento de 2 quando o número for negativo
			
			with VALOR_ABS_A select
				HEX4 <=
						  "1000000" when "0000",
						  "1111001" when "0001",
						  "0100100" when "0010",
						  "0110000" when "0011",
						  "0011001" when "0100",
						  "0010010" when "0101",
						  "0000010" when "0110",
						  "1111000" when "0111",
						  "0000000" when "1000",
						  "1111111" when others;
			
			--Representação do Número B
			
			SINAL_B <= Num_B(3);
			
			with SINAL_B select
				HEX3 <= 
						  "0111111" when '1',
						  "1111111" when others;
						  
			VALOR_ABS_B <= Num_B when SINAL_B = '0' else std_logic_vector(unsigned(NOT Num_B) + 1); --passa o valor para complemento de 2 quando o número for negativo
			
			with VALOR_ABS_B select
				HEX2 <=
						  "1000000" when "0000",
						  "1111001" when "0001",
						  "0100100" when "0010",
						  "0110000" when "0011",
						  "0011001" when "0100",
						  "0010010" when "0101",
						  "0000010" when "0110",
						  "1111000" when "0111",
						  "0000000" when "1000",
						  "1111111" when others;
			
			
			--Representação do Resultado
			
			SINAL_RESULT <= '0' when OP_CODE = "110" else RESULT(3);	--desconsidera utilização do complemento de 2 exclusivamente na multiplicação
			
			with SINAL_RESULT select
				HEX7 <= 
						  "0111111" when '1',
						  "1111111" when others;
			
			VALOR_ABS_RESULT <= Result when SINAL_RESULT = '0' else std_logic_vector(unsigned(NOT Result) + 1); --passa o valor para complemento de 2 quando o número for negativo

			with VALOR_ABS_RESULT select
				HEX6 <=
						  "1000000" when "0000",
						  "1111001" when "0001",
						  "0100100" when "0010",
						  "0110000" when "0011",
						  "0011001" when "0100",
						  "0010010" when "0101",
						  "0000010" when "0110",
						  "1111000" when "0111",
						  "0000000" when "1000",
						  "0011000" when "1001",
						  "1111111" when others;			
			
		end architecture BHV_ALU;
							