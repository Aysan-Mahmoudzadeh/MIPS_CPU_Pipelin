library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ALUCtr is
	port ( ALUOp : in STD_LOGIC_VECTOR ( 1 downto 0);
		   Instr : in STD_LOGIC_VECTOR ( 5 downto 0);
		   ALUCtrol : out STD_LOGIC_VECTOR ( 2 downto 0));
end ALUCtr;


architecture Behavioral of ALUCtr is
	begin
	
		ALUCtrol(2) <= ALUOp(0) OR (ALUOp(1) AND Instr(1));
		ALUCtrol(1) <= (NOT ALUOp(1)) OR (NOT Instr(2));
		ALUCtrol(0) <= (ALUOp(1) AND Instr(0)) OR (ALUOp(1) AND Instr(3));
end Behavioral;