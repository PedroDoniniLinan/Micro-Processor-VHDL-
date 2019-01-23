library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RE is
	 port(
		 CLK : in STD_LOGIC;
		 Reset : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(4 downto 0);
		 S : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end RE;

architecture comportamental of RE is
begin	
	process(CLK)
		begin
		if (Reset ='1') then S <= "00000";
		elsif (CLK'event and CLK = '0') then S <= D; --borda de subida do clock
		end if;	
	end process;
end comportamental;
