library IEEE;
library std;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_arith.all;
entity SingleCycleCPU is
	port( 
	       clk : in STD_LOGIC;
			   reset : in STD_LOGIC
			 );
end SingleCycleCPU;

architecture Structural of SingleCycleCPU is

	component ControlUnit is
		port ( 
	       OPcode : in STD_LOGIC_VECTOR( 5 downto 0);
		     RegDst : out STD_LOGIC;
		     ALUSrc : out STD_LOGIC;
		     MemToReg : out STD_LOGIC;
		     RegWrite : out STD_LOGIC;
		     MemRead  : out STD_LOGIC;
		     MemWrite : out STD_LOGIC;
		--     Jump : out STD_LOGIC;
		     BranchNE : out STD_LOGIC;
		     Branch   : out STD_LOGIC;
		     ALUOp  : out STD_LOGIC_VECTOR( 1 downto 0)
		     );
	end component;
--	for CtrlUnit : ControlUnit use entity work.ControlUnit;
	
	component ALUCtr is
		port (
		       ALUOp : in STD_LOGIC_VECTOR ( 1 downto 0);
		       Instr : in STD_LOGIC_VECTOR ( 5 downto 0);
		       ALUCtrol : out STD_LOGIC_VECTOR ( 2 downto 0)
		       );
    end component;
--	for ALUControl : ALUCtrl use entity work.ALUCtrl;
	
	component ALU is
	port ( Data1 : in STD_LOGIC_VECTOR ( 31 downto 0);
		   Data2 : in STD_LOGIC_VECTOR ( 31 downto 0);
		   Zero : out STD_LOGIC;
		   ALU_Result : out STD_LOGIC_VECTOR ( 31 downto 0);
		   ALUCtrol : in STD_LOGIC_VECTOR ( 2 downto 0)
		   ); --and/or/nand/mul/...
    end component;
	
	component Sign_Extend is
	port ( 
	       input : in STD_LOGIC_VECTOR (15 downto 0);
	       output : out STD_LOGIC_VECTOR (31 downto 0)
	      );
    end component;
--	for Sign_Extended1 : Sign_Extend use entity work.Sign_Extend;
	
	component Ram is
		generic (
			       	ADDR_WIDTH : integer := 32;
			       	DATA_WIDTH : integer := 32
			       );
	
	port (  
	       MemWrite : in STD_LOGIC;
		     MemRead : in STD_LOGIC;
	       clk : in STD_LOGIC;
	       reset : in STD_LOGIC;
		     address : in STD_LOGIC_VECTOR( ADDR_WIDTH-1 downto 0);
		     din : in STD_LOGIC_VECTOR( DATA_WIDTH-1 downto 0);
		     dout : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
		   
		   );
    end component;
--	for Ram1 : Ram use entity work.Ram;
    
    component Register_File IS
		PORT(
	       clk, reset, reg_write : IN STD_LOGIC; 
	       write1, read1, read2 : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	       write_data : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	       read_data1, read_data2 : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 )
		);
	END component;
--	for RegFile : Register_File use entity work.Register_File;

	component Mux is
		port (
		        InputA , InputB : in STD_LOGIC_VECTOR(31 downto 0);
				    sel : in STD_LOGIC;
				    Output : out std_logic_vector(31 downto 0)
				  );
	end component;
--	for BranchMux : Mux use entity work.Mux;
--	for MuxAlu : Mux use entity work.Mux;
--	for MuxRam : Mux use entity work.Mux;
	
	component BinaryMUX is
    Port ( inputA : in  STD_LOGIC_VECTOR (4 downto 0);
           inputB : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 downto 0));
    end component;
--	for MuxReg : BinaryMUX use entity work.BinaryMUX;
	
	component program_counter is
		port ( 
		    	reset : in STD_LOGIC;
			    clk : in STD_LOGIC;
		        input : in STD_LOGIC_VECTOR (31 downto 0);
			    output : out STD_LOGIC_VECTOR ( 31 downto 0)
			    );
	end component;
--	for Pc : program_counter use entity work.program_counter;
	
	component InstrMem32bit is
		port ( 
		        address :in STD_LOGIC_VECTOR ( 31 downto 0);
				    Instr : out STD_LOGIC_VECTOR (31 downto 0)
			  	);
	end component;
--	for InstrMem : InstrMem32bit use entity work.InstrMem32bit;

	
	component Adder is
		port ( 
		        num1 : in STD_LOGIC_VECTOR (31 downto 0);
			      num2 : in STD_LOGIC_VECTOR (31 downto 0);
			      result : out STD_LOGIC_VECTOR (31 downto 0)
			    );
	end component;
