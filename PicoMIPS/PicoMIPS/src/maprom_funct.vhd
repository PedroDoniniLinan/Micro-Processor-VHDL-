library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use ieee.std_logic_unsigned.all;

entity MaPROM_funct is
	 port(
		 CLK : in STD_LOGIC;
		 cop : in STD_LOGIC_VECTOR(5 downto 0);
		 Lcop : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end MaPROM_funct;

architecture comportamental of MaPROM_funct is
type memoria is array(0 to 63) of std_logic_vector(4 downto 0);
signal mem : memoria := (others => (others => '0'));
begin	   
	mem(0) <= "01101";
	mem(8) <= "10101";
	mem(32) <= "00101";
	mem(33) <= "00111";
	mem(34) <= "01000";
	mem(36) <= "01001";
	mem(37) <= "01010";
	mem(42) <= "01011";
	process(CLK)
	begin	   
		if(CLK'event and CLK = '1') then Lcop <= mem(conv_integer(cop));
		end if;
	end process;
end comportamental;
