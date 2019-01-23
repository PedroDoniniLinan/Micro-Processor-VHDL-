library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FD_Debug is
	 port(
		 Reset : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 menable : in STD_LOGIC;
		 rw : in STD_LOGIC;
		 ce_ri : in STD_LOGIC;
		 ce_pc : in STD_LOGIC;
		 RegWrite : in STD_LOGIC;
		 RegDest : in STD_LOGIC_VECTOR(1 downto 0);
		 ALUSrc : in STD_LOGIC;
		 MemtoReg : in STD_LOGIC_VECTOR(1 downto 0);
		 Branch : in STD_LOGIC_VECTOR(1 downto 0);
		 ALUop : in STD_LOGIC_VECTOR(3 downto 0);
		 
		 Write_Reg										: buffer std_logic_vector (4 downto 0);
		 Reg_1, Reg_2, Write_Data			 				: buffer std_logic_vector (31 downto 0); -- sinais referentes ao banco de registradores
		 B, ALU_Rst 										: buffer std_logic_vector (31 downto 0); -- sinais referentes a ALU
		 Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP 	: buffer std_logic_vector (31 downto 0); -- sinais referentes ao PC
		 Imed, Displacement 								: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
		 MI_Out, Inst, JMP_Addr							: buffer std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
		 MD_Out	 										: buffer std_logic_vector (31 downto 0); -- sinal referente a memoria de dado
		 
		 Zero : out STD_LOGIC;
		 Cop : out STD_LOGIC_VECTOR(5 downto 0);
		 Funct : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end FD_Debug;

architecture Debugural of FD_Debug is

component Mdado is --declaração da entidade
port (	CLK, Menable, rw 	: in  std_logic; 
		Addr				: in  std_logic_vector(11 downto 0); 
		WriteData			: in  std_logic_vector(31 downto 0); --dados de entrada
		ReadData			: out std_logic_vector(31 downto 0));--dados de saida
end component;

component ALU is
	port (ALUop : in std_logic_vector (3 downto 0);
	      a : in std_logic_vector (31 downto 0);
	      b : in std_logic_vector (31 downto 0);
	      zero : out std_logic;
	      ALUrst: out std_logic_vector (31 downto 0));
end component;

component Add_32 is
	 port(
		 E1 : in STD_LOGIC_VECTOR(31 downto 0);
		 E2 : in STD_LOGIC_VECTOR(31 downto 0);
		 S : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component Minst is
	 port(
		 ReadAddr : in STD_LOGIC_VECTOR(11 downto 0);
		 Inst : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component Mux_4x1_5b is
	 port(
		 E0 : in STD_LOGIC_VECTOR(4 downto 0);
		 E1 : in STD_LOGIC_VECTOR(4 downto 0);
		 E2 : in STD_LOGIC_VECTOR(4 downto 0);
		 E3 : in STD_LOGIC_VECTOR(4 downto 0);	 
		 sel : in  std_logic_vector(1 downto 0);		 
		 S : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end component;		

component Mux_2x1_32b is --declaração da entidade
port (	E1,E2	 	: in  std_logic_vector(31 downto 0); -- entradas
		sel			: in  std_logic;
		S			: out std_logic_vector(31 downto 0));-- saida
end component;

component Mux_4x1_32b is --declaração da entidade
port (	E1,E2,E3,E4	: in  std_logic_vector(31 downto 0); -- entradas
		sel			: in  std_logic_vector(1 downto 0);
		S			: out std_logic_vector(31 downto 0));-- saida
end component;

component Reg_32 is
	 port(
		 CLK, ce, reset : in STD_LOGIC;
		 E : in STD_LOGIC_VECTOR(31 downto 0);
		 S : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component Shift_Left_2 is --declaração da entidade
	port (	E	: in  std_logic_vector(31 downto 0); --dados de entrada
			S	: out std_logic_vector(31 downto 0));--dados de saida
end component;

component Sign_Extend is
	 port(
		 Entrada 	: in STD_LOGIC_VECTOR(15 downto 0);
		 Saida 		: out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component RegFile is  
	port(
		 Reset : in STD_LOGIC;
		 Clk : in STD_LOGIC;
		 RegWrite : in STD_LOGIC; --Se 1, inicia escrita em um registrador
		 ReadReg1 : in STD_LOGIC_VECTOR(4 downto 0); --Endereço do registrador de leitura 1
		 ReadReg2 : in STD_LOGIC_VECTOR(4 downto 0); --Endereço do registrador de leitura 2
		 WriteReg : in STD_LOGIC_VECTOR(4 downto 0); --Endereço do registrador de escrita
		 WriteData : in STD_LOGIC_VECTOR(31 downto 0); --Dados a serem escritos no registrador endereçado para escrita
		 ReadData1 : out STD_LOGIC_VECTOR(31 downto 0); --Dados a serem lidos do registrador endereçado para leitura 1
		 ReadData2 : out STD_LOGIC_VECTOR(31 downto 0)  --Dados a serem lidos do registrador endereçado para leitura 1
	     );
end component;


begin  
	Cop <= Inst(31 downto 26);
	Funct <= Inst(5 downto 0);
	JMP_Addr <= "00" & Inst_Addr(31 downto 28) & Inst(25 downto 0);
	
	
	
	MD		: Mdado 		port map (clk, Menable, rw, ALU_Rst(11 downto 0), Reg_2, MD_Out);
	MI		: Minst 		port map (Inst_Addr(13 downto 2), MI_Out);
	ALU1 	: ALU 			port map (ALUop, Reg_1, B, Zero, ALU_Rst);
	Add1	: Add_32		port map (Inst_Addr, x"00000004", PC_Incr);
	Add2	: Add_32		port map (PC_Incr, Displacement, PC_Branch);
	Mux1	: Mux_4x1_32b	port map (PC_Incr, PC_JMP, PC_Branch, Reg_1, Branch, Nxt_Addr);
	Mux2	: Mux_2x1_32b	port map (Reg_2, Imed, ALUSrc, B);
	Mux3	: Mux_4x1_32b	port map (ALU_Rst, MD_Out, PC_Incr,x"00000000", MemtoReg, Write_Data);
	Mux4	: Mux_4x1_5b	port map (Inst(20 downto 16), Inst(15 downto 11),"00111", "10000", RegDest, Write_Reg);
	PC		: Reg_32		port map (clk, ce_pc, Reset, Nxt_Addr, Inst_Addr);   
	RI		: Reg_32		port map (clk, ce_ri, Reset, MI_Out, Inst); 
	Sign_Ext: Sign_Extend	port map (Inst(15 downto 0),Imed);
	SL2		: Shift_Left_2	port map (Imed, Displacement);			 
	SL2_2	: Shift_Left_2	port map (JMP_Addr, PC_JMP);
	Reg_File: RegFile		port map (Reset, clk, RegWrite, Inst(25 downto 21), Inst(20 downto 16), Write_Reg, Write_Data, Reg_1, Reg_2);
end Debugural;
