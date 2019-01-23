library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1_32b is --declaração da entidade
port (	E1,E2	 	: in  std_logic_vector(31 downto 0); -- entradas
		sel			: in  std_logic;
		S			: out std_logic_vector(31 downto 0));-- saida
end Mux_2x1_32b;

architecture comportamental of Mux_2x1_32b is --descricao comportamental do mux
begin
	S <= E2 when (sel = '1') else E1;
end comportamental;
