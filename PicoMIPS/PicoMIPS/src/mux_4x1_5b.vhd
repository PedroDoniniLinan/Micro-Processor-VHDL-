library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Mux_4x1_5b is
	 port(
		 E0 : in STD_LOGIC_VECTOR(4 downto 0);
		 E1 : in STD_LOGIC_VECTOR(4 downto 0);
		 E2 : in STD_LOGIC_VECTOR(4 downto 0);
		 E3 : in STD_LOGIC_VECTOR(4 downto 0);	 
		 sel : in  std_logic_vector(1 downto 0);		 
		 S : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end Mux_4x1_5b;

architecture comportamental of Mux_4x1_5b is
begin
process(sel,E1,E2,E3,E0)
	begin
		case sel is
			when "00" => S <= E0;
			when "01" => S <= E1;
			when "10" => S <= E2;
			when "11" => S <= E3; 
			when others => S <= E0;
		end case;
end process;
end comportamental;
