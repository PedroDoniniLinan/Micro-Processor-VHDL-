-------------------------------------------------------------------------------
--
-- Title       : Cache_dados
-- Design      : hierarq_mem
-- Author      : Dan
-- Company     : USP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\proj_hierarq_mem\hierarq_mem\src\Cache_dados.vhd
-- Generated   : Sun Jul  2 16:17:21 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Cache_dados} architecture {Cache_dados}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity Cache_dados is
	generic(
		Tacesso :time := 5 ns
	);
	 port(
	 	menable : in STD_LOGIC;
		OvfI : in STD_LOGIC;
	    RW : in std_logic; --do processador
		RW_mem : in std_logic; --da memoria
        Ender : in STD_LOGIC_VECTOR(15 downto 0);
        Dados_entrada : in STD_LOGIC_VECTOR(31 downto 0);
        Dados_mem : in STD_logic_vector(511 downto 0);
		Dados_buffer : out std_logic_vector(511 downto 0);
		Ender_buffer : out std_logic_vector(15 downto 0);
		Dados_saida : out std_logic_vector(31 downto 0);
        Hit : out std_logic;
		OvfO : out STD_LOGIC;
		ReadyMD : out STD_LOGIC;
		v1,v2,v3,v4,v5 : out std_logic_vector(31 downto 0)
	     );
end Cache_dados;


architecture Cache_dados of Cache_dados is	  
	type cache is array (0 to 2047) of  std_logic_vector(31 downto 0);
	type tabela_tag is array(0 to 127) of std_logic_vector(2 downto 0);
	signal CacheD1: cache := ( others  => (others =>  '0'));
	signal CacheD2: cache := ( others  => (others =>  '0'));
	signal Tag_tab1: tabela_tag := (others =>(others => '0'));
	signal Tag_tab2: tabela_tag := (others =>(others => '0'));
	signal Valid_tab1: std_logic_vector(127 downto 0):= (others => '0');
	signal Valid_tab2: std_logic_vector(127 downto 0):= (others => '0');
	signal LRU_tab1: std_logic_vector(127 downto 0):= (others => '1');
	signal LRU_tab2: std_logic_vector(127 downto 0):= (others => '0');
	signal Dirty1 : std_logic_vector(127 downto 0):= (others => '0');
	signal Dirty2 : std_logic_vector(127 downto 0):= (others => '0');
	signal Tag_eq1 : std_logic_vector (2 downto 0) := (others => '0');
	signal Tag_eq2 : std_logic_vector (2 downto 0) := (others => '0');
	signal Hit1 : std_logic := '0';
	signal Hit2 : std_logic := '0';
	-- Tag is Ender(15 downto 13);
	-- Index is Ender(12 downto 2);
	-- Index_bloco is Ender(12 downto 5);
