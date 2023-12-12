 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity Forca IS
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
		
		
END Forca;

architecture Behavioral of Forca IS

SIGNAL estado_s : std_logic_vector (4 DOWNTO 0) := "00000"; -- COMEÇA SEM NENHUM ACERTO
SIGNAL vida_s : std_logic_vector (2 DOWNTO 0) := "111"; -- COMEÇA COM TODAS AS VIDAS
SIGNAL botao_s : std_logic;
SIGNAL tentativa_s : std_logic_vector (2 DOWNTO 0);
SIGNAL ganha_s : std_logic := '0';
SIGNAL perde_s : std_logic:= '0';
SIGNAL erros : std_logic_vector(2 DOWNTO 0) := "000"; -- O VETOR ERROS SURGIU PARA SOLUCIONAR UM ERRO ASSOCIADO AO BOTÃO, EM QUE A RESPOSTA ERA CONTABILIZADA
-- DIVERSAS VEZES, RESULTANDO EM UMA DERROTA INSTANTÂNEA, DEVIDO À VELOCIDADE DO CLOCK (DIVERSAS SUBIDAS DE CLOCK ACONTECIAM NO APERTAR DO BOTÃO)
-- OBJETIVAMENTE COM O O VETOR ERROS, PORTANTO, ESSE ERRO FOI SOLUCIONADO, ALÉM DE CHUTES REPETIDOS SEREM DESCONSIDERADOS, POIS ELE IMPEDE QUE CHUTES
-- ERRADOS SEJAM FEITOS MAIS DE UMA VEZ.

BEGIN

PROCESS (clk,reset) BEGIN

IF(clk' event and clk = '1') THEN
-- NESSE TRECHO, SERÃO COMPARADOS OS CHUTES E OS DÍGITOS DA SENHA, RESULTANDO EM UM ACERTO, COM O BIT CORRESPONDENTE AO DÍGITO NO VETOR ESTADO-S INDO DE O PARA 1,
-- EM CASO DE ACERTO, E A VIDA INDO DE 1 PARA 0, EM CASO DE ERRO
-- NOSSO CÓDIGO FUNCIONOU SEM CONTABILIZAR CHUTES REPETIDOS

	CASE tentativa IS

	WHEN "111" => -- 7, dígito 1 da esquerda pra direita
		IF (reset = '1') THEN
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
		IF (botao = '1') THEN
			estado_s(4) <= '1';
			ganha_s <= '0';
			perde_s <= '0';
		END IF; 
		
	WHEN "001" => -- 1, dígito 2 da esquerda pra direita
		IF (reset = '1') THEN
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
		IF (botao = '1') THEN
			estado_s(3) <= '1';
		END IF; 
		
		
	WHEN "110" => -- 6, dígito 3 da esquerda pra direita
		IF (reset = '1') then
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
		IF (botao = '1') THEN
			estado_s(2) <= '1';
		END IF; 
	
		
	WHEN "101" => --5, dígito 4 da esquerda pra direita
		IF (reset = '1') THEN
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
		IF (botao = '1') THEN
			estado_s(1) <= '1';
		END IF; 
		
		
	WHEN "000" => -- 0, dígito 5 da esquerda pra direita
		IF (reset = '1') THEN
			estado_s <= "00000"; 
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
		IF (botao = '1') THEN
			estado_s(0) <= '1';
		END IF; 
	-- DAQUI EM DIANTE, TODOS OS CHUTES ERRADOS SÃO VERIFICADOS
	WHEN "010" =>
	IF (reset = '1') THEN
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
	IF (botao = '1' AND erros(2) = '0') THEN
		-- A LÓGICA DE TIRAR VIDAS FOI FEITA DESSA FORMA PARA QUE SE TIRE AS VIDAS NA ORDEM, DA ESQUERDA PARA A DIREITA
		IF vida_s(2) = '1' THEN
			vida_s(2) <= '0';
			erros(2) <= '1';
		
		ELSIF (vida_s(1) = '1' AND erros(2) = '0') THEN
			vida_s(1) <= '0';
			erros(2) <= '1';
			
		ELSIF (vida_s(0) = '1' AND erros(2) = '0') THEN
			vida_s(0) <= '0';
			erros(2) <= '1';
		END IF;
		END IF;
		
	WHEN "011" =>
	IF (reset = '1') THEN
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
	IF (botao = '1' AND erros(1) = '0') THEN
		IF vida_s(2) = '1' THEN
			vida_s(2) <= '0';
			erros(1) <= '1';
		
		ELSIF (vida_s(1) = '1' AND erros(1) = '0') THEN
			vida_s(1) <= '0';
			erros(1) <= '1';
			
		ELSIF (vida_s(0) = '1' AND erros(1) = '0') THEN
			vida_s(0) <= '0';
			erros(1) <= '1';
		END IF;
		END IF;
		
	WHEN "100" =>
	IF (reset = '1') THEN
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
	IF (botao = '1' AND erros(0) = '0') THEN
		IF vida_s(2) = '1' THEN
			vida_s(2) <= '0';
			erros(0) <= '1';
		
		ELSIF (vida_s(1) = '1' AND erros(0) = '0') THEN
			vida_s(1) <= '0';
			erros(0) <= '1';
			
		ELSIF (vida_s(0) = '1' AND erros(0) = '0') THEN
			vida_s(0) <= '0';
			erros(0) <= '1';
		END IF;		
		END IF;
		
	WHEN OTHERS =>
	IF (reset = '1') THEN
			estado_s <= "00000";
			ganha_s <= '0';
			perde_s <= '0';
			vida_s <= "111";
			erros <= "000";
		END IF;
	IF (botao = '1') THEN
		IF vida_s(2) = '1' THEN
			vida_s(2) <= '0';
		
		ELSIF vida_s(1) = '1' THEN
			vida_s(1) <= '0';
		
		ELSIF vida_s(0) = '1' THEN
			vida_s(0) <= '0';
		END IF;
	END IF; 
	END CASE;

END IF;

-- A VARIÁVEL GANHA SÓ SERÁ 1 SE TODOS OS DIGÍTOS FOREM ACERTADOS
ganha_s <= estado_s(4) AND estado_s(3) AND estado_s(2) AND estado_s(1) AND estado_s(0);

IF (vida_s = "000") THEN
ganha_s <= '0';
perde_s <= '1';
END IF;
END PROCESS;

-- AQUI, CADA VARIÁVEL DE SAÍDA RECEBERÁ SEUS SIGNALS CORRESPONDENTES
	
estado_out <= estado_s;
vida <= vida_s;
perde <= perde_s;
ganha <= ganha_s;
END Behavioral;
