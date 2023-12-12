 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity Forca is
Port (
		tentativa: in std_logic_vector (2 downto 0); -- VETOR QUE SIMBOLIZA O CHUTE, CADA SWITCH, PODENDO SER 0 OU 1, REPRESENTA 1 BIT DO CHUTE
		reset : in std_logic := '0';
		clk: in std_logic;
		estado_out: out std_logic_vector (4 downto 0); -- VETOR QUE SIMBOLIZA CASO O PRIMEIRO(7), SEGUNDO(6), ATE O QUINTO DIGITOS JA FORAM ACERTADOS, DA ESQUERDA PARA A DIREITA
		botao: in std_logic := '0';   -- FUNCIONA COMO CLOCK, O CÓDIGO SÓ "FUNCIONA" COM O APERTAR DO BOTAO
		vida: out std_logic_vector (2 downto 0) := "111";
		ganha: out std_logic; -- VITORIA
		perde: out std_logic);  -- DERROTA
		
-- SENHA = 71650
		
		
end Forca;

architecture Behavioral of Forca is

signal estado_s : std_logic_vector (4 downto 0) := "00000"; -- COMEÇA SEM NENHUM ACERTO
signal vida_s : std_logic_vector (2 downto 0) := "111"; -- COMEÇA COM TODAS AS VIDAS
signal botao_s : std_logic;
signal tentativa_s : std_logic_vector (2 downto 0);
signal ganha_s : std_logic := '0';
signal perde_s : std_logic:= '0';
signal erros : std_logic_vector(2 downto 0) := "000"; -- O VETOR ERROS SURGIU PARA SOLUCIONAR UM ERRO ASSOCIADO AO BOTÃO, EM QUE A RESPOSTA ERA CONTABILIZADA
-- DIVERSAS VEZES, RESULTANDO EM UMA DERROTA INSTANTÂNEA, DEVIDO À VELOCIDADE DO CLOCK (DIVERSAS SUBIDAS DE CLOCK ACONTECIAM NO APERTAR DO BOTÃO)
-- OBJETIVAMENTE COM O O VETOR ERROS, PORTANTO, ESSE ERRO FOI SOLUCIONADO, ALÉM DE CHUTES REPETIDOS SEREM DESCONSIDERADOS, POIS ELE IMPEDE QUE CHUTES
-- ERRADOS SEJAM FEITOS MAIS DE UMA VEZ.

begin

process (clk,reset) begin

if(clk' event and clk = '1') then
-- NESSE TRECHO, SERÃO COMPARADOS OS CHUTES E OS DÍGITOS DA SENHA, RESULTANDO EM UM ACERTO, COM O BIT CORRESPONDENTE AO DÍGITO NO VETOR ESTADO-S INDO DE O PARA 1,
-- EM CASO DE ACERTO, E A VIDA INDO DE 1 PARA 0, EM CASO DE ERRO
-- NOSSO CÓDIGO FUNCIONOU SEM CONTABILIZAR CHUTES REPETIDOS

	case tentativa is

	when "111" => -- 7, dígito 1 da esquerda pra direita
		if (reset = '1') then
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(4) <= '1';
			ganha_s <= '0';
			perde_s <= '0';
		end if; 
		
	when "001" => -- 1, dígito 2 da esquerda pra direita
		if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(3) <= '1';
		end if; 
		
		
	when "110" => -- 6, dígito 3 da esquerda pra direita
		if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(2) <= '1';
		end if; 
	
		
	when "101" => --5, dígito 4 da esquerda pra direita
		if (reset = '1') then
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(1) <= '1';
		end if; 
		
		
	when "000" => -- 0, dígito 5 da esquerda pra direita
		if (reset = '1') then
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(0) <= '1';
		end if; 
	-- DAQUI EM DIANTE, TODOS OS CHUTES ERRADOS SÃO VERIFICADOS
	when "010" =>
	if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(2) = '0') then
		-- A LÓGICA DE TIRAR VIDAS FOI FEITA DESSA FORMA PARA QUE SE TIRE AS VIDAS NA ORDEM, DA ESQUERDA PARA A DIREITA
		if vida_s(2) = '1' then
			vida_s(2) <= '0';
			erros(2) <= '1';
		
		elsif (vida_s(1) = '1' AND erros(2) = '0') then
			vida_s(1) <= '0';
			erros(2) <= '1';
			
		elsif (vida_s(0) = '1' AND erros(2) = '0') then
			vida_s(0) <= '0';
			erros(2) <= '1';
		end if;
		end if;
		
	when "011" =>
	if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(1) = '0') then
		if vida_s(2) = '1' then
			vida_s(2) <= '0';
			erros(1) <= '1';
		
		elsif (vida_s(1) = '1' AND erros(1) = '0') then
			vida_s(1) <= '0';
			erros(1) <= '1';
			
		elsif (vida_s(0) = '1' AND erros(1) = '0') then
			vida_s(0) <= '0';
			erros(1) <= '1';
		end if;
		end if;
		
	when "100" =>
	if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(0) = '0') then
		if vida_s(2) = '1' then
			vida_s(2) <= '0';
			erros(0) <= '1';
		
		elsif (vida_s(1) = '1' AND erros(0) = '0') then
			vida_s(1) <= '0';
			erros(0) <= '1';
			
		elsif (vida_s(0) = '1' AND erros(0) = '0') then
			vida_s(0) <= '0';
			erros(0) <= '1';
		end if;		
		end if;
		
	when others =>
	if (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1') then
		if vida_s(2) = '1' then
			vida_s(2) <= '0';
		
		elsif vida_s(1) = '1' then
			vida_s(1) <= '0';
		
		elsif vida_s(0) = '1' then
			vida_s(0) <= '0';
		end if;
	end if; 
	end case;

end if;

ganha_s <= estado_s(4) and estado_s(3) and estado_s(2) and estado_s(1) and estado_s(0);

if (vida_s = "000") then
ganha_s <= '0';
perde_s <= '1';
end if;
end process;

estado_out <= estado_s;
vida <= vida_s;
perde <= perde_s;
ganha <= ganha_s;
end Behavioral;