--	for pc_adder : Adder use entity work.Adder;
--	for Branch_Adder : Adder use entity work.Adder;
	
	component Left_Shift is
		port ( 
		        input : in STD_LOGIC_VECTOR (31 downto 0);
		        output : out STD_LOGIC_VECTOR (31 downto 0)
		       );
	end component;
	
	component RegIFtoID is

    Port ( 	reset  :in STD_LOGIC;
			clk    : in std_logic;
			instruction : in std_logic_vector(31 downto 0);
			pcplus4     : in std_logic_vector(31 downto 0);
			instr_out   : out std_logic_vector(31 downto 0);
			pc_out      : out std_logic_vector(31 downto 0)
		);
    End component;
--	for Regpip1 : RegIFtoID use entity work.RegIFtoID;
	
	component RegIDtoEX is
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
		  outALUctr   : out std_logic_vector(5 downto 0)
		);
    End component;
--	for Regpip2 : RegIDtoEX use entity work.RegIDtoEX;
	
	component RegEXtoMEM is
    Port (  clk    : in std_logic;
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
    End component;
--	for Regpip3 : RegEXtoMEM use entity work.RegEXtoMEM;
   
   component RegMEMtoWB is
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
          outWriteRegW   : out std_logic_vector(4 downto 0)
		  );
		  end component;
	--	  for Regpip4 : RegMEMtoWB use entity work.RegMEMtoWB;
	
	-- IF signal
	signal instrD : std_logic_vector(31 downto 0);
	signal pcplus4D : std_logic_vector(31 downto 0);
	signal branchMux_output : STD_LOGIC_VECTOR (31 downto 0);
	signal pc_output :STD_LOGIC_VECTOR (31 downto 0);
	signal pc_adder_output :STD_LOGIC_VECTOR (31 downto 0);
    signal branch_adder_output : STD_LOGIC_VECTOR (31 downto 0);
	signal branch_bool : std_logic;
	--signal branchMux_output : STD_LOGIC_VECTOR (31 downto 0);
	signal InstrMemOut : STD_LOGIC_VECTOR (31 downto 0);
	-- ID signal
	signal Sign_Extended_Output : std_logic_vector(31 downto 0);
	signal OPcode : STD_LOGIC_VECTOR( 5 downto 0);
	signal ALUOP : std_logic_vector ( 1 downto 0);
	signal RegDst : STD_LOGIC;
	signal ALUSrc : STD_LOGIC;
	signal MemToReg : STD_LOGIC;
	signal RegWrite : STD_LOGIC;
	signal MemRead  : STD_LOGIC;
	signal MemWrite : STD_LOGIC;
	signal branchFromCtrlUnit : std_logic;
	signal branchNEFromCtrlUnit : std_logic;
	signal WriteData : std_logic_vector(31 downto 0);
	signal WriteAddr : std_logic_vector(4 downto 0);	
	signal RegData1 : std_logic_vector(31 downto 0);
	signal RegData2 : std_logic_vector(31 downto 0);
	signal Sign_Extended_OutputE : std_logic_vector(31 downto 0);
	signal ALUOPE : STD_LOGIC_VECTOR( 1 downto 0);
	signal RegDstE : STD_LOGIC;
	signal ALUSrcE : STD_LOGIC;
	signal MemToRegE : STD_LOGIC;
	signal RegWriteE : STD_LOGIC;
	signal MemReadE  : STD_LOGIC;
	signal MemWriteE : STD_LOGIC;
	signal branchFromCtrlUnitE : std_logic;
	signal branchNEFromCtrlUnitE : std_logic;
	signal RegData1E : std_logic_vector(31 downto 0);
	signal RegData2E : std_logic_vector(31 downto 0);	
	signal pcplus4E : std_logic_vector(31 downto 0);
	signal instrE : std_logic_vector(20 downto 0);
	
	-- EX
	signal MuxAlu_out : std_logic_vector(31 downto 0);
	signal ALUCtrol : std_logic_vector( 2 downto 0);
	signal ALU_Result : std_logic_vector(31 downto 0);
	signal MemToRegM :  std_logic; 
	signal RegWriteM :  std_logic;
	signal MemReadM :  STD_LOGIC;
	signal MemWriteM :  STD_LOGIC;
	signal branchFromCtrlUnitM :  STD_LOGIC;
	signal branchNEFromCtrlUnitM :  STD_LOGIC;
	signal pcBranchM :  std_logic_vector(31 downto 0);
	signal ALUOutM :  std_logic_vector(31 downto 0);
	signal ZeroM :  STD_LOGIC;
	signal WriteRegM :  std_logic_vector(4 downto 0);
	signal WriteDataM :  std_logic_vector(31 downto 0);
	
	--MEM
	signal  RegWriteW :  std_logic;
    signal  MemtoRegW :  std_logic;
    signal  ReadDataW :  std_logic_vector(31 downto 0);
    signal  AluOutW   :  std_logic_vector(31 downto 0);
    signal  WriteRegW :  std_logic_vector(4 downto 0);
	signal Zero : std_logic;
	signal RamDataOut : std_logic_vector(31 downto 0);

	
