-------------------------------------------------------------------------------
--
-- Title       : UC_MP
-- Design      : hierarq_mem
-- Author      : Jeferson
-- Company     : USP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\proj_hierarq_mem (1)\proj_hierarq_mem\hierarq_mem\src\UC_MP.vhd
-- Generated   : Tue Jul  4 18:00:01 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {UC_MP} architecture {UCMPA}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UC_MP is
	port(
		 CLK	  : in STD_LOGIC;
		 MenableD : in STD_LOGIC;
		 MenableI : in STD_LOGIC;
		 OvfO     : in STD_LOGIC;
		 Sel 	  : out STD_LOGIC_VECTOR (1 DOWNTO 0)
	     );
end UC_MP;

--}} End of automatically maintained section

architecture UCMPA of UC_MP is
type STATE is (S, I, D, B);
signal estado : STATE := S;
signal next_estado : STATE;
begin
	process (estado, MenableD, MenableI, OvfO)
	begin
		case estado is
			when S =>
				if (MenableI = '1') then
					next_estado <= I;
				elsif (MenableD = '1') then
					next_estado <= D;
				else
					next_estado <= S;
				end if;
			when I =>
				Sel <= "00";
				if (MenableI = '0') then
					next_estado <= S;
				else 
					next_estado <= I;
				end if;
			when D =>
				Sel <= "01";
				if (MenableD = '0' and OvfO = '0') then
					next_estado <= S;
				elsif (MenableD = '1' and OvfO = '0') then
					next_estado <= D;
				elsif (OvfO = '1') then
					next_estado <= B;
				end if;
			when B =>
				Sel <= "11";
				if (OvfO = '0') then
					next_estado <= S;
				else
					next_estado <=B;
				end if;
		end case;		
	end process;
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
			estado <= next_estado;
		end if;
	end process;

	 -- enter your statements here --

end UCMPA;
