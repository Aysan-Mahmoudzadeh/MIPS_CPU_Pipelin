library ieee;
use ieee.std_logic_1164.all;
Entity RegIDtoEX is
    Port (clk           : in std_logic;
	      reset  :in STD_LOGIC;
             RegDst : in STD_LOGIC;
		     ALUSrc : in STD_LOGIC;
		     MemToReg : in STD_LOGIC;
		     RegWrite : in STD_LOGIC;
		     MemRead  : in STD_LOGIC;
		     MemWrite : in STD_LOGIC;
		--     Jump : out STD_LOGIC;
		     BranchNE : in STD_LOGIC;
		     Branch   : in STD_LOGIC;
		     ALUOp  : in STD_LOGIC_VECTOR( 1 downto 0);
			 PCPlus4       : in std_logic_vector(31 downto 0);
			 
		  
          RD1           : in std_logic_vector(31 downto 0);
          RD2           : in std_logic_vector(31 downto 0);
		  SignExt       : in std_logic_vector(31 downto 0);
          RtE           : in std_logic_vector(4 downto 0);
          RdE           : in std_logic_vector(4 downto 0); -- ???
		  ALUctr   : in std_logic_vector(5 downto 0); -- vorodiie alu control
          
         
		  
         Out_RegDst : out STD_LOGIC;
		   Out_ALUSrc : out STD_LOGIC;
		     Out_MemToReg : out STD_LOGIC;
		     Out_RegWrite : out STD_LOGIC;
		     Out_MemRead  : out STD_LOGIC;
		     Out_MemWrite : out STD_LOGIC;
		--     Jump : out STD_LOGIC;
		     Out_BranchNE : out STD_LOGIC;
		     Out_Branch   : out STD_LOGIC;
		     Out_ALUOp  : out STD_LOGIC_VECTOR( 1 downto 0);
		  
          outRD1           : out std_logic_vector(31 downto 0);
          outRD2           : out std_logic_vector(31 downto 0);
          outRtE           : out std_logic_vector(4 downto 0);
          outRdE           : out std_logic_vector(4 downto 0);
          outSignExt       : out std_logic_vector(31 downto 0);
          outPCPlus4       : out std_logic_vector(31 downto 0);
		  outALUctr   : out std_logic_vector(5 downto 0));
    End;

Architecture behav of RegIDtoEX is
    begin
      process( clk , reset )
			begin
				if reset='1' then
				Out_RegDst<='0';
				Out_ALUSrc<='0';
				Out_MemToReg<='0';
				Out_RegWrite<='0';
				Out_MemRead<='0';
				Out_MemWrite<='0';
				 Out_BranchNE<='0';
				 Out_Branch<='0';
				  Out_ALUOp<="00";
				  
				  outRD1 <=X"00000000";
            outRD2 <=X"00000000";
            outRtE <= "00000";
            outRdE <= "00000";
            outSignExt <= X"00000000";
            outPCPlus4 <= X"00000000";
				  outALUctr <= "000000";
				 elsif( clk'event and clk = '0') then
				Out_ALUSrc<=ALUSrc;
				Out_MemToReg<=MemToReg;
				Out_RegWrite<=RegWrite;
				Out_MemRead<=MemRead;
				Out_MemWrite<=MemWrite;
				 Out_BranchNE<=BranchNE;
				 Out_Branch<=Branch;
				  Out_ALUOp<=ALUOp;
          
			
            outRD1 <=RD1;
            outRD2 <=RD2;
            outRtE <= RtE;
            outRdE <= RdE;
            outSignExt <= SignExt;
            outPCPlus4 <= PCPlus4;
			outALUctr<=ALUctr;
        end if;
        end process;
    end;