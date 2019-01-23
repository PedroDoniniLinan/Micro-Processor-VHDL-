library ieee;
use ieee.std_logic_1164.all;

entity Carimbo_tb is --declaração da entidade
end Carimbo_tb;

architecture estrutural of Carimbo_tb is --descricao comportamental do registrador

component Carimbo_UC is
	port( 
		 CLK : in STD_LOGIC;
		 Reset : in STD_LOGIC;	
		 HitD : in STD_LOGIC;
		 HitI : in STD_LOGIC;
		 Zero : in STD_LOGIC;
		 Start : in STD_LOGIC;	 
		 Funct : in STD_LOGIC_VECTOR(5 downto 0);
		 Cop : in STD_LOGIC_VECTOR(5 downto 0);	
		 rw : out STD_LOGIC;
		 menable : out STD_LOGIC;
		 ce_ri : out STD_LOGIC;
		 ce_pc : out STD_LOGIC;
		 RegWrite : out STD_LOGIC;
		 RegDest : out STD_LOGIC_VECTOR(1 downto 0);
		 ALUSrc : out STD_LOGIC;		 			
		 MemtoReg : out STD_LOGIC_VECTOR(1 downto 0);		 
		 Branch : out STD_LOGIC_VECTOR(1 downto 0);
		 ALUop : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end component;

signal CLK : STD_LOGIC := '0';
signal Reset : STD_LOGIC := '0';	
signal HitD :  STD_LOGIC := '0';
signal HitI : STD_LOGIC := '0';
signal Zero : STD_LOGIC := '0';
signal Start : STD_LOGIC := '0';	 
signal Funct : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
signal Cop : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');	
signal rw : STD_LOGIC;
signal menable : STD_LOGIC;
signal ce_ri : STD_LOGIC;
signal ce_pc : STD_LOGIC;
signal RegWrite : STD_LOGIC;
signal RegDest : STD_LOGIC_VECTOR(1 downto 0);
signal ALUSrc : STD_LOGIC;		 			
signal MemtoReg : STD_LOGIC_VECTOR(1 downto 0);		 
signal Branch : STD_LOGIC_VECTOR(1 downto 0);
signal ALUop : STD_LOGIC_VECTOR(3 downto 0);

begin
	M1: Carimbo_UC port map(CLK,Reset,HitD,HitI,Zero,Start,Funct,Cop,rw,menable,ce_ri,ce_pc,RegWrite,RegDest,ALUSrc,MemtoReg,Branch,ALUop);
	process
	begin
			CLK <= '1';
			reset <= '1';
			wait for 5 ns;
			CLK <= '0';	
			reset <= '0';
			wait for 5 ns;
			
			CLK <= '1'; -- b0
			Start <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			Start <= '0';
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "000000";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;	 
			
			CLK <= '1'; -- Sll
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "001000";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Jr
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; 

			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "100000";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Add
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "100001";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Addu
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns; 
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "100010";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Sub
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;	  
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "100100";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- And
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;	 
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "100101";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Or
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;	 
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000000";
			Funct <= "101010";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Slt
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000010";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- J
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000011";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Jal
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;	  
			
			CLK <= '1'; -- Jal
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000100";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Beq 
			Zero <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			Zero <= '0';
			
			CLK <= '1'; -- Beq
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000100";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Beq 
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Beq
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000101";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Bne 
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Bne
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "000101";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Bne 
			Zero <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			Zero <= '0';
			
			CLK <= '1'; -- Bne
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;

			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "001000";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Addi
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "001010";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Slti
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "100011";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Lw
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Lw
			HitD <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			HitD <= '0';
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "101011";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Sw
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; -- Sw
			HitD <= '1';
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			HitD <= '0';
			
			CLK <= '1'; -- b1
			HitI<= '1';
			wait for 5 ns;
			CLK <= '0';	
			Cop <= "111111";
			wait for 5 ns;
			HitI <= '0'; 
			
			CLK <= '1'; -- b2 -- Halt
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; 
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
			
			CLK <= '1'; 
			wait for 5 ns;
			CLK <= '0';	
			wait for 5 ns;
	end process;			   
end estrutural;