begin
	-- IF
	Pc : program_counter port map ( reset , clk, branchMux_output , pc_output);
	pc_adder : Adder port map ( pc_output , X"00000001" , pc_adder_output );
	BranchMux : Mux port map ( pc_adder_output, PcBranchM,  branch_bool ,  branchMux_output);
	InstrMem : InstrMem32bit port map (pc_output , InstrMemOut);
	Regpip1 : RegIFtoID port map ( reset, clk, InstrMemOut, pc_adder_output, instrD, pcplus4D );
	
	--ID
	Sign_Extended1 : Sign_Extend port map (instrD(15 downto 0) , Sign_Extended_Output);
	OPcode <= instrD(31 downto 26);
	CtrlUnit : ControlUnit port map ( OPcode  , RegDst ,ALUSrc , MemToReg , RegWrite , MemRead , MemWrite  , branchNEFromctrlUnit , branchFromctrlUnit , ALUOP);
   	RegFile : Register_File port map( clk, reset, RegWriteW , WriteRegW ,instrD(25 downto 21)  , instrD(20 downto 16), WriteData, RegData1,RegData2 );
	Regpip2 : RegIDtoEX port map ( clk, reset, RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, branchNEFromctrlUnit,branchFromctrlUnit,
    	ALUOp, PCPlus4D,RegData1,RegData2, Sign_Extended_Output,instrD(20 downto 16) ,instrD(15 downto 11),instrD(5 downto 0) 
	    , RegDstE, ALUSrcE, MemToRegE, RegWriteE, MemReadE, MemWriteE,branchNEFromctrlUnitE,branchFromctrlUnitE, ALUOPE,RegData1E,
		RegData2E,instrE(20 downto 16) ,instrE(15 downto 11), Sign_Extended_OutputE, PCPlus4E,instrE(5 downto 0));    
		
	instrE(10 downto 6)<="00000";
	
	-- EX
	MuxReg : BinaryMUX port map(instrE(20 downto 16),instrE(15 downto 11),RegDstE, WriteAddr);
	MuxAlu : Mux port map ( RegData2E, Sign_Extended_OutputE, ALUSrcE, MuxAlu_out);
	ALUControl : ALUCtr port map ( ALUOpE , instrE(5 downto 0) , ALUCtrol);
	Branch_Adder : Adder port map ( Sign_Extended_OutputE, PCPlus4E, branch_adder_output);
	ALUMain : ALU port map ( RegData1E, MuxAlu_out, Zero, ALU_Result, ALUCtrol);
	Regpip3 : RegEXtoMEM port map ( clk,reset,MemToRegE,RegWriteE,MemReadE,MemWriteE,branchNEFromCtrlUnitE,branchFromCtrlUnitE,branch_adder_output,
	      ALU_Result,Zero,WriteAddr,RegData2E,MemToRegM,RegWriteM,MemReadM,MemWriteM,branchNEFromCtrlUnitM,branchFromCtrlUnitM,PcBranchM,
		  ALUOutM,ZeroM,WriteRegM,WriteDataM);
	
	-- MEM
	branch_bool <= (branchNEFromCtrlUnitM AND Zero) Or (branchFromCtrlUnitM AND not Zero);
	Ram1 : Ram port map ( MemWriteM, MemReadM , clk , reset , ALUOutM, WriteDataM, RamDataOut);
	Regpip4 : RegMEMtoWB port map(clk , reset,RegWriteM,MemToRegM,RamDataOut,ALUOutM,WriteRegM,RegWriteW,MemtoRegW,ReadDataW,AluOutW,WriteRegW);
	
	-- WB
	MuxRam : Mux port map ( AluOutW, ReadDataW, MemtoRegW, WriteData);
	
end Structural;	
	

