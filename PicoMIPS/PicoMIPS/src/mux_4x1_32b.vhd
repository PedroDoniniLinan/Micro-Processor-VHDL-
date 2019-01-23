library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1_32b is --declaração da entidade
port (	E1,E2,E3,E4	: in  std_logic_vector(31 downto 0); -- entradas
		sel			: in  std_logic_vector(1 downto 0);
		S			: out std_logic_vector(31 downto 0));-- saida
end Mux_4x1_32b;

architecture comportamental of Mux_4x1_32b is --descricao comportamental do mux
begin
process(sel,E1,E2,E3,E4)
	begin
		case sel is
			when "00" => S <= E1;
			when "01" => S <= E2;
			when "10" => S <= E3;
			when "11" => S <= E4; 
			when others => S <= E1;
		end case;
end process;
end comportamental;
