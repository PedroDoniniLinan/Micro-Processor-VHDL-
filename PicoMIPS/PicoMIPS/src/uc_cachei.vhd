-------------------------------------------------------------------------------
--
-- Title       : UC_CACHEI
-- Design      : hierarq_mem
-- Author      : Jeferson
-- Company     : USP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\proj_hierarq_mem (1)\proj_hierarq_mem\hierarq_mem\src\UC_CACHEI.vhd
-- Generated   : Tue Jul  4 15:08:56 2017
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
--{entity {UC_CACHEI} architecture {UC_CACHEI_ASM}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UC_CACHEI is
	port(
		 CLK : in std_logic;
		 HitI : in STD_LOGIC;
		 MenableProc : in STD_LOGIC;
		 ReadyMI : in STD_LOGIC;
		 ReadyMEM : in STD_LOGIC;
		 MenableI : out STD_LOGIC;
		 RWI : out STD_LOGIC;
		 MenableMem : out STD_LOGIC;
		 ReadyIProc : out STD_LOGIC
	     );
end UC_CACHEI;

--}} End of automatically maintained section

architecture UC_CACHEI_ASM of UC_CACHEI is
type STATE is (I, MissI, HI, MprdyI, RdI);
signal estado : STATE := I;
signal next_estado : STATE;
begin
	process (estado, HitI, MenableProc, ReadyMI, ReadyMEM)
	begin
		case estado is
			when I =>
				MenableI <= '0';
				RWI <= '0';
				MenableMem <= '0';
				ReadyIProc <= '0';
				if (MenableProc = '1') then
					if (HitI = '1') then next_estado <= HI;
					else next_estado <= MissI;
					end if;
				else next_estado <= I;
				end if;
			when HI =>
				MenableI <= '1';
				RWI <= '0';
				MenableMem <= '0';
				ReadyIProc <= '0';
				if (ReadyMI = '1') then next_estado <= RdI;
				else next_estado <= HI;
				end if;
			when MissI =>
				MenableI <= '0';
				RWI <= '0';
				MenableMem <= '1';
				ReadyIProc <= '0';
				if (ReadyMEM = '1') then next_estado <= MprdyI;
				else next_estado <= MissI;
				end if;
			when MprdyI =>
				MenableI <= '1';
				RWI <= '1';
				MenableMem <= '0';
				ReadyIProc <= '0';
				if (ReadyMI = '1') then next_estado <= I;
				else next_estado <= MprdyI;
				end if;
			when RdI =>
				MenableI <= '1';
				RWI <= '0';
				MenableMem <= '1';
				ReadyIProc <= '1';
				next_estado <= I;
		end case;		
	end process;
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
			estado <= next_estado;
		end if;
	end process;
	 -- enter your statements here --

end UC_CACHEI_ASM;
