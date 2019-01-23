library ieee;
use ieee.std_logic_1164.all;

entity FD_tb is --declaração da entidade
end FD_tb;

architecture comportamental of FD_tb is --descricao comportamental do registrador

	component FD_Debug is
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
	end component; 

	signal Reset : STD_LOGIC := '0';
	signal clk : STD_LOGIC := '0';
	signal menable : STD_LOGIC := '0';
	signal rw : STD_LOGIC := '0';
	signal ce_ri : STD_LOGIC := '0';
	signal ce_pc : STD_LOGIC := '0';
	signal RegWrite : STD_LOGIC := '0';
	signal RegDest : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal ALUSrc : STD_LOGIC := '0';	 	
	signal MemtoReg : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal Branch : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal ALUop : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');	

	signal Write_Reg										: std_logic_vector (4 downto 0);
	signal Reg_1, Reg_2, Write_Data			 				: std_logic_vector (31 downto 0); -- sinais referentes ao banco de registradores
	signal B, ALU_Rst 										: std_logic_vector (31 downto 0); -- sinais referentes a ALU
	signal Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch,PC_JMP 	: std_logic_vector (31 downto 0); -- sinais referentes ao PC
	signal Imed, Displacement 								: std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
	signal MI_Out, Inst, JMP_Addr							: std_logic_vector (31 downto 0); -- sinais referentes a instrucoes	
	signal MD_Out	 										: std_logic_vector (31 downto 0); -- sinal referente a memoria de dado
	
	signal Zero : STD_LOGIC;
	signal Cop : STD_LOGIC_VECTOR(5 downto 0);
	signal Funct : STD_LOGIC_VECTOR(5 downto 0);

	begin
		M1: FD_debug port map (Reset, clk, menable, rw, ce_ri, ce_pc, RegWrite, RegDest, ALUSrc, MemtoReg, Branch, ALUop, Write_Reg, Reg_1, Reg_2, Write_Data, B, ALU_Rst, Inst_Addr, Nxt_Addr, PC_Incr, PC_Branch, PC_JMP, Imed, Displacement, MI_Out, Inst, JMP_Addr, MD_Out, Zero, Cop, Funct);
		process
		begin
			clk <= '1';
			reset <= '1';
			wait for 2 ns;
			reset <= '0'; -- b0
			ce_ri <= '1';
			wait for 3 ns;
			clk <= '0';
			wait for 5 ns;	  
			
			clk <= '1';	
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;	   
			
			clk <= '1'; -- addi	   
			ce_pc <= '0';
			ALUSrc <= '1';
			RegWrite <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;	   
			
			clk <= '1';
			ALUSrc <= '0';
			RegWrite <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;	  
			
			clk <= '1';	 
			ce_pc <= '0'; -- add
			RegDest <= "01";
			RegWrite <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';
			RegDest <= "00";
			RegWrite <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1'; -- stl	 
			ce_pc <= '0';
			ALUop <= "0100";
			RegWrite <= '1';
			RegDest <= "01";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';
			ALUop <= "0000";
			RegWrite <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1'; -- sll	 
			ce_pc <= '0';
			ALUop <= "0101";
			RegWrite <= '1';
			RegDest <= "01";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';	
			ALUop <= "0000";
			RegDest <= "00";
			RegWrite <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1'; -- beq 
			ce_pc <= '0';
			ALUop <= "0001";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';
			ALUop <= "0000";
			Branch <= "10";
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';	
			Branch <= "00";
			ce_pc <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1'; -- 	j 
			ce_pc <= '1';
			Branch <= "01";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';	
			ce_pc <= '0';
			Branch <= "00";			
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1'; -- jr 
			ce_pc <= '0';
			Branch <= "11";
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';	
			ce_pc <= '0';
			Branch <= "00";			
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;			
			
			clk <= '1';	 --	sw 
			ce_pc <= '0';
			menable <= '1';
			rw <= '1';
			ALUSrc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
			clk <= '1';
			rw <= '0';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';
			ALUSrc <= '0';			
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;			
			
			clk <= '1';	 --	lw
			ce_pc <= '0';
			menable <= '1';
			ALUSrc <= '1';
			RegWrite <= '1';
			MemtoReg <= "01";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;	
			
			clk <= '1';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';		
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;			
			
			clk <= '1';	 --	jal
			ce_pc <= '0';
			MemtoReg <= "10";
			RegWrite <= '1';
			RegDest <= "10";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
			clk <= '1';	 
			ce_pc <= '1'; 
			Branch <= "01";
			MemtoReg <= "00";
			RegWrite <= '0';
			RegDest <= "00";
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;	
			
			clk <= '1';
			ce_ri <= '1'; -- b0
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns; 
			
		    clk <= '1';
			ce_ri <= '0';		
			ce_pc <= '1';
			wait for 5 ns;	 
			clk <= '0';
			wait for 5 ns;
			
		end process;
end comportamental;
