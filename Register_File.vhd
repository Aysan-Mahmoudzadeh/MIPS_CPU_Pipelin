LIBRARY IEEE;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

ENTITY Register_File IS
  PORT(
	       clk, reset, reg_write : IN STD_LOGIC; 
	       write1, read1, read2 : IN STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	       write_data : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	       read_data1, read_data2 : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 )
      );
END ENTITY Register_File ;

ARCHITECTURE Register_File_arch OF Register_File  IS
  TYPE register_file_type IS ARRAY ( 0 TO 31 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );
  SIGNAL register_file_next , register_file_reg : register_file_type;
BEGIN

	PROCESS( clk, reset )
		begin	
			IF ( reset = '1' ) THEN
				FOR i IN 0 TO 31 LOOP
					register_file_reg <= ( OTHERS => (others => '0') );
				END LOOP;
			ELSIF RISING_EDGE( clk ) THEN
			register_file_reg <= register_file_next;
				IF ( reg_write = '1' ) THEN
					register_file_reg(TO_INTEGER(UNSIGNED(write1))) <= write_data;
				end  if;
			end if;
	end process;
	
	process ( reg_write, write_data, register_file_reg)
	begin
		  register_file_next <= register_file_reg; 
				if (reg_write = '1') then
		    register_file_next(TO_INTEGER(UNSIGNED(write1))) <= write_data;
		else 
			register_file_next <= register_file_reg;
		  end if;
	end process;
	read_data1 <= register_file_reg(TO_INTEGER(UNSIGNED(read1))); -- read1 va read2 tarkibi ast pas hasas nist o niazi nist to list hasasiat gozasht
	read_data2 <= register_file_reg(TO_INTEGER(UNSIGNED(read2)));

end;



