LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mux is
	port ( 
	  	    reg : in STD_LOGIC;
	       inputA : in STD_LOGIC_VECTOR (31 downto 0);
		     inputB : in STD_LOGIC_VECTOR (31 downto 0);
		     output : out STD_LOGIC_VECTOR (31 downto 0)
		    );
end Mux;

architecture Behavioral of Mux is
	begin
	output <= inputB when reg='1' else
			inputA;
end Behavioral;