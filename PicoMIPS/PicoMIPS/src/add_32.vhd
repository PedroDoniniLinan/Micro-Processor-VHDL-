library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity Add_32 is
	 port(
		 E1 : in STD_LOGIC_VECTOR(31 downto 0);
		 E2 : in STD_LOGIC_VECTOR(31 downto 0);
		 S : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end Add_32;

architecture comportamental of Add_32 is
begin
	 S <= E1 + E2;
end comportamental;
