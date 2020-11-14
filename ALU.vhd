library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ALU is
	port ( Data1 : in STD_LOGIC_VECTOR ( 31 downto 0);
		   Data2 : in STD_LOGIC_VECTOR ( 31 downto 0);
		   --Sign_Extended : in STD_LOGIC_VECTOR ( 31 downto 0);
		   --ALUSrc : in STD_LOGIC;
		   Zero : out STD_LOGIC;
		   ALU_Result : out STD_LOGIC_VECTOR ( 31 downto 0);
		   ALUCtrol : in STD_LOGIC_VECTOR ( 2 downto 0)
		   ); --and/or/nand/mul/...
end ENTITY;

architecture Behavioral of ALU is

	--SIGNAL A_input , B_input : STD_LOGIC_VECTOR ( 31 downto 0);
	--SIGNAL ALU_output : STD_LOGIC_VECTOR ( 31 downto 0);
SIGNAL ALU_Result_Add, ALU_Result_And, ALU_Result_Or, ALU_Result_Sub , ALU_Result_Slb : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	
begin

	--A_input <= Data1;
	--B_input <= Data2 when ALUStr = '0' else
		--				Sign_Extended;
						
	--Zero <= '1' when (ALU_output = X"00000000") else '0';
	--ALU_Result <= (X"0000000" & "000" & ALU_output(31)) when ALUCtr = "111" else --page 301
		--			ALU_output; 
					
	-- process (ALUCtr , A_input, B_input)
	-- begin
		-- case ALUCtr is
			-- when "000" => ALU_output <= A_input AND B_input;
			-- when "001" => ALU_output <= A_input OR B_input;
			-- when "010" => ALU_output <= A_input + B_input;
			-- when "110" => ALU_output <= A_input - B_input;
			-- when "111" => ALU_output <= A_input - B_input;
			-- when others => ALU_output <=X"00000000";
		-- end case;
	-- end process;
	
	
	
	ALU_Result_Add <= STD_LOGIC_VECTOR( UNSIGNED( Data1 ) + UNSIGNED( Data2 ) );
	ALU_Result_Sub <= STD_LOGIC_VECTOR( UNSIGNED( Data1 ) - UNSIGNED( Data2 ) );
	ALU_Result_And <= Data1 AND Data2;
	ALU_Result_Or <= Data1 OR Data2;
	ALU_Result_Slb <= std_logic_vector( UNSIGNED ( Data1 ) - UNSIGNED ( Data2 ) );
	
	---------------------------------------------------------------------------------
	-----------------The Same Design with some Sequential Statements-----------------
	---------------------------------------------------------------------------------
	-- PROCESS( ALU_Result_Add, ALU_Result_And, ALU_Result_Or, ALU_Result_Sub, ALUCtr  )
		-- BEGIN
			-- IF( ALUCtr = "00" ) THEN
				-- ALU_Result <= ALU_Result_Add;
			-- ELSIF( ALUCtr = "01" ) THEN
				-- ALU_Result <= ALU_Result_Sub;
			-- ELSIF ( ALUCtr = "10" ) THEN
				-- ALU_Result <= ALU_Result_And;
			-- ELSE
				-- ALU_Result <= ALU_Result_Or;
			-- END IF;
		-- END PROCESS;
	---------------------------------------------------------------------------------
	--------------The Same Design with some Combinational Statements-----------------
	---------------------------------------------------------------------------------
	 ALU_Result <= ALU_Result_Add WHEN ALUCtrol = "010" ELSE
				   ALU_Result_Sub WHEN ALUCtrol = "110" ELSE
				   ALU_Result_And WHEN ALUCtrol = "000" ELSE
				   ALU_Result_Or WHEN ALUCtrol = "001" ELSE
				   ALU_Result_Slb WHEN ALUCtrol = "111";
	
	Zero <= '1' WHEN ALU_Result_Sub = X"00000000" ELSE '0';
	
end Behavioral;