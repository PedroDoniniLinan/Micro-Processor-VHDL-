library IEEE;
use IEEE.STD_LOGIC_1164.all;	


entity PicoMIPS is 
	port(
		CLK				:in std_logic;
		reset			:in std_logic;
		Start			:in std_logic;
		v1,v2,v3,v4,v5 	:out std_logic_vector(31 downto 0)
		);
end PicoMIPS; 


architecture PMIPS of PicoMIPS is
component UCP_Carimbo is
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
end component;

component Hierarq_Estrut is
	port(
		 CLK: in std_logic;
		 RWDP: in std_logic;
		 MenablePD: in std_logic;
		 MenablePI: in std_logic;
		 EnderD: in std_logic_vector(15 downto 0);
		 DadosInD: in std_logic_vector(31 downto 0);
		 EnderI: in std_logic_vector(15 downto 0);
		 ReadyD: out std_logic;
		 ReadyI: out std_logic;
		 DadosOutD: out std_logic_vector(31 downto 0);
		 DadosOutI: out std_logic_vector(31 downto 0);
		 v1,v2,v3,v4,v5 : out std_logic_vector(31 downto 0)
	     );
end component;
 signal RWDP:  std_logic;
 signal MenablePD:  std_logic;
 signal MenablePI:  std_logic;
 signal EnderD:  std_logic_vector(15 downto 0);
 signal DadosInD:  std_logic_vector(31 downto 0);
 signal EnderI:  std_logic_vector(15 downto 0);
 signal ReadyD:  std_logic;
 signal ReadyI:  std_logic;
 signal DadosOutD:  std_logic_vector(31 downto 0);
 signal DadosOutI:  std_logic_vector(31 downto 0);
signal zero		: std_logic;
signal COP			: std_logic_vector (5 downto 0);
signal COPExt		: std_logic_vector (5 downto 0);

signal ce_ri		: std_logic;
signal ce_pc		: std_logic;
signal RegWrite	: std_logic;
signal RegDest		: std_logic_vector (1 downto 0);
signal ALUSrc		: std_logic;
signal MemtoReg	: std_logic_vector (1 downto 0);
signal Branch		: std_logic_vector (1 downto 0);
signal ALUop		: std_logic_vector (3 downto 0);

signal Write_Reg									:  std_logic_vector (4 downto 0);
 Signal Reg_1, Reg_2, Write_Data			 				:  std_logic_vector (31 downto 0); -- sinais referentes ao banco de registradores
 signal B, ALU_Rst 										:  std_logic_vector (31 downto 0); -- sinais referentes a ALU
 signal Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP 	:  std_logic_vector (31 downto 0); -- sinais referentes ao PC
 signal Imed, Displacement 								:  std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
 signal Inst, JMP_Addr					         		:  std_logic_vector (31 downto 0); -- sinais referentes a instrucoes

begin
	UCP: UCP_Carimbo port map (reset, CLK,ReadyD, ReadyI, start, DadosOutI, DadosOutD,zero, COP, COPExt, ce_ri, ce_pc, RegWrite, RegDest, ALUSrc, MemtoReg, Branch, ALUop,Write_Reg,Reg_1, Reg_2, Write_Data,B, ALU_Rst,Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP,Imed, Displacement , Inst, JMP_Addr, MenablePD, MenablePI, RWDP, EnderI, EnderD, DadosInD);
	HE : Hierarq_Estrut port map (CLK, RWDP, MenablePD, MenablePI, EnderD, DadosInD, EnderI, ReadyD, ReadyI, DadosOutD, DadosOutI,v1,v2,v3,v4,v5);
end PMIPS;
		
		