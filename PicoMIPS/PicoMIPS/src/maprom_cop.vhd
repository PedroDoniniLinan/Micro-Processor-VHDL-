library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use ieee.std_logic_unsigned.all;

entity MaPROM_cop is
	 port(
		 CLK : in STD_LOGIC;
		 cop : in STD_LOGIC_VECTOR(5 downto 0);
		 Lcop : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end MaPROM_cop;

architecture comportamental of MaPROM_cop is
type memoria is array(0 to 63) of std_logic_vector(4 downto 0);
signal mem : memoria := (others => (others => '0'));
begin
	mem(2) <= "10010";
	mem(3) <= "10011";
	mem(4) <= "01110";
	mem(5) <= "10000";
	mem(8) <= "00110";
	mem(10) <= "01100";
	mem(35) <= "00011";
	mem(43) <= "00100";
	mem(63) <= "00000";
	process(CLK)
	begin	   
		if(CLK'event and CLK = '1') then Lcop <= mem(conv_integer(cop));
		end if;
	end process;
end comportamental;
