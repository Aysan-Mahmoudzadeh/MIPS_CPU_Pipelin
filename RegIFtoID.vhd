library ieee;
use ieee.std_logic_1164.all;
Entity RegIFtoID is
  
    Port ( 	reset  :in STD_LOGIC;
	   clk         : in std_logic;
	instruction : in std_logic_vector(31 downto 0);
          pcplus4     : in std_logic_vector(31 downto 0);

          instr_out   : out std_logic_vector(31 downto 0);
          pc_out      : out std_logic_vector(31 downto 0));
    End;

Architecture behav of RegIFtoID is
    begin
        process(clk,reset)
        begin
          
				if reset='1' then
				    instr_out <= X"00000000";
					 pc_out <= X"00000000";
				 elsif( clk'event and clk = '0') then
                instr_out <= instruction;
                pc_out <= pcplus4;
            end if;
        end process;
    end;