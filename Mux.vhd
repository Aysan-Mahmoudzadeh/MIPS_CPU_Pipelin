library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux is
--		generic (
--			         	DATA_WIDTH : integer := 32
--			       );
		port ( 
		        InputA , InputB : in STD_LOGIC_VECTOR(31 downto 0);
				    sel : in STD_LOGIC;
				    Output : out std_logic_vector(31 downto 0)
				  );
				
end Mux;

Architecture Behavioral of Mux is
begin

	output <= inputB when sel='1' else
				 inputA;

end Behavioral; 