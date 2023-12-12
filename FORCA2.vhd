 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity FORCA2 is
Port (
		chute: in std_logic_vector (2 downto 0);
		reset : in std_logic := '0';
		clk: in std_logic;
		estado_out: out std_logic_vector (4 downto 0);
		botao: in std_logic := '0';   -- FUNCIONA COMO CLOCK
		vidas: out std_logic_vector (2 downto 0) := "111";
		vitoria: out std_logic; -- VITRIA
		derrota: out std_logic);  -- DERROTA
		
-- SENHA = 71650
		
		
end FORCA2;

architecture Behavioral of FORCA2 is

signal estado_s : std_logic_vector (4 downto 0) := "00000";
signal vidas_s : std_logic_vector (2 downto 0) := "111"; 
signal botao_s : std_logic;
signal chute_s : std_logic_vector (2 downto 0);
signal vitoria_s : std_logic := '0';
signal derrota_s : std_logic:= '0';
signal erros : std_logic_vector(2 downto 0) := "000";

begin

process (clk,reset) begin

if(clk' event and clk = '1') then


	case chute is

	when "111" =>
		if (reset = '1') then
			estado_s <= "00000"; 
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(4) <= '1';
			vitoria_s <= '0';
			derrota_s <= '0';
		end if; 
		
	when "001" =>
		if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(3) <= '1';
		end if; 
		
		
	when "110" =>
		if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(2) <= '1';
		end if; 
	
		
	when "101" =>
		if (reset = '1') then
			estado_s <= "00000"; 
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(1) <= '1';
		end if; 
		
		
	when "000" =>
		if (reset = '1') then
			estado_s <= "00000"; 
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
		if (botao = '1') then
			estado_s(0) <= '1';
		end if; 

	when "010" =>
	if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(2) = '0') then
		if vidas_s(2) = '1' then
			vidas_s(2) <= '0';
			erros(2) <= '1';
		
		elsif (vidas_s(1) = '1' AND erros(2) = '0') then
			vidas_s(1) <= '0';
			erros(2) <= '1';
			
		elsif (vidas_s(0) = '1' AND erros(2) = '0') then
			vidas_s(0) <= '0';
			erros(2) <= '1';
		end if;
		end if;
		
	when "011" =>
	if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(1) = '0') then
		if vidas_s(2) = '1' then
			vidas_s(2) <= '0';
			erros(1) <= '1';
		
		elsif (vidas_s(1) = '1' AND erros(1) = '0') then
			vidas_s(1) <= '0';
			erros(1) <= '1';
			
		elsif (vidas_s(0) = '1' AND erros(1) = '0') then
			vidas_s(0) <= '0';
			erros(1) <= '1';
		end if;
		end if;
		
	when "100" =>
	if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1' AND erros(0) = '0') then
		if vidas_s(2) = '1' then
			vidas_s(2) <= '0';
			erros(0) <= '1';
		
		elsif (vidas_s(1) = '1' AND erros(0) = '0') then
			vidas_s(1) <= '0';
			erros(0) <= '1';
			
		elsif (vidas_s(0) = '1' AND erros(0) = '0') then
			vidas_s(0) <= '0';
			erros(0) <= '1';
		end if;		
		end if;
		
	when others =>
	if (reset = '1') then
			estado_s <= "00000";
			vitoria_s <= '0';
			derrota_s <= '0';
			vidas_s <= "111";
			erros <= "000";
		end if;
	if (botao = '1') then
		if vidas_s(2) = '1' then
			vidas_s(2) <= '0';
		
		elsif vidas_s(1) = '1' then
			vidas_s(1) <= '0';
		
		elsif vidas_s(0) = '1' then
			vidas_s(0) <= '0';
		end if;
	end if; 
	end case;

end if;

vitoria_s <= estado_s(4) and estado_s(3) and estado_s(2) and estado_s(1) and estado_s(0);

if (vidas_s = "000") then
vitoria_s <= '0';
derrota_s <= '1';
end if;
end process;

estado_out <= estado_s;
vidas <= vidas_s;
derrota <= derrota_s;
vitoria <= vitoria_s;
end Behavioral;
