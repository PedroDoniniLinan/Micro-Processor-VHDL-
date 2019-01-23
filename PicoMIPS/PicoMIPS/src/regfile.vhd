library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all; 	
use IEEE.STD_LOGIC_ARITH.all;

entity RegFile is  
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
end RegFile;
		
architecture comportamental of RegFile is
begin
	process (ReadReg1, ReadReg2, WriteReg, RegWrite, Reset, Clk)
		type rede_reg is array (0 to 31) of std_logic_vector (31 downto 0); --Conjunto de 32 registradores de 32 bits
		variable regfile: rede_reg := (others => (others => '0'));
		begin
			if (Reset = '1') then 
				regfile(0) := (others => '0');
				regfile(1) := (others => '0');
				regfile(2) := (others => '0');
				regfile(3) := (others => '0');
				regfile(4) := (others => '0');
				regfile(5) := (others => '0');
				regfile(6) := (others => '0');
				regfile(7) := (others => '0');
			elsif (RegWrite = '1' and Clk'event and Clk = '0') then
				regfile(conv_integer(WriteReg)) := WriteData;
			end if;
			ReadData1 <= regfile(conv_integer(ReadReg1));
			ReadData2 <= regfile(conv_integer(ReadReg2));
	end process;
end comportamental;
