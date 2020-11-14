LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity Adder is
	port (
	        num1 : in STD_LOGIC_VECTOR (31 downto 0);
		      num2 : in STD_LOGIC_VECTOR (31 downto 0);
		      result : out STD_LOGIC_VECTOR (31 downto 0)
		    );
end Adder;

architecture Behavioral of Adder is
	begin 
		result <= STD_LOGIC_VECTOR ( unsigned(num1) + unsigned(num2) );
end Behavioral;