library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;

entity UC_Cache_inst is
	generic(
		Tacesso :time := 5 ns
	);	 
	 port(
		 Valid_proc : in STD_LOGIC;		--Indica se tem uma operação do Processador pro Cache
		 Valid_mem : out STD_LOGIC;		--Indica se tem uma operação do Cache pra Memória
		 Hit : in std_logic;
		 Ready : out std_logic;
		 Ready_mem : in STD_logic;
		 RW_mem : out std_logic		 
	     );
end UC_Cache_Inst;


architecture UC_Cache_Inst of UC_Cache_Inst is

begin
	
	
end UC_Cache_Inst;