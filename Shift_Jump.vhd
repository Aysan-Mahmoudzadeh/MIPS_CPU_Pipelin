LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity Left_shift is
	port (
	        input  :in STD_LOGIC_VECTOR (31 downto 0);
		      output  :out STD_LOGIC_VECTOR (31 downto 0)
		    );
end Left_shift;

architecture Behavioral of Left_shift is

	begin
		--output <= STD_LOGIC_VECTOR (unsigned(input) sll 2);--word is 4bit and input is 32 then 2word should shift
		--input( 29 downto 0 ) & "00";
		output <=  std_logic_vector(unsigned(input) sll 2);
end Behavioral;