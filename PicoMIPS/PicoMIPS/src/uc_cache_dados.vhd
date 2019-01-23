library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UC_Cache_dados is
	 port(
		 RW : in STD_LOGIC;
		 Valid_proc : in STD_LOGIC;	 --Indica se tem uma operação do Processador pro Cache
		 Valid_mem : out std_logic;	 --Indica se tem uma operação do Cache pra Memória
		 Hit : in std_logic;
		 Ready_mem : in std_logic;
		 RW_mem : out std_logic;
		 Ready : out std_logic
	     );
end UC_Cache_dados;


architecture UC_Cache_dados of UC_Cache_dados is	  

begin

	 -- enter your statements here --

end UC_Cache_dados;