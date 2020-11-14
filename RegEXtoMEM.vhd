library ieee;
use ieee.std_logic_1164.all;
Entity RegEXtoMEM is
    
    Port (clk           : in std_logic;
	      reset  :in STD_LOGIC;
		  MemToReg   : in std_logic; 
          RegWrite   : in std_logic; 
		   MemRead  : in STD_LOGIC;
		  MemWrite : in STD_LOGIC;
		  BranchNE : in STD_LOGIC;
		   Branch   : in STD_LOGIC;
		   
		    PcBranchM     : in std_logic_vector(31 downto 0);
		   AluOutM       : in std_logic_vector(31 downto 0);
          ZeroM         : in std_logic;
            WriteRegM     : in std_logic_vector(4 downto 0);  --khorojie Mux
          WriteDataM    : in std_logic_vector(31 downto 0);--read data 2
        
        
		   Out_MemToReg   : out std_logic; 
          Out_RegWrite   : out std_logic; 
		   Out_MemRead  : out STD_LOGIC;
		  Out_MemWrite : out STD_LOGIC;
		  Out_BranchNE : out STD_LOGIC;
		   Out_Branch   : out STD_LOGIC;
		  outPcBranchM     : out std_logic_vector(31 downto 0);
		  outAluOutM       : out std_logic_vector(31 downto 0);
          outZeroM         : out std_logic;
          outWriteRegM     : out std_logic_vector(4 downto 0);
		   outWriteDataM    : out std_logic_vector(31 downto 0)
        );  
    End;

Architecture behav of RegEXtoMEM is
    begin
        process( clk , reset )
			begin
				if reset='1' then
				
				
				Out_MemToReg<='0';
				Out_RegWrite<='0';
				Out_MemRead<='0';
				Out_MemWrite<='0';
				 Out_BranchNE<='0';
				 Out_Branch<='0';
				  outPcBranchM <= X"00000000";
				  outAluOutM <= X"00000000";
				 outZeroM <= '0';
             outWriteRegM <= "00000";
            outWriteDataM <= X"00000000";
   
		
        elsif( clk'event and clk = '0') then
            Out_MemToReg<= MemToReg;
            Out_RegWrite<= RegWrite;
            Out_MemRead <=MemRead;
            Out_MemWrite <= MemWrite;
			Out_BranchNE<=BranchNE;
			Out_Branch<=Branch;
			 outPcBranchM <= PcBranchM;
			 outAluOutM <= AluOutM;
            outZeroM <= ZeroM;
            outWriteRegM <= WriteRegM;
            outWriteDataM <= WriteDataM;
            
           
        end if;
        end process;
    end;