-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Biblioteca_de_Componentes
-- Author      : Wilson Ruggiero
-- Disciplina  : LARC-EPUSP
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\wilson\Documents\My_Designs\Biblioteca_de_Componentes\Biblioteca_de_Componentes\compile\ram.vhd
-- Generated   : Tue Sep 15 21:44:40 2009
-- From        : c:\Users\wilson\Documents\My_Designs\Biblioteca_de_Componentes\Biblioteca_de_Componentes\src\ram.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use std.textio.all;

entity Ram is
  generic(
       BE 		: integer 	:= 16; 
       BP 		: integer 	:= 32; 
       NA		: string 	:= "mram.txt";  -- Nome do arquivo a ser lido
       Tz 		: time 		:= 1.5 ns; 
       Twrite 	: time 		:= 100 ns; 
       Tsetup 	: time 		:= 1 ns; 
       Tread 	: time  	:= 100 ns 
  );
  port(
       enable 	: in 	std_logic;
       rw 		: in 	std_logic;
       ender 	: in 	std_logic_vector(BE - 1 downto 0);
       pronto 	: out 	std_logic;
       dado 	: inout std_logic_vector(BP - 1 downto 0)
  );
end Ram;

architecture Ram of Ram is

---- Architecture declarations -----
type 	tipo_memoria  is array (0 to 2**BE - 1) of std_logic_vector(BP/4 - 1 downto 0);
signal Mram: tipo_memoria := ( others  => (others => '0')) ;


begin

---- Processes ----

Carga_Inicial_e_Ram_Memoria :process (enable) 
variable endereco: integer range 0 to (2**BE - 1);
variable endereco1: integer range 0 to (2**BE - 1);
variable endereco2: integer range 0 to (2**BE - 1);
variable endereco3: integer range 0 to (2**BE - 1);
variable inicio: std_logic := '1';
procedure fill_memory (signal Mem: inout tipo_memoria) is
	type HexTable is array (character range <>) of integer;
	-- Caracteres HEX válidos: o, 1, 2 , 3, 4, 5, 6, 6, 7, 8, 9, A, B, C, D, E, F  (somente caracteres maiúsculos)
	constant lookup: HexTable ('0' to 'F') :=
		(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, 10, 11, 12, 13, 14, 15);
	file infile: text open read_mode is NA; -- Abre o arquivo para leitura
	variable buff: line; 
	variable addr_s: string ((BE/4 + 1) downto 1); -- Digitos de endereço mais um espaço
	variable data_s: string ((BP/4 + 1) downto 1); -- ùltimo byte sempre tem um espaço separador
	variable addr_1, pal_cnt: integer;
	variable data: integer range (2**BP -1) downto 0;
	begin
		while (not endfile(infile)) loop
			readline(infile,buff); -- Lê um linha do infile e coloca no buff
			read(buff, addr_s); -- Leia o conteudo de buff até encontrar um espaço e atribui à addr_s, ou seja, leio o endereço
			read(buff, pal_cnT); -- Leia o número de bytes da próxima linha
			-- addr_1 := lookup(addr_s(4)) * 4096 + lookup(addr_s(3)) * 256 + lookup(addr_s(2)) * 16 + lookup(addr_s(1));
			addr_1 := 0;
			for i in (BE/4 + 1) downto 2 loop
				addr_1 := addr_1 + lookup(addr_s(i))*16**(i - 2);
			end loop;
			readline(infile, buff);
			for i in 1 to pal_cnt loop
				read(buff, data_s); -- Leia dois dígitos Hex e o espaço separador
				-- data := lookup(data_s(3)) * 16 + lookup(data_s(2)); -- Converte o valor lido em Hex para inteiro
				data := 0;
				data := data + lookup(data_s(i))*16**(i-2);
				--for i in (BP/4 + 1) downto 2 loop
				--	data := data + lookup(data_s(i))*16**(i-2);
				--end loop;
				Mem(addr_1) <= CONV_STD_LOGIC_VECTOR(data, BP); -- Converte o conteúdo da palavra para std_logic_vector
				addr_1 := addr_1 + 1;	-- Endereça a próxima palavra a ser carregada
			end loop;
		end loop;
end fill_memory;
 
begin
if inicio = '1' then
	-- Roda somente uma vez na inicialização
	fill_memory(Mram);
	-- Insere o conteúdo na memória
	inicio := '0';
end if;
if enable'event and enable = '1' then
	if (ender'last_event < Tsetup) or (dado'last_event < Tsetup) then
			dado <= (others => 'X');
	else
		endereco := CONV_INTEGER(ender);
		endereco1 := endereco + 1;
		endereco2 := endereco + 2;
		endereco3 := endereco + 3;
		case rw is
			when '0' => -- Ciclo de Leitura
				dado <= Mram(endereco) & Mram(endereco1) & Mram(endereco2) & Mram(endereco3) after Tread; 
				pronto <= '1' after Tread;
			when '1' => --Ciclo de Escrita
				Mram(endereco) <= dado(31 downto 24); 
				Mram(endereco1) <= dado(23 downto 16);
				Mram(endereco2) <= dado(15 downto 8);
				Mram(endereco3) <= dado(7 downto 0);
				pronto <= '1' after 4*Twrite;
			when others => -- Ciclo inválido
				Null;
		end case;
	end if;
end if;	
if enable'event and enable = '0' then
	pronto <= '0';
	dado <= (others => 'Z') after Tz;
end if;
end process;

end Ram;
