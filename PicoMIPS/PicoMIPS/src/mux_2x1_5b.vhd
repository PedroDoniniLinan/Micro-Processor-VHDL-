library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Mux_2x1_5b is --declaração da entidade
port (	E0,E1	 	: in  std_logic_vector(4 downto 0); -- entradas
		sel			: in  std_logic;
		S			: out std_logic_vector(4 downto 0));-- saida
end Mux_2x1_5b;

architecture comportamental of Mux_2x1_5b is --descricao comportamental do mux
begin
	S <= E1 when (sel = '1') else E0;
end comportamental;