begin
	Tag_eq1 <= Tag_tab1(CONV_INTEGER(Ender(12 downto 6)));
	Tag_eq2 <= Tag_tab2(CONV_INTEGER(Ender(12 downto 6)));
    Hit1 <= (Tag_eq1(0) xnor Ender(13)) and (Tag_eq1(1) xnor Ender(14)) and (Tag_eq1(2) xnor Ender(15)) and Valid_tab1(conv_integer(Ender(12 downto 6)));
	Hit2 <= (Tag_eq2(0) xnor Ender(13)) and (Tag_eq2(1) xnor Ender(14)) and (Tag_eq2(2) xnor Ender(15)) and Valid_tab2(conv_integer(Ender(12 downto 6)));
	Hit <= Hit1 or Hit2;
	process(RW, RW_mem, Menable, OvfI)
    begin 
		if (OvfI'event and OvfI = '0') then OvfO <= '0';
        elsif (RW_mem = '1' and menable'event and menable = '1') then
			if (LRU_tab1(conv_integer(Ender(12 downto 6))) = '0') then
				if (Dirty1(conv_integer(Ender(12 downto 6))) = '1' and OvfI = '0') then
					Dados_buffer(511 downto 480) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000"));
					Dados_buffer(479 downto 448) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000")+ 1);
					Dados_buffer(447 downto 416) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 2);
					Dados_buffer(415 downto 384) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 3);
					Dados_buffer(383 downto 352) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 4);
					Dados_buffer(351 downto 320) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 5);
					Dados_buffer(319 downto 288) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 6);
					Dados_buffer(287 downto 256) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 7);
					Dados_buffer(255 downto 224) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 8);
					Dados_buffer(223 downto 192) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 9);
					Dados_buffer(191 downto 160) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 10);
					Dados_buffer(159 downto 128) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 11);
					Dados_buffer(127 downto 96) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 12);
					Dados_buffer(95 downto 64) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 13);
					Dados_buffer(63 downto 32) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 14);
					Dados_buffer(31 downto 0) <= CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 15);
					Ender_buffer <=  Tag_tab1(CONV_INTEGER(Ender(12 downto 6))) & Ender(12 downto 6) & "000000";
					OvfO <= '1';
				end if;
            	CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000")) <= Dados_mem(511 downto 480);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 1) <= Dados_mem(479 downto 448);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 2) <= Dados_mem(447 downto 416);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 3) <= Dados_mem(415 downto 384);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 4) <= Dados_mem(383 downto 352);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 5) <= Dados_mem(351 downto 320);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 6) <= Dados_mem(319 downto 288);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 7) <= Dados_mem(287 downto 256);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 8) <= Dados_mem(255 downto 224);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 9) <= Dados_mem(223 downto 192);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 10) <= Dados_mem(191 downto 160);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 11) <= Dados_mem(159 downto 128);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 12) <= Dados_mem(127 downto 96);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 13) <= Dados_mem(95 downto 64);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 14) <= Dados_mem(63 downto 32);
				CacheD1(CONV_INTEGER(Ender(12 downto 6) & "0000") + 15) <= Dados_mem(31 downto 0);
            	Tag_tab1(CONV_INTEGER(Ender(12 downto 6))) <= Ender(15 downto 13);
            	Valid_tab1(CONV_INTEGER(Ender(12 downto 6))) <= '1';
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '1' ;
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '0' ;
				Dirty1(conv_integer(Ender(12 downto 6))) <= '0';
				ReadyMD <= '1' after Tacesso;
			else
				if (Dirty2(conv_integer(Ender(12 downto 6))) = '1' and OvfI = '0') then
					Dados_buffer(511 downto 480) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000"));
					Dados_buffer(479 downto 448) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000")+ 1);
					Dados_buffer(447 downto 416) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 2);
					Dados_buffer(415 downto 384) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 3);
					Dados_buffer(383 downto 352) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 4);
					Dados_buffer(351 downto 320) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 5);
					Dados_buffer(319 downto 288) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 6);
					Dados_buffer(287 downto 256) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 7);
					Dados_buffer(255 downto 224) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 8);
					Dados_buffer(223 downto 192) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 9);
					Dados_buffer(191 downto 160) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 10);
					Dados_buffer(159 downto 128) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 11);
					Dados_buffer(127 downto 96) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 12);
					Dados_buffer(95 downto 64) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 13);
					Dados_buffer(63 downto 32) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 14);
					Dados_buffer(31 downto 0) <= CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 15);
					Ender_buffer <=  Tag_tab2(CONV_INTEGER(Ender(12 downto 6))) & Ender(12 downto 6) & "000000";
					OvfO <= '1';
				end if;
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000")) <= Dados_mem(511 downto 480);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 1) <= Dados_mem(479 downto 448);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 2) <= Dados_mem(447 downto 416);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 3) <= Dados_mem(415 downto 384);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 4) <= Dados_mem(383 downto 352);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 5) <= Dados_mem(351 downto 320);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 6) <= Dados_mem(319 downto 288);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 7) <= Dados_mem(287 downto 256);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 8) <= Dados_mem(255 downto 224);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 9) <= Dados_mem(223 downto 192);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 10) <= Dados_mem(191 downto 160);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 11) <= Dados_mem(159 downto 128);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 12) <= Dados_mem(127 downto 96);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 13) <= Dados_mem(95 downto 64);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 14) <= Dados_mem(63 downto 32);
				CacheD2(CONV_INTEGER(Ender(12 downto 6) & "0000") + 15) <= Dados_mem(31 downto 0);
            	Tag_tab2(CONV_INTEGER(Ender(12 downto 6))) <= Ender(15 downto 13);
            	Valid_tab2(CONV_INTEGER(Ender(12 downto 6))) <= '1';
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '1';
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '0';
				Dirty2(conv_integer(Ender(12 downto 6))) <= '0';
				ReadyMD <= '1' after Tacesso;
			end if;
		elsif (RW = '1' and menable'event and menable = '1') then
			if(Hit1 = '1') then
				CacheD1(conv_integer(Ender(12 downto 2))) <= Dados_entrada;
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '1' ;
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '0' ;
				Dirty1(conv_integer(Ender(12 downto 6))) <= '1';
				ReadyMD <= '1' after Tacesso;
			elsif (Hit2 = '1') then
				CacheD2(conv_integer(Ender(12 downto 2))) <= Dados_entrada;
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '1' ;
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '0' ;
				Dirty2(conv_integer(Ender(12 downto 6))) <= '1';
				ReadyMD <= '1' after Tacesso;
			end if;	
		elsif (menable'event and menable = '1') then
			if(Hit1 = '1') then
				Dados_saida <= CacheD1(conv_integer(Ender(12 downto 2)));
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '1' ;
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '0' ;
				ReadyMD <= '1' after Tacesso;
			elsif (Hit2 = '1') then  
				Dados_saida <= CacheD2(conv_integer(Ender(12 downto 2)));
				LRU_tab2(conv_integer(Ender(12 downto 6))) <= '1' ;
				LRU_tab1(conv_integer(Ender(12 downto 6))) <= '0' ;
				ReadyMD <= '1' after Tacesso;
			end if;	
		elsif (menable'event and menable = '0') then
			Dados_saida <= (others => 'Z');
			ReadyMD <= '0';
		end if;
		v1 <= CacheD2(0);
		v2 <= CacheD2(1);
		v3 <= CacheD2(2);
		v4 <= CacheD2(3);
		v5 <= CacheD2(4);
    end process;

end Cache_dados;
