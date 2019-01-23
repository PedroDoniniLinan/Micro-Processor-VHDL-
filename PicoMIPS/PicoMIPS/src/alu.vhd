library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU is
	port (ALUop : in std_logic_vector (3 downto 0);
	      a : in std_logic_vector (31 downto 0);
	      b : in std_logic_vector (31 downto 0);
	      zero : out std_logic;
	      ALUrst: out std_logic_vector (31 downto 0));
end ALU;

architecture comportamental of ALU is
signal saida : std_logic_vector (31 downto 0);
begin
process(ALUop, a, b, saida)
begin
	case ALUop is
		when "0000" => saida <= (a + b);
		when "0001" => saida <= (a - b);
		when "0010" => saida <= (a and b);
		when "0011" => saida <= (a or b);
		when "0100" => if a < b then saida <= "00000000000000000000000000000001"; else saida <= "00000000000000000000000000000000"; end if;
		when "0101" => saida <= b(29 downto 0) & "00";
		when others => saida <= ("00000000000000000000000000000000");
	end case;
	if saida = 0 then zero <= '1';
	else zero <= '0';   
	end if;
	ALUrst <= saida;
end process;
end comportamental;