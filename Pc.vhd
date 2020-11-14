LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity program_counter is
	port (  
	  		   	reset  :in STD_LOGIC;
			    clk	   :in STD_LOGIC;
	        input  :in STD_LOGIC_VECTOR (31 downto 0);
			    output :out STD_LOGIC_VECTOR (31 downto 0)
			  );
end program_counter;
architecture Behavioral of program_counter is

	begin

		process( clk , reset )
			begin
				if reset='1' then
				    output <= X"00000000";
				elsif rising_edge (clk) then
				    output <= input;
				end if;
		end process;

	end Behavioral;