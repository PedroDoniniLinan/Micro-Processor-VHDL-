library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UCP_Carimbo is
	port(
		reset		: in std_logic;
		clk			: in std_logic;
		HitD		: in std_logic;
		HitI		: in std_logic;
		start		: in std_logic;
		
		MI_Dado 	: in STD_LOGIC_VECTOR(31 downto 0);
		MD_Dado 	: in STD_LOGIC_VECTOR(31 downto 0);
		
		zero		:buffer std_logic;
		COP			:buffer std_logic_vector (5 downto 0);
		COPExt		:buffer std_logic_vector (5 downto 0);

	    ce_ri		:buffer std_logic;
	    ce_pc		:buffer std_logic;
	    RegWrite	:buffer std_logic;
	    RegDest		:buffer std_logic_vector (1 downto 0);
        ALUSrc		:buffer std_logic;
        MemtoReg	:buffer std_logic_vector (1 downto 0);
        Branch		:buffer std_logic_vector (1 downto 0);
        ALUop		:buffer std_logic_vector (3 downto 0);
		
		Write_Reg										: buffer std_logic_vector (4 downto 0);
		 Reg_1, Reg_2, Write_Data			 				: buffer std_logic_vector (31 downto 0); -- sinais referentes ao banco de registradores
		 B, ALU_Rst 										: buffer std_logic_vector (31 downto 0); -- sinais referentes a ALU
		 Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP 	: buffer std_logic_vector (31 downto 0); -- sinais referentes ao PC
		 Imed, Displacement 								: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
		 Inst, JMP_Addr					         		: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes
		
		menableD	:out std_logic;
		menableI	:out std_logic;
	    rw			:out std_logic;
		MI_ADDR 	:out STD_LOGIC_VECTOR(15 downto 0);
		MD_ADDR 	:out STD_LOGIC_VECTOR(15 downto 0);
		MD_WD 		:out STD_LOGIC_VECTOR (31 downto 0)
		);
end UCP_Carimbo;

architecture UCP_CarimboEstrutural of UCP_Carimbo is
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
end component;	  

component FD_Estrut is
	 port(
		 Reset : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 ce_ri : in STD_LOGIC;
		 ce_pc : in STD_LOGIC;
		 RegWrite : in STD_LOGIC;
		 RegDest : in STD_LOGIC_VECTOR(1 downto 0);
		 ALUSrc : in STD_LOGIC;
		 MemtoReg : in STD_LOGIC_VECTOR(1 downto 0);
		 Branch : in STD_LOGIC_VECTOR(1 downto 0);
		 ALUop : in STD_LOGIC_VECTOR(3 downto 0);
		 MI_Dado : in STD_LOGIC_VECTOR(31 downto 0);
		 MD_Dado : in STD_LOGIC_VECTOR(31 downto 0);
		 
		 		 Write_Reg										: buffer std_logic_vector (4 downto 0);
		 Reg_1, Reg_2, Write_Data			 				: buffer std_logic_vector (31 downto 0); -- sinais referentes ao banco de registradores
		 B, ALU_Rst 										: buffer std_logic_vector (31 downto 0); -- sinais referentes a ALU
		 Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP 	: buffer std_logic_vector (31 downto 0); -- sinais referentes ao PC
		 Imed, Displacement 								: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
		 Inst, JMP_Addr					         		: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes
		 
		 MI_ADDR : out STD_LOGIC_VECTOR(15 downto 0);
		 MD_ADDR : out STD_LOGIC_VECTOR(15 downto 0);
		 MD_WD : out STD_LOGIC_VECTOR (31 downto 0);
		 Zero : out STD_LOGIC;
		 Cop : out STD_LOGIC_VECTOR(5 downto 0);
		 Funct : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end component; 


Signal MEND : std_logic;
Signal MENI : std_logic;
Signal RWM : std_logic;

begin
	UC: Carimbo_UC port map (clk,reset,HitD,HitI,Zero,start,COPExt,COP,RWM,MEND,MENI,ce_ri,ce_pc,RegWrite,RegDest,ALUSrc,MemtoReg,Branch,ALUop);
	FD: FD_Estrut port map (reset, clk, ce_ri, ce_pc, RegWrite, RegDest, ALUSrc, MemtoReg, Branch, ALUop,MI_Dado, MD_Dado,Write_Reg,Reg_1, Reg_2, Write_Data,B, ALU_Rst,Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP,Imed, Displacement , Inst, JMP_Addr, MI_ADDR, MD_ADDR, MD_WD, Zero, COP, COPExt);			 
	
	menableD <= MEND;
	menableI <= MENI;
	rw <= RWM;
	
end UCP_CarimboEstrutural;