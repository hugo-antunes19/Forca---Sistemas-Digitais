
Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;		
		
		ENTITY LCD IS
		GENERIC (fclk: natural := 110_000_000); -- 110MHz , crIStal do kit EE03
		PORT (
				 botao       : IN std_logic := '0';
				 reset       : IN std_logic := '0';
				 chute       : IN std_logic_vector (2 DOWNTO 0);
		       clk         : IN std_logic; 
			RS, RW      : OUT bit;
			vidas 		 : OUT std_logic_vector (2 DOWNTO 0);
		       E           : BUFFER bit;  
		       DB          : OUT bit_vector(7 DOWNTO 0)); 
		END LCD;



		architecture hardware of LCD IS
		
		TYPE state IS (FunctionSetl, FunctionSet2, FunctionSet3,
		 FunctionSet4,FunctionSet5,FunctionSet6,FunctionSet7,FunctionSet8,FunctionSet9,FunctionSet10,FunctionSet11,FunctionSet12,
		 FunctionSet13,FunctionSet14,FunctionSet15,FunctionSet16,FunctionSet17,FunctionSet18,FunctionSet19,ClearDISplay, DISplayControl, EntryMode, 
		 WriteData1, WriteData2, WriteData3, WriteData4, WriteData5,WriteData6,WriteData7,WriteData8,WriteData9,WriteData10,WriteData11,
		 WriteData12,SetAddress1,SetAddress2, ReturnHome);
		 
		SIGNAL ee : std_logic := '0';
		SIGNAL pr_state, nx_state: state;
		SIGNAL estado_out: std_logic_vector (4 DOWNTO 0);
		SIGNAL vitoria : std_logic:= '0';
		SIGNAL derrota : std_logic:= '0';
		SIGNAL vidas_f : std_logic_vector (2 DOWNTO 0);
		
----Componentes :---------
	COMPONENT Forca IS
		PORT (
			tentativa: IN std_logic_vector (2 DOWNTO 0); -- VETOR QUE SIMBOLIZA O CHUTE, CADA SWITCH, PODENDO SER 0 OU 1, REPRESENTA 1 BIT DO CHUTE
			reset : IN std_logic := '0';
			clk: IN std_logic;
			estado_out: OUT std_logic_vector (4 DOWNTO 0); -- VETOR QUE SIMBOLIZA CASO O PRIMEIRO(7), SEGUNDO(6), ATE O QUINTO DIGITOS JA FORAM ACERTADOS, DA ESQUERDA PARA A DIREITA
			botao: IN std_logic := '0';   -- FUNCIONA COMO CLOCK, O CÓDIGO SÓ "FUNCIONA" COM O APERTAR DO BOTAO
			vida: OUT std_logic_vector (2 DOWNTO 0) := "111";
			ganha: OUT std_logic; -- VITORIA
			perde: OUT std_logic);  -- DERROTA
	END COMPONENT;
	
BEGIN 	
							
----Modulo da Forca :---------
forca_f: Forca PORT MAP (chute, reset, ee, estado_out, botao, vidas_f, vitoria, derrota);	
vidas <= vidas_f;
----Clock generator (E->500Hz) :---------
		PROCESS (clk)
		VARIABLE count: natural range 0 to fclk/100; 
		BEGIN
			IF (clk' event AND clk = '1') THEN 
				count := count + 1;
				IF (count=fclk/100) THEN 
					ee <= not ee;
					E <= not E; 
					count := 0; 
				END IF; 
			END IF; 
	END PROCESS;
		
-----Lower section of FSM:---------------
		PROCESS (E) 
		BEGIN
			IF (E' event AND E = '1') THEN 
			--	IF (rst= '0') THEN
				pr_state <= FunctionSetl; 
		--ELSE
		pr_state <= nx_state; 
		--END IF; 
		END IF; 
		END PROCESS;
		
-----Upper section of FSX:---------------
		PROCESS (pr_state) 
		BEGIN
		CASE pr_state IS


		WHEN FunctionSetl => 
		RS<= '0'; RW<= '0'; 
		DB<= "00111000"; 
		nx_state <= FunctionSet2;
		
		WHEN FunctionSet2 => 
		RS<= '0'; RW<= '0'; 
		DB <= "00111000";

		nx_state <= FunctionSet3; 
		WHEN FunctionSet3 => 
		RS <= '0'; RW<='0'; 
		DB <= "00111000"; 
		nx_state <= FunctionSet4;

		WHEN   FunctionSet4   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet5;

		WHEN   FunctionSet5   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet6;

		WHEN   FunctionSet6   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet7;

		WHEN   FunctionSet7   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet8;

		WHEN   FunctionSet8   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet9;

		WHEN   FunctionSet9   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet10;

		WHEN   FunctionSet10   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet11;

		WHEN   FunctionSet11   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet12;

		WHEN   FunctionSet12   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet13;

		WHEN   FunctionSet13   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet14;

		WHEN   FunctionSet14   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet15;

		WHEN   FunctionSet15   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet16;

		WHEN   FunctionSet16   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet17;

		WHEN   FunctionSet17   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet18;

		WHEN   FunctionSet18   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= FunctionSet19;

		WHEN   FunctionSet19   =>
		RS<=  '0'; RW<=  '0';
		DB   <=   "00111000";
		nx_state <= ClearDISplay ;

		WHEN ClearDISplay =>
		RS<= '0'; RW<= '0';
		DB <= "00000001";
		nx_state   <=   DISplayControl; 

		WHEN   DISplayControl   =>
		RS<= '0';   RW<=  '0';
		DB   <=  "00001100";
		nx_state <= EntryMode; 

		WHEN EntryMode =>
		RS<= '0'; RW<= '0';
		DB <= "00000110";
		nx_state   <=  WriteData1; 

		WHEN WriteData1 =>
		RS<=   '1';   RW <='0';
		DB   <=   "00100000";   --'ESCREVE UM ESPAO EM BRANCO
		nx_state <= SetAddress1; 

		WHEN SetAddress1 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "10000100";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 0 COLUNA 5
		nx_state  <= WriteData2; 
		
		WHEN WriteData2 =>
		RS<=   '1';   RW <='0';
		IF (estado_out(4) = '1') THEN
			DB <= X"37"; -- 7
		ELSE
			DB <= X"5F"; -- "-"
		END IF;
		nx_state <= WriteData3; 
		
		WHEN WriteData3 =>
		RS<=   '1';   RW <='0';
		IF (estado_out(3) = '1') THEN
			DB <= X"31"; -- 1
		ELSE
			DB <= X"5F"; -- "-"
		END IF;
		nx_state <= WriteData4; 
		
		WHEN WriteData4 =>
		RS<=   '1';   RW <='0';
		IF (estado_out(2) = '1') THEN
			DB <= X"36"; -- 6
		ELSE
			DB <= X"5F"; -- "-"
		END IF;
		nx_state <= WriteData5; 
		
		WHEN WriteData5 =>
		RS<=   '1';   RW <='0';
		IF (estado_out(1) = '1') THEN
			DB <= X"35"; -- 5
		ELSE
			DB <= X"5F"; -- "-"
		END IF;
		nx_state <= WriteData6; 
		
		WHEN WriteData6 =>
		RS<=   '1';   RW <='0';
		IF (estado_out(0) = '1') THEN
			DB <= X"30"; -- 7
		ELSE
			DB <= X"5F"; -- "-"
		END IF;
		nx_state <= SetAddress2; 
		
		WHEN SetAddress2 =>
		RS<=   '0';   RW<=   '0';
		DB   <=  "11000101";   --COMANDO PARA POSICIONAR O CURSOR NA LINHA 2 COLUNA 6
		nx_state  <= WriteData7; 
		
		WHEN WriteData7 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"47"; -- G
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"50"; -- P
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= WriteData8; 
		
		WHEN WriteData8 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"61"; -- a
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"65"; -- e
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= WriteData9; 
		
		WHEN WriteData9 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"6e"; -- n
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"72"; -- r
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= WriteData10; 
		
		WHEN WriteData10 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"68"; -- h
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"64"; -- d
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= WriteData11; 
		
		WHEN WriteData11 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"6f"; -- o
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"65"; -- e
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= WriteData12; 
		
		WHEN WriteData12 =>
		RS<=   '1';   RW <='0';
		IF (vitoria = '1' AND derrota = '0') THEN
			DB <= X"75"; -- u
		ELSIF (vitoria = '0' AND derrota = '1') THEN
			DB <= X"75"; -- u
		ELSE
			DB <= X"20"; -- " "
		END IF;		
		nx_state <= ReturnHome;

		WHEN ReturnHome =>
		RS<=   '0';   RW <='0';
		DB <= "10000000";
		nx_state <= WriteData1;


	END CASE; 
	END PROCESS;

	END hardware; 
