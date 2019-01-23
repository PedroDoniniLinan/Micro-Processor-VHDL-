library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Carimbo_UC is
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
		 menableD : out STD_LOGIC;
		 menableI : out STD_LOGIC;
		 ce_ri : out STD_LOGIC;
		 ce_pc : out STD_LOGIC;
		 RegWrite : out STD_LOGIC;
		 RegDest : out STD_LOGIC_VECTOR(1 downto 0);
		 ALUSrc : out STD_LOGIC;		 			
		 MemtoReg : out STD_LOGIC_VECTOR(1 downto 0);		 
		 Branch : out STD_LOGIC_VECTOR(1 downto 0);
		 ALUop : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end Carimbo_UC;

architecture estrutural of Carimbo_UC is

component MC is
	 port(
		 CLK : in STD_LOGIC;
		 Estd : in STD_LOGIC_VECTOR(4 downto 0);
		 MicroInst : out STD_LOGIC_VECTOR(29 downto 0)
	     ); 
end component;

component MaPROM_funct is
	 port(
		 CLK : in STD_LOGIC;
		 cop : in STD_LOGIC_VECTOR(5 downto 0);
		 Lcop : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end component;

component MaPROM_cop is
	 port(
		 CLK : in STD_LOGIC;
		 cop : in STD_LOGIC_VECTOR(5 downto 0);
		 Lcop : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end component;

component Mux_4x1_1b is
	 port(
		 E0 : in STD_LOGIC;
		 E1 : in STD_LOGIC;
		 E2 : in STD_LOGIC;
		 E3 : in STD_LOGIC;	 
		 sel : in  std_logic_vector(1 downto 0);		 
		 S : out STD_LOGIC
	     );
end component;

component Mux_2x1_5b is --declaração da entidade
port (	E0,E1	 	: in  std_logic_vector(4 downto 0); -- entradas
		sel			: in  std_logic;
		S			: out std_logic_vector(4 downto 0));-- saida
end component;

component RE is
	 port(
		 CLK : in STD_LOGIC;
		 Reset : in STD_LOGIC;
		 D : in STD_LOGIC_VECTOR(4 downto 0);
		 S : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end component;

signal NextEstd, Estd, Lv, Lf, Lcop, Lfunct, LInst, Lvf : std_logic_vector(4 downto 0);
signal MicroInst : std_logic_vector(29 downto 0);
signal SelVF, Decode, InstType : std_logic;
signal Teste : std_logic_vector(1 downto 0);

begin											  
	InstType <= Cop(0) or Cop(1) or Cop(2) or Cop(3) or Cop(4) or Cop(5); 
	menableI <= MicroInst(0);
	menableD <= MicroInst(1);
	rw <= MicroInst(2);
	ce_ri <= MicroInst(3);
	ce_pc <= MicroInst(4);
	RegWrite <= MicroInst(5);
	RegDest <= MicroInst(7 downto 6);
	ALUSrc <= MicroInst(8);
	MemtoReg <= MicroInst(10 downto 9);
	Branch <= MicroInst(12 downto 11);
	ALUop <= MicroInst(16 downto 13);
	
	Lf <= MicroInst(21 downto 17);
	Lv <= MicroInst(26 downto 22);
	Teste <= MicroInst(28 downto 27);
	Decode <= MicroInst(29);
	
	M_C: MC port map(CLK, Estd, MicroInst);
	MaPROMcop: MaPROM_cop port map(CLK, Cop, Lcop);
	MaPROMfunct: MaPROM_funct port map(CLK, Funct, Lfunct);
	MuxIn: Mux_4x1_1b port map(Start, Zero, HitI, HitD, Teste, SelVF);
	MuxMap: Mux_2x1_5b port map(Lfunct, Lcop, InstType, LInst);
	MuxVF: Mux_2x1_5b port map(Lf, Lv, SelVF, Lvf);
	MuxE: Mux_2x1_5b port map(Lvf, LInst, Decode, NextEstd);
	R_E: RE port map(CLK, Reset, NextEstd, Estd);

end estrutural;
