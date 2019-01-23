library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UCPCarimboTB is
end UCPCarimboTB;

architecture UCPCarimboTBArch of UCPCarimboTB is	   
component UCP_Carimbo is
	port(
		reset: in std_logic;
		clk: in std_logic;
		HitD: in std_logic;
		HitI: in std_logic;
		start: in std_logic;
		
		zero		:buffer std_logic;
		COP			:buffer std_logic_vector (5 downto 0);
		COPExt		:buffer std_logic_vector (5 downto 0);
		
	    menable		:buffer std_logic;
	    rw			:buffer std_logic;
	    ce_ri		:buffer std_logic;
	    ce_pc		:buffer std_logic;
	    RegWrite	:buffer std_logic;
	    RegDest		:buffer std_logic_vector (1 downto 0);
        ALUSrc		:buffer std_logic;
        MemtoReg	:buffer std_logic_vector (1 downto 0);
        Branch		:buffer std_logic_vector (1 downto 0);
        ALUop		:buffer std_logic_vector (3 downto 0)
		);
end component;
signal reset : std_logic;
signal clk : std_logic;
signal HitD : std_logic;
signal HitI : std_logic;

signal zero : std_logic;
signal COP : std_logic_vector (5 downto 0);
signal Funct : std_logic_vector (5 downto 0);

signal menable : std_logic;
signal rw: std_logic;
signal ce_ri : std_logic;
signal ce_pc : std_logic;
signal RegWrite : std_logic;
signal RegDest : std_logic_vector (1 downto 0);
signal ALUSrc : std_logic;
signal MemtoReg : std_logic_vector (1 downto 0);
signal Branch : std_logic_vector (1 downto 0);
signal ALUop : std_logic_vector (3 downto 0);

signal start : std_logic;

begin
	UCPC : UCP_Carimbo port map (reset, clk, HitD, HitI, start, zero, COP, Funct, menable, rw, ce_ri, ce_pc, RegWrite, RegDest, ALUSrc, MemtoReg, Branch, ALUop);
	process
	begin	
			HitD <= '0';
			HitI <= '0';
			Start <= '0';
			CLK <= '1';
			reset <= '1';
			wait for 5 ns;
			CLK <= '0';	
			reset <= '0';
			wait for 5 ns;	--10
			
			CLK <= '1';
			Start <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; --20
			Start <= '0';
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	 
			wait for 5 ns;   -- 30
			HitI <= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 40
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 50
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 60
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 70
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 80
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 90
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 100
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 110
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 120
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 130
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 140
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 150
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 160
			
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 170
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 180
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 190
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 200
			
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 210
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 220
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 230
			
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 240
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 250
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 260
			
			HitD<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 270 
			HitD<= '0';
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 280
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 290
			
			HitD<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 300
			HitD<= '1';
			
			HitI<= '1';
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 310
			HitI<= '0';
			
			CLK <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; -- 320
			
			
	 -- enter your statements here --
	 end process;
end UCPCarimboTBArch;