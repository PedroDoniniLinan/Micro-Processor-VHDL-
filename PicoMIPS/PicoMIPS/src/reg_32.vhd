library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Reg_32 is
	 port(
		 CLK, ce, reset : in STD_LOGIC;
		 E : in STD_LOGIC_VECTOR(31 downto 0);
		 S : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end Reg_32;

architecture comportamental of Reg_32 is
begin
process(CLK)
begin
		if (reset ='1') then S <= x"00000018";
		elsif (CLK'event and CLK='0' and ce ='1') then S <= E; --borda de subida do clock
		end if;
end process;
end comportamental;
