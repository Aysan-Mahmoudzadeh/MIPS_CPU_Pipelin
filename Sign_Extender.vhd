LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity Sign_Extend is
	port ( 
	       input : in STD_LOGIC_VECTOR (15 downto 0);
	       output : out STD_LOGIC_VECTOR (31 downto 0)
	      );
end Sign_Extend;

architecture Behavioral of Sign_Extend is
	begin
		output <= std_logic_vector (resize(signed(input) , output'length));
end Behavioral;