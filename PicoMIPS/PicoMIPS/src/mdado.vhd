library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Mdado is --declaração da entidade
port (	CLK, Menable, rw 	: in  std_logic; 
		Addr				: in  std_logic_vector(11 downto 0); 
		WriteData			: in  std_logic_vector(31 downto 0); --dados de entrada
		ReadData			: out std_logic_vector(31 downto 0));--dados de saida
end Mdado;

architecture comportamental of Mdado is --descricao comportamental do registrador
type memoria is array (0 to 4095) of std_logic_vector (31 downto 0);
signal mem : memoria := ((others => (others => '0')));
begin
	process(Menable, rw, Addr, CLK)
	begin
		if (rw = '0' and Menable = '1') then ReadData <= mem(conv_integer(Addr)); 
		elsif (rw = '1' and Menable = '1' and CLK'event and CLK = '0') then mem(conv_integer(Addr)) <= WriteData;
		end if;
	end process;
end comportamental;
