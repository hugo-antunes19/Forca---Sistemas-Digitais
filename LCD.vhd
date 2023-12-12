
Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;		
		
		entity LCD is
		generic (fclk: natural := 110_000_000); -- 110MHz , cristal do kit EE03
		port (
				 botao       : in std_logic := '0';
				 reset       : in std_logic := '0';
				 chute       : in std_logic_vector (2 downto 0);
		       clk         : in std_logic; 
			RS, RW      : out bit;
			vidas 		 : out std_logic_vector (2 downto 0);
		       E           : buffer bit;  
		       DB          : out bit_vector(7 downto 0)); 
		end LCD;



		architecture hardware of LCD is
		
		type state is (FunctionSetl, FunctionSet2, FunctionSet3,
		 FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,
		 FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDisplay, DisplayControl, EntryMode, 
		 WriteData1, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,WriteData11,
		 WriteData12,SetAddress1,SetAddress2, ReturnHome);
		 
		signal ee : std_logic := '0';
		signal pr_state, nx_state: state;
		signal estado_out: std_logic_vector (4 downto 0);
		signal vitoria : std_logic:= '0';
		signal derrota : std_logic:= '0';
		signal vidas_f : std_logic_vector (2 downto 0);
		
----Componentes :---------
	component Forca is
		Port (
			tentativa: in std_logic_vector (2 downto 0); -- VETOR QUE SIMBOLIZA O CHUTE, CADA SWITCH, PODENDO SER 0 OU 1, REPRESENTA 1 BIT DO CHUTE
			reset : in std_logic := '0';
			clk: in std_logic;
			estado_out: out std_logic_vector (4 downto 0); -- VETOR QUE SIMBOLIZA CASO O PRIMEIRO(7), SEGUNDO(6), ATE O QUINTO DIGITOS JA FORAM ACERTADOS, DA ESQUERDA PARA A DIREITA
			botao: in std_logic := '0';   -- FUNCIONA COMO CLOCK, O CÓDIGO SÓ "FUNCIONA" COM O APERTAR DO BOTAO
			vida: out std_logic_vector (2 downto 0) := "111";
			ganha: out std_logic; -- VITORIA
			perde: out std_logic);  -- DERROTA
	end component;
	
begin 	
							
----Modulo da Forca :---------
forca_f: Forca port map (chute, reset, ee, estado_out, botao, vidas_f, vitoria, derrota);	
vidas <= vidas_f;
----Clock generator (E->500Hz) :---------
		process (clk)
		variable count: natural range 0 to fclk/100; 
		begin
			if (clk' event and clk = '1') then 
				count := count + 1;
				if (count=fclk/100) then 
					ee <= not ee;
					E <= not E; 
					count := 0; 
				end if; 
			end if; 
	end process;
		
-----Lower section of FSM:---------------
		process (E) 
		begin
			if (E' event and E = '1') then 
			--	IF (rst= '0') THEN
				pr_state <= FunctionSetl; 
		--ELSE
		pr_state <= nx_state; 
		--END IF; 
		end if; 
		end process;
		
-----Upper section of FSX:---------------
		process (pr_state) 
		begin
		case pr_state is


		when FunctionSetl => 
		RS<= '0'; RW<= '0'; 
		DB<= "00111000"; 
		nx_state <= FunctionSet2;
		
		when FunctionSet2 => 
		RS<= '0'; RW<= '0'; 
		DB <= "00111000";

		nx_state <= FunctionSet3; 
		when FunctionSet3 => 
		RS <= '0'; RW<='0'; 
		DB <= "00111000"; 
		nx_state <= FunctionSet4;

		when   FunctionSet4   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet5;

		when   FunctionSet5   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet6;

		when   FunctionSet6   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet7;

		when   FunctionSet7   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet8;

		when   FunctionSet8   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet9;

		when   FunctionSet9   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet10;

		when   FunctionSet10   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet11;

		when   FunctionSet11   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet12;

		when   FunctionSet12   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet13;

		when   FunctionSet13   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet14;

		when   FunctionSet14   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet15;

		when   FunctionSet15   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet16;

		when   FunctionSet16   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet17;

		when   FunctionSet17   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet18;

		when   FunctionSet18   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet19;

		when   FunctionSet19   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= ClearDisplay ;

		when ClearDisplay =>
		RS<= '0'; RW<= '0';
		DB <= "00000001";
		nx_state   <=   DisplayControl; 

		when   DisplayControl   =>
		RS<= '0';   RW<=  '0';
		DB   <=  "00001100";
		nx_state <= EntryMode; 

		when EntryMode =>
		RS<= '0'; RW<= '0';
		DB <= "00000110";
		nx_state   <=  WriteData1; 

		when WriteData1 =>
		RS<=   '1';   RW <='0';
		DB   <=   "00100000";   --'ESCREVE UM ESPAO EM BRANCO
		nx_state <= SetAddress1; 

		when SetAddress1 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "10000100";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 5
		nx_state  <= WriteData2; 
		
		when WriteData2 =>
		RS<=   '1';   RW <='0';
		if (estado_out(4) = '1') then
			DB <= X"37"; -- 7
		else
			DB <= X"5F"; -- "-"
		end if;
		nx_state <= WriteData3; 
		
		when WriteData3 =>
		RS<=   '1';   RW <='0';
		if (estado_out(3) = '1') then
			DB <= X"31"; -- 1
		else
			DB <= X"5F"; -- "-"
		end if;
		nx_state <= WriteData4; 
		
		when WriteData4 =>
		RS<=   '1';   RW <='0';
		if (estado_out(2) = '1') then
			DB <= X"36"; -- 6
		else
			DB <= X"5F"; -- "-"
		end if;
		nx_state <= WriteData5; 
		
		when WriteData5 =>
		RS<=   '1';   RW <='0';
		if (estado_out(1) = '1') then
			DB <= X"35"; -- 5
		else
			DB <= X"5F"; -- "-"
		end if;
		nx_state <= WriteData6; 
		
		when WriteData6 =>
		RS<=   '1';   RW <='0';
		if (estado_out(0) = '1') then
			DB <= X"30"; -- 7
		else
			DB <= X"5F"; -- "-"
		end if;
		nx_state <= SetAddress2; 
		
		when SetAddress2 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "11000101";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 2 COLUNA 6
		nx_state  <= WriteData7; 
		
		when WriteData7 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"47"; -- G
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"50"; -- P
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= WriteData8; 
		
		when WriteData8 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"61"; -- a
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"65"; -- e
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= WriteData9; 
		
		when WriteData9 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"6e"; -- n
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"72"; -- r
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= WriteData10; 
		
		when WriteData10 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"68"; -- h
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"64"; -- d
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= WriteData11; 
		
		when WriteData11 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"6f"; -- o
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"65"; -- e
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= WriteData12; 
		
		when WriteData12 =>
		RS<=   '1';   RW <='0';
		if (vitoria = '1' and derrota = '0') then
			DB <= X"75"; -- u
		elsif (vitoria = '0' and derrota = '1') then
			DB <= X"75"; -- u
		else
			DB <= X"20"; -- " "
		end if;		
		nx_state <= ReturnHome;

		when ReturnHome =>
		RS<=   '0';   RW <='0';
		DB <= "10000000";
		nx_state <= WriteData1;


	end case; 
	end process;

	end hardware; 
