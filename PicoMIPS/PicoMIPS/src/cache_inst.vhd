-------------------------------------------------------------------------------
--
-- Title       : Cache_Inst
-- Design      : hierarq_mem
-- Author      : Dan
-- Company     : USP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\proj_hierarq_mem\hierarq_mem\src\Cache_Inst.vhd
-- Generated   : Sun Jul  2 16:08:02 2017
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
--{entity {Cache_Inst} architecture {Cache_Inst}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity Cache_Inst is
    generic(
        Tacesso :time := 5 ns
    );
    port(
         menable : in STD_LOGIC;
         Ender : in STD_LOGIC_VECTOR(15 downto 0);
		 Dados_from_mem : in STD_logic_vector(511 downto 0);
         W : in std_logic; --da memoria	
		 Dados_cache : out STD_LOGIC_VECTOR(31 downto 0);
         Hit : out std_logic;
		 ReadyMI : out std_logic
         );
end Cache_Inst;


architecture Cache_Inst of Cache_Inst is
    type cache is array (0 to 4095) of  std_logic_vector(31 downto 0);
    type tabela_tag is array(0 to 255) of std_logic_vector(1 downto 0);

    signal CacheI: cache := ( others  => (others =>  '0'));
    signal Tag_tab: tabela_tag := (others =>(others => '0'));
    signal Valid_tab: std_logic_vector(255 downto 0):= (others => '0');
    signal Tag_eq : std_logic_vector (1 downto 0) := (others => '0');

begin
    process(W,menable)
    begin
		Tag_eq <= Tag_tab(CONV_INTEGER(Ender(13 downto 6)));
    	Hit <= (Tag_eq(0) xnor Ender(14)) and (Tag_eq(1) xnor Ender(15)) and Valid_tab(conv_integer(Ender(13 downto 6)));
        if (W = '1' and menable'event and menable = '1') then
            CacheI(CONV_INTEGER(Ender(13 downto 2))) <= Dados_from_mem(511 downto 480) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 1) <= Dados_from_mem(479 downto 448) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 2) <= Dados_from_mem(447 downto 416) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 3) <= Dados_from_mem(415 downto 384) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 4) <= Dados_from_mem(383 downto 352) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 5) <= Dados_from_mem(351 downto 320) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 6) <= Dados_from_mem(319 downto 288) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 7) <= Dados_from_mem(287 downto 256) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 8) <= Dados_from_mem(255 downto 224) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 9) <= Dados_from_mem(223 downto 192) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 10) <= Dados_from_mem(191 downto 160) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 11) <= Dados_from_mem(159 downto 128) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 12) <= Dados_from_mem(127 downto 96) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 13) <= Dados_from_mem(95 downto 64) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 14) <= Dados_from_mem(63 downto 32) after Tacesso;
			CacheI(CONV_INTEGER(Ender(13 downto 2)) + 15) <= Dados_from_mem(31 downto 0) after Tacesso;
            Tag_tab(CONV_INTEGER(Ender(13 downto 6))) <= Ender(15 downto 14) after Tacesso;
            Valid_tab(CONV_INTEGER(Ender(13 downto 6))) <= '1' after Tacesso;
			ReadyMI <= '1' after Tacesso;
		elsif (menable'event and menable = '1') then
   			Dados_cache <= CacheI(conv_integer(Ender(13 downto 2)));
			ReadyMI <= '1' after Tacesso;
		elsif (menable'event and menable = '0') then
			Dados_cache <= (others => 'Z');
			ReadyMI <= '0';
		end if;
    end process;
end Cache_Inst;
