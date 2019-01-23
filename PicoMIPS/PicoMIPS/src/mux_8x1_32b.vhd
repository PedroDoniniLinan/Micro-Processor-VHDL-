library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux_8x1_32b is
	port(	   
		 E0 : in STD_LOGIC_VECTOR(31 downto 0); 
		 E1 : in STD_LOGIC_VECTOR(31 downto 0);
		 E2 : in STD_LOGIC_VECTOR(31 downto 0);
		 E3 : in STD_LOGIC_VECTOR(31 downto 0);
		 E4 : in STD_LOGIC_VECTOR(31 downto 0);
		 E5 : in STD_LOGIC_VECTOR(31 downto 0);
		 E6 : in STD_LOGIC_VECTOR(31 downto 0);
		 E7 : in STD_LOGIC_VECTOR(31 downto 0);
		 sel: in STD_LOGIC_VECTOR(2 downto 0);
		 S : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end Mux_8x1_32b;

architecture comportamental of Mux_8x1_32b is
begin
process(sel,E0,E1,E2,E3,E4,E5,E6,E7)
	begin
		case sel is
			when "000" => S <= E0;
			when "001" => S <= E1;
			when "010" => S <= E2;
			when "011" => S <= E3;
			when "100" => S <= E4;
			when "101" => S <= E5;
			when "110" => S <= E6;
			when "111" => S <= E7; 
			when others => S <= E1;
		end case;
end process;
end comportamental;
