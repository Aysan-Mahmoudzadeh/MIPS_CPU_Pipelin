LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
entity Shift_Left is
	port ( 
	       input  :in STD_LOGIC_VECTOR (31 downto 0);
		     output  :out STD_LOGIC_VECTOR (31 downto 0)
		    );
end Shift_Left;

architecture Behavioral of Shift_Left is

	begin
		output <= STD_LOGIC_VECTOR (unsigned(input) sll 2);--word is 4bit and input is 32 then 2word should shift
end Behavioral;