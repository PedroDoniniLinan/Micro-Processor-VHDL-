-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Mp is
  generic(
       BE 		: integer 	:= 16; 
       BP 		: integer 	:= 32; 
       Tz 		: time 		:= 1.5 ns; 
       Twrite 	: time 		:= 100 ns; 
       Tsetup 	: time 		:= 1 ns; 
       Tread 	: time  	:= 100 ns 
  );
  port(												  
       enable 	: in 	std_logic;
       rw 		: in 	std_logic;
       ender 	: in 	std_logic_vector(BE - 1 downto 0);
	   dado		: in	std_logic_vector(511 downto 0);
       pronto 	: out 	std_logic;
       dadoOut 	: out std_logic_vector(511 downto 0)
  );
end Mp;

architecture Mp of Mp is

---- Architecture declarations -----
type 	tipo_memoria  is array (0 to 2**BE - 1) of std_logic_vector(BP/4 - 1 downto 0);
signal MMp: tipo_memoria := ("00001000","00000000","00000000","00011000"
,"00000000","00000000","00000000","00000011"
,"00000000","00000000","00000000","00000101"
,"00000000","00000000","00000000","00000010"
,"00000000","00000000","00000000","00000001"
,"00000000","00000000","00000000","00000100"
,"00000000","00000000","00100000","00100000"
,"10001100","00000101","00000000","00010100"
,"00001100","00000000","00000000","00110000"
,"00001000","00000000","00000000","00100100"
,"00100011","10100011","11111111","11101100"
,"00000000","00000011","11101000","00100000"
,"10101111","10111111","00000000","00010000"
,"10101111","10110011","00000000","00001100"
,"10101111","10110010","00000000","00001000"
,"10101111","10110001","00000000","00000100"
,"10101111","10110000","00000000","00000000"
,"00000000","00000100","10010000","00100000"
,"00000000","00000101","10011000","00100000"
,"00000000","00000000","10000000","00100000"
,"00000010","00010011","01000000","00101010"
,"00010001","00000000","00000000","10101000"
,"00100010","00010001","11111111","11111111"
,"00101010","00101000","00000000","00000000"
,"00010101","00000000","00000000","10011100"
,"00000010","00100000","01001000","10000000"
,"00000010","01001001","01010000","00100000"
,"10001101","01001011","00000000","00000000"
,"10001101","01001100","00000000","00000100"
,"00000001","10001011","01000000","00101010"
,"00010001","00000000","00000000","10011100"
,"00000010","01000000","00100000","00100000"
,"00000010","00100000","00101000","00100000"
,"00001100","00000000","00000000","11010000"
,"00100010","00100011","11111111","11111111"
,"00000000","00000011","10001000","00100000"
,"00001000","00000000","00000000","01100100"
,"00100010","00000011","00000000","00000001"
,"00000000","01100000","10000000","00100000"
,"00001000","00000000","00000000","01011000"
,"10001111","10110000","00000000","00000000"
,"10001111","10110001","00000000","00000100"
,"10001111","10110010","00000000","00001000"
,"10001111","10110011","00000000","00001100"
,"10001111","10111111","00000000","00010000"
,"00100011","10100011","00000000","00010100"
,"00000000","01100000","11101000","00100000"
,"00000011","11100000","00000000","00001000"
,"00000000","10100000","01001000","10000000"
,"00000000","10001001","00011000","00100000"
,"00000000","01100000","01001000","00100000"
,"10001101","00101000","00000000","00000000"
,"10001101","00101010","00000000","00000100"
,"10101101","00101010","00000000","00000000"
,"10101101","00101000","00000000","00000100"
,"00000011","11100000","00000000","00001000", others  => (others => '0')) ;
begin
	process (enable)
	variable endereco: integer range 0 to (2**BE - 1);
	begin
		if enable'event and enable = '1' then
			--if (ender'last_event < Tsetup) or (dado'last_event < Tsetup) then
			--		dadoOut <= (others => 'X');
			--else
				endereco := CONV_INTEGER(ender);
				case rw is
					when '0' => -- Ciclo de Leitura
						dadoOut(511 downto 504) <= MMp(endereco)after Tread; 
						dadoOut(503 downto 496) <= MMp(endereco + 1)after Tread;
						dadoOut(495 downto 488) <= MMp(endereco + 2)after Tread;
						dadoOut(487 downto 480) <= MMp(endereco + 3)after Tread;
						dadoOut(479 downto 472) <= MMp(endereco + 4)after Tread;
						dadoOut(471 downto 464) <= MMp(endereco + 5)after Tread;
						dadoOut(463 downto 456) <= MMp(endereco + 6)after Tread;
						dadoOut(455 downto 448) <= MMp(endereco + 7)after Tread;
						dadoOut(447 downto 440) <= MMp(endereco + 8)after Tread;
						dadoOut(439 downto 432) <= MMp(endereco + 9)after Tread;
						dadoOut(431 downto 424) <= MMp(endereco + 10)after Tread;
						dadoOut(423 downto 416) <= MMp(endereco + 11)after Tread;
						dadoOut(415 downto 408) <= MMp(endereco + 12)after Tread;
						dadoOut(407 downto 400) <= MMp(endereco + 13)after Tread;
						dadoOut(399 downto 392) <= MMp(endereco + 14)after Tread;
						dadoOut(391 downto 384) <= MMp(endereco + 15)after Tread;
						dadoOut(383 downto 376) <= MMp(endereco + 16)after Tread;
						dadoOut(375 downto 368) <= MMp(endereco + 17)after Tread; 
						dadoOut(367 downto 360) <= MMp(endereco + 18)after Tread;
						dadoOut(359 downto 352) <= MMp(endereco + 19)after Tread;
						dadoOut(351 downto 344) <= MMp(endereco + 20)after Tread;
						dadoOut(343 downto 336) <= MMp(endereco + 21)after Tread;
						dadoOut(335 downto 328) <= MMp(endereco + 22)after Tread;
						dadoOut(327 downto 320) <= MMp(endereco + 23)after Tread;
						dadoOut(319 downto 312) <= MMp(endereco + 24)after Tread;
						dadoOut(311 downto 304) <= MMp(endereco + 25)after Tread;
						dadoOut(303 downto 296) <= MMp(endereco + 26)after Tread;
						dadoOut(295 downto 288) <= MMp(endereco + 27)after Tread;
						dadoOut(287 downto 280) <= MMp(endereco + 28)after Tread;
						dadoOut(279 downto 272) <= MMp(endereco + 29)after Tread;
						dadoOut(271 downto 264) <= MMp(endereco + 30)after Tread;
						dadoOut(263 downto 256) <= MMp(endereco + 31)after Tread;
						dadoOut(255 downto 248) <= MMp(endereco + 32)after Tread;
						dadoOut(247 downto 240) <= MMp(endereco + 33)after Tread;
						dadoOut(239 downto 232) <= MMp(endereco + 34)after Tread;
						dadoOut(231 downto 224) <= MMp(endereco + 35)after Tread;
						dadoOut(223 downto 216) <= MMp(endereco + 36)after Tread;
						dadoOut(215 downto 208) <= MMp(endereco + 37)after Tread;
						dadoOut(207 downto 200) <= MMp(endereco + 38)after Tread;
						dadoOut(199 downto 192) <= MMp(endereco + 39)after Tread;
						dadoOut(191 downto 184) <= MMp(endereco + 40)after Tread;
						dadoOut(183 downto 176) <= MMp(endereco + 41)after Tread;
						dadoOut(175 downto 168) <= MMp(endereco + 42)after Tread;
						dadoOut(167 downto 160) <= MMp(endereco + 43)after Tread;
						dadoOut(159 downto 152) <= MMp(endereco + 44)after Tread;
						dadoOut(151 downto 144) <= MMp(endereco + 45)after Tread;
						dadoOut(143 downto 136) <= MMp(endereco + 46)after Tread;
						dadoOut(135 downto 128) <= MMp(endereco + 47)after Tread;
						dadoOut(127 downto 120) <= MMp(endereco + 48)after Tread;
						dadoOut(119 downto 112) <= MMp(endereco + 49)after Tread;
						dadoOut(111 downto 104) <= MMp(endereco + 50)after Tread;
						dadoOut(103 downto 96) <= MMp(endereco + 51)after Tread;
						dadoOut(95 downto 88) <= MMp(endereco + 52)after Tread;
						dadoOut(87 downto 80) <= MMp(endereco + 53)after Tread;
						dadoOut(79 downto 72) <= MMp(endereco + 54)after Tread;
						dadoOut(71 downto 64) <= MMp(endereco + 55)after Tread;
						dadoOut(63 downto 56) <= MMp(endereco + 56)after Tread;
						dadoOut(55 downto 48) <= MMp(endereco + 57)after Tread;
						dadoOut(47 downto 40) <= MMp(endereco + 58)after Tread;
						dadoOut(39 downto 32) <= MMp(endereco + 59)after Tread;
						dadoOut(31 downto 24) <= MMp(endereco + 60)after Tread;
						dadoOut(23 downto 16) <= MMp(endereco + 61)after Tread;
						dadoOut(15 downto 8) <= MMp(endereco + 62)after Tread;
						dadoOut(7 downto 0) <= MMp(endereco + 63)after Tread; 
						pronto <= '1' after Tread;
					when '1' => --Ciclo de Escrita
						MMp(endereco) <= dado(511 downto 504); 
						MMp(endereco + 1) <= dado(503 downto 496);
						MMp(endereco + 2) <= dado(495 downto 488);
						MMp(endereco + 3) <= dado(487 downto 480);
						MMp(endereco + 4) <= dado(479 downto 472);
						MMp(endereco + 5) <= dado(471 downto 464);
						MMp(endereco + 6) <= dado(463 downto 456);
						MMp(endereco + 7) <= dado(455 downto 448);
						MMp(endereco + 8) <= dado(447 downto 440);
						MMp(endereco + 9) <= dado(439 downto 432);
						MMp(endereco + 10) <= dado(431 downto 424);
						MMp(endereco + 11) <= dado(423 downto 416);
						MMp(endereco + 12) <= dado(415 downto 408);
						MMp(endereco + 13) <= dado(407 downto 400);
						MMp(endereco + 14) <= dado(399 downto 392);
						MMp(endereco + 15) <= dado(391 downto 384);
						MMp(endereco + 16) <= dado(383 downto 376);
						MMp(endereco + 17) <= dado(375 downto 368); 
						MMp(endereco + 18) <= dado(367 downto 360);
						MMp(endereco + 19) <= dado(359 downto 352);
						MMp(endereco + 20) <= dado(351 downto 344);
						MMp(endereco + 21) <= dado(343 downto 336);
						MMp(endereco + 22) <= dado(335 downto 328);
						MMp(endereco + 23) <= dado(327 downto 320);
						MMp(endereco + 24) <= dado(319 downto 312);
						MMp(endereco + 25) <= dado(311 downto 304);
						MMp(endereco + 26) <= dado(303 downto 296);
						MMp(endereco + 27) <= dado(295 downto 288);
						MMp(endereco + 28) <= dado(287 downto 280);
						MMp(endereco + 29) <= dado(279 downto 272);
						MMp(endereco + 30) <= dado(271 downto 264);
						MMp(endereco + 31) <= dado(263 downto 256);
						MMp(endereco + 32) <= dado(255 downto 248);
						MMp(endereco + 33) <= dado(247 downto 240);
						MMp(endereco + 34) <= dado(239 downto 232);
						MMp(endereco + 35) <= dado(231 downto 224);
						MMp(endereco + 36) <= dado(223 downto 216);
						MMp(endereco + 37) <= dado(215 downto 208);
						MMp(endereco + 38) <= dado(207 downto 200);
						MMp(endereco + 39) <= dado(199 downto 192);
						MMp(endereco + 40) <= dado(191 downto 184);
						MMp(endereco + 41) <= dado(183 downto 176);
						MMp(endereco + 42) <= dado(175 downto 168);
						MMp(endereco + 43) <= dado(167 downto 160);
						MMp(endereco + 44) <= dado(159 downto 152);
						MMp(endereco + 45) <= dado(151 downto 144);
						MMp(endereco + 46) <= dado(143 downto 136);
						MMp(endereco + 47) <= dado(135 downto 128);
						MMp(endereco + 48) <= dado(127 downto 120);
						MMp(endereco + 49) <= dado(119 downto 112);
						MMp(endereco + 50) <= dado(111 downto 104);
						MMp(endereco + 51) <= dado(103 downto 96);
						MMp(endereco + 52) <= dado(95 downto 88);
						MMp(endereco + 53) <= dado(87 downto 80);
						MMp(endereco + 54) <= dado(79 downto 72);
						MMp(endereco + 55) <= dado(71 downto 64);
						MMp(endereco + 56) <= dado(63 downto 56);
						MMp(endereco + 57) <= dado(55 downto 48);
						MMp(endereco + 58) <= dado(47 downto 40);
						MMp(endereco + 59) <= dado(39 downto 32);
						MMp(endereco + 60) <= dado(31 downto 24);
						MMp(endereco + 61) <= dado(23 downto 16);
						MMp(endereco + 62) <= dado(15 downto 8);
						MMp(endereco + 63) <= dado(7 downto 0);
						pronto <= '1' after Twrite;
					when others => -- Ciclo inválido
						Null;
				end case;
			--end if;
		end if;	
		if enable'event and enable = '0' then
			pronto <= '0';
			dadoOut <= (others => 'Z') after Tz;
		end if;
	end process;
end Mp;
