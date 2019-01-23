library ieee;
use ieee.std_logic_1164.all;

entity Shift_Left_2 is --declaração da entidade
port (	E	: in  std_logic_vector(31 downto 0); --dados de entrada
		S	: out std_logic_vector(31 downto 0));--dados de saida
end Shift_Left_2;

architecture comportamental of Shift_Left_2 is --descricao comportamental do Shift_Left_2
begin
	S <= E(29 downto 0) & "00";
end comportamental;
