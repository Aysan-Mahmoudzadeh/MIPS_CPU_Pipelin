library ieee;
use ieee.std_logic_1164.all;
Entity RegMEMtoWB is
   
    Port (clk           : in std_logic;
	       reset  :in STD_LOGIC;
          S_RegWriteW   : in std_logic;  
          S_MemtoRegW   : in std_logic;  
		  
          ReadDataW     : in std_logic_vector(31 downto 0);
          AluOutW       : in std_logic_vector(31 downto 0);
          WriteRegW     : in std_logic_vector(4 downto 0);
		  
          outS_RegWriteW : out std_logic;
          outS_MemtoRegW : out std_logic;
          outReadDataW   : out std_logic_vector(31 downto 0);
          outAluOutW     : out std_logic_vector(31 downto 0);
          outWriteRegW   : out std_logic_vector(4 downto 0));
    End;

Architecture behav of RegMEMtoWB is
    begin
          process( clk , reset )
			begin
				if reset='1' then
		 outS_RegWriteW <= '0';
            outS_MemtoRegW <= '0';
            outAluOutW <= X"00000000";
            outReadDataW <= X"00000000";
            outWriteRegW <= "00000";
        elsif( clk'event and clk = '0') then
            outS_RegWriteW <= S_RegWriteW;
            outS_MemtoRegW <= S_MemtoRegW;
            outAluOutW <= AluOutW;
            outReadDataW <= ReadDataW;
            outWriteRegW <= WriteRegW;
        end if;
        end process;
    end;