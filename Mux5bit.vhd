library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BinaryMUX is
    Port ( inputA : in  STD_LOGIC_VECTOR (4 downto 0);
           inputB : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (4 downto 0));
end BinaryMUX;

architecture Behavioral of BinaryMUX is

begin

	output <= inputB when sel='1' else
				 inputA;

end Behavioral;

