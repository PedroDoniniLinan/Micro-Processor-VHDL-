 library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Hierarq_Estrut is
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
end Hierarq_Estrut;

architecture estrutural of Hierarq_Estrut is		

type STATE is (I, MissD, RHitD, WHitD, RdD, MprdyD, Ibuff, RHitDbuff, WHitDbuff, RdDbuff);

component Cache_dados is
	generic(
		Tacesso :time := 5 ns
	);
	 port(
	 	menable : in STD_LOGIC;
		OvfI : in STD_LOGIC;
	    RW : in std_logic; --do processador
		RW_mem : in std_logic; --da memoria
        Ender : in STD_LOGIC_VECTOR(15 downto 0);
        Dados_entrada : in STD_LOGIC_VECTOR(31 downto 0);
        Dados_mem : in STD_logic_vector(511 downto 0);
		Dados_buffer : out std_logic_vector(511 downto 0);
		Ender_buffer : out std_logic_vector(15 downto 0);
		Dados_saida : out std_logic_vector(31 downto 0);
        Hit : out std_logic;
		OvfO : out STD_LOGIC;
		ReadyMD : out STD_LOGIC;
		v1,v2,v3,v4,v5 : out std_logic_vector(31 downto 0)
	     );
end component;

component Cache_Inst is
    generic(
        Tacesso :time := 5 ns
    );
    port(
         menable : in STD_LOGIC;
         Ender : in STD_LOGIC_VECTOR(15 downto 0);
		 Dados_from_mem : in STD_logic_vector(511 downto 0);
         W : in std_logic; --da memoria	
		 Dados_cache : out STD_LOGIC_VECTOR(31 downto 0);
         Hit : out std_logic;
		 ReadyMI : out std_logic
         );
end component;

component Mp is
  generic(
       BE 		: integer 	:= 16; 
       BP 		: integer 	:= 32; 
       Tz 		: time 		:= 1.5 ns; 
       Twrite 	: time 		:= 100 ns; 
       Tsetup 	: time 		:= 1 ns; 
       Tread 	: time  	:= 100 ns 
  );
  port(
       enable 	: in 	std_logic;
       rw 		: in 	std_logic;
       ender 	: in 	std_logic_vector(BE - 1 downto 0);
	   dado		: in	std_logic_vector(511 downto 0);
       pronto 	: out 	std_logic;
       dadoOut 	: out std_logic_vector(511 downto 0)
  );
end component;

component UC_CACHEI is
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
end component;

component UC_CACHED is
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
end component;

component UC_MP is
	port(
		 CLK	  : in STD_LOGIC;
		 MenableD : in STD_LOGIC;
		 MenableI : in STD_LOGIC;
		 OvfO     : in STD_LOGIC;
		 Sel 	  : out STD_LOGIC_VECTOR (1 DOWNTO 0)
	     );
end component;	

component Mux_4x1_16b is
	 port(
		 E0 : in STD_LOGIC_VECTOR(15 downto 0);
		 E1 : in STD_LOGIC_VECTOR(15 downto 0);
		 E2 : in STD_LOGIC_VECTOR(15 downto 0);
		 E3 : in STD_LOGIC_VECTOR(15 downto 0);	 
		 sel : in  std_logic_vector(1 downto 0);		 
		 S : out STD_LOGIC_VECTOR(15 downto 0)
	     );
end component;

component Mux_2x1_1b is --declaração da entidade
port (	E0,E1: in  std_logic; -- entradas
		sel			: in  std_logic;
		S			: out std_logic);-- saida
end component;

signal MeI, RWI, HitI, RdCI : std_logic;
signal MeD, OvfI, RWD, RWD_M, HitD, OvfO, RdCD : std_logic;
signal EnderBuffer, EnderM, EnderMI, EnderMD : std_logic_vector(15 downto 0);
signal MeM, MeMI, MeMD, RWM, RdM : std_logic;
signal DadosMem, DadosBuffer : std_logic_vector(511 downto 0);	
signal Sel : std_logic_vector(1 downto 0);

begin  
	EnderMI <= EnderI(15 downto 6) & "000000";
	EnderMD <= EnderD(15 downto 6) & "000000";
	
	CI : Cache_Inst port map (MeI, EnderI, DadosMem, RWI, DadosOutI, HitI, RdCI);
	UCI: UC_CACHEI port map (CLK, HitI, MenablePI, RdCI, RdM, MeI, RWI, MeMI, ReadyI); 
	CD : Cache_dados port map (MeD, OvfI, RWD, RWD_M, EnderD, DadosInD, DadosMem, DadosBuffer, EnderBuffer, DadosOutD, HitD, OvfO, RdCD, v1,v2,v3,v4,v5);
	UCD: UC_CACHED port map (CLK, HitD, RWDP, MenablePD, RdCD, OvfO, RdM, RWD, MeD, ReadyD, RWD_M, RWM, OvfI, MeMD);
	M_p: Mp port map (MeM, RWM, EnderM, DadosBuffer, RdM, DadosMem);
	UCMP: UC_MP port map (CLK, MeMD, MeMI, OvfO, Sel);
	
	MuxMe: Mux_2x1_1b port map (MeMI, MeMD, Sel(0), MeM);
	MuxEnd: Mux_4x1_16b port map (EnderMI, EnderMD, x"0000", EnderBuffer, Sel, EnderM);

end estrutural;