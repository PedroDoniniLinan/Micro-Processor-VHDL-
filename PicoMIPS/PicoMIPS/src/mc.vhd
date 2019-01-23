library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use ieee.std_logic_unsigned.all;

entity MC is
	 port(
		 CLK : in STD_LOGIC;
		 Estd : in STD_LOGIC_VECTOR(4 downto 0);
		 MicroInst : out STD_LOGIC_VECTOR(29 downto 0)
	     );
end MC;

architecture comportamental of MC is
type memoria is array(0 to 31) of std_logic_vector(29 downto 0);
signal mem : memoria := (others => (others => '0'));
begin
	mem(0) <= "000000010000000000000000000000";
	mem(1) <= "010000100000100000000000001001";
	mem(2) <= "100000010000100000000000010000";
	mem(3) <= "011000010001100000001100100010";
	mem(4) <= "011000010010000000000100000110";
	mem(5) <= "000000010000100000000001100000";
	mem(6) <= "000000010000100000000100100000";
	mem(7) <= "000000010000101100000001100000";
	mem(8) <= "000000010000100010000001100000";
	mem(9) <= "000000010000100100000001100000";
	mem(10) <= "000000010000100110000001100000";
	mem(11) <= "000000010000101000000001100000";
	mem(12) <= "000000010000101000000101100000";
	mem(13) <= "000000010000101010000001100000";
	mem(14) <= "001011110000100010000000000000";
	mem(15) <= "001000010000100001000000010000";
	mem(16) <= "001000011000100010000000000000";
	mem(17) <= "001000010000100001000000010000";
	mem(18) <= "000000010000100000100000010000";
	mem(19) <= "000101001010000000010010100000";
	mem(20) <= "000000010000100000100000010000";
	mem(21) <= "000000010000100001100000010000";
	process(CLK)
	begin	   
		if(CLK'event and CLK = '1') then MicroInst <= mem(conv_integer(Estd));
		end if;
	end process;
end comportamental;
