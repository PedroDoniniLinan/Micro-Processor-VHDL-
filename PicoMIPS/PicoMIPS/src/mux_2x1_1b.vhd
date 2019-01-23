library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1_1b is --declaração da entidade
port (	E0,E1	 	: in  std_logic; -- entradas
		sel			: in  std_logic;
		S			: out std_logic);-- saida
end Mux_2x1_1b;

architecture comportamental of Mux_2x1_1b is --descricao comportamental do mux
begin
	S <= E1 when (sel = '1') else E0;
end comportamental;
