library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Sign_Extend is
	 port(
		 Entrada : in STD_LOGIC_VECTOR(15 downto 0);
		 Saida : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end Sign_Extend;

architecture comportamental of Sign_Extend is  
signal vetor : std_logic_vector (31 downto 0);
begin
	process (Entrada, vetor)
	begin
		case Entrada(15) is
			when '1' => vetor <= "1111111111111111" & Entrada;
			when '0' => vetor <= "0000000000000000" & Entrada;
			when others => vetor <= "11111111111111111111111111111111";
		end case;
		Saida <= vetor;
	end process;
end comportamental;
