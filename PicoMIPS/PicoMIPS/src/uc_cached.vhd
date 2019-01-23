-------------------------------------------------------------------------------
--
-- Title       : UC_CACHED
-- Design      : hierarq_mem
-- Author      : Jeferson
-- Company     : USP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\proj_hierarq_mem (1)\proj_hierarq_mem\hierarq_mem\src\UC_CACHED.vhd
-- Generated   : Tue Jul  4 16:11:59 2017
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
--{entity {UC_CACHED} architecture {UC_CD}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UC_CACHED is
	port(  
	     CLK: in STD_LOGIC;
		 HitD : in STD_LOGIC;
		 RWDP : in STD_LOGIC;
		 MenableDProc : in STD_LOGIC;
		 ReadyMD : in STD_LOGIC;
		 OvfO : in STD_LOGIC;
		 ReadyMEM : in STD_LOGIC;
		 RWD : out STD_LOGIC;
		 MenableD : out STD_LOGIC;
		 ReadyDProc : out STD_LOGIC;
		 RWDM : out STD_LOGIC;
		 RWM : out STD_LOGIC;
		 OvfI : out STD_LOGIC;
		 MenableMEM : out STD_LOGIC	
	     );
end UC_CACHED;

--}} End of automatically maintained section

architecture UC_CD of UC_CACHED is 
type STATE is (I, MissD, RHitD, WHitD, RdD, MprdyD, Ibuff, RHitDbuff, WHitDbuff, RdDbuff);
signal estado : STATE := I;
signal next_estado : STATE;
begin 
	process (HitD, RWDP, MenableDProc, ReadyMD, OvfO, ReadyMEM, estado)
	begin
		case estado is
			when I =>
				RWD <= '0';
				RWM <= '0';
				MenableD <= '0';
				ReadyDProc <= '0';
				RWDM <= '0';
				OvfI <= '0';
				MenableMEM <= '0';
				if (MenableDProc = '1') then
					if (HitD = '1') then 
						if (RWDP = '1') then 
							next_estado <= WHitD;
						else
							next_estado <= RHitD;
						end if;
					else
						next_estado <= MissD;
					end if;
				else
					next_estado <= I;
				end if;
			when MissD =>
				MenableMEM <= '1';
				if (ReadyMEM = '1' and OvfO = '0') then
					next_estado <= MprdyD;
				else
					next_estado <= MissD;
				end if;
			when RHitD => 
				MenableD <= '1';
				if (ReadyMD = '1') then
					next_estado <= RdD;
				else
					next_estado <= RHitD;
				end if;
			when WHitD =>	  
				MenableD <= '1';
				RWD <= '1';
				if (ReadyMD = '1') then
					next_estado <= RdD;
				else
					next_estado <= WHitD;
				end if;
			when RdD =>		
				ReadyDProc <= '1';
				MenableD <= '1';
				RWD <= '0';
				next_estado <= I;
			when MprdyD =>
				RWDM <= '1';
				MenableD <= '1';
				MenableMEM <= '0';
				if (ReadyMD = '1') then
					if (OvfO = '1') then
						next_estado <= Ibuff;
					else
						next_estado <= I;
					end if;
				else
					next_estado <= MprdyD;
				end if;
			when Ibuff => 
				ReadyDProc <= '0';
				MenableD <= '0';
				MenableMEM <= '1';
				RWM <= '1';
				OvfI <= '1';
				RWDM <= '0';
				if (ReadyMEM = '0') then
					if (MenableDProc = '1') then 
						if (RWDP = '1') then 
							next_estado <= WHitDbuff;
						else
							next_estado <= RHitDbuff;
						end if;
					else
						next_estado <= Ibuff;
					end if;
				else
					next_estado <= I;
				end if;
			when RHitDbuff =>	 
				MenableMEM <= '1';
				RWM <= '1';
				OvfI <= '1';
				MenableD <= '1';
				if (ReadyMD = '1') then
					next_estado <= RdDbuff;
				else
					next_estado <= RHitDbuff;
				end if;
			when WHitDbuff =>  
				MenableD <= '1';
				RWD <= '1';
				MenableMEM <= '1';
				RWM <= '1';
				OvfI <= '1';
				if (ReadyMD = '1') then
					next_estado <= RdDbuff;
				else
					next_estado <= WHitDbuff;
				end if;
			when RdDbuff =>	
				ReadyDProc <= '1';
				MenableMEM <= '1';
				RWM <= '1';
				OvfI <= '1';
				MenableD <='1';
				RWD <= '0';
				next_estado <= Ibuff;
			end case;
	end process;
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
			estado <= next_estado;
		end if;
	end process;			

	 -- enter your statements here --

end UC_CD;
