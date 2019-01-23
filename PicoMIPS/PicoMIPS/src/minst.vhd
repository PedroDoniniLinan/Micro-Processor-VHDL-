library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;

entity Minst is
	 port(
		 ReadAddr : in STD_LOGIC_VECTOR(11 downto 0);
		 Inst : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end Minst;

architecture comportamental of Minst is
type memoria is array(0 to 4095) of std_logic_vector(31 downto 0);
signal mem : memoria := (others => (others => '0'));
begin
	mem(0) <= x"2000100C";
	mem(1) <= x"00010820";
	mem(2) <= x"0040082A";
	mem(3) <= x"00411000";
	mem(4) <= x"1064000A"; 
	mem(8) <= x"00E00000";
	mem(16) <= x"08000400";
	mem(1024) <= x"00000008";
	mem(1027) <= x"AC400002";
	mem(1028) <= x"8C410002";
	mem(1029) <= x"0C000008";
	process(ReadAddr)
	begin
		Inst <= mem(conv_integer(ReadAddr));
	end process;
end comportamental;

