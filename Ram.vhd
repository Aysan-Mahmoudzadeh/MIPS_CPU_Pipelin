library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;
entity Ram is
	generic (
				ADDR_WIDTH :integer := 32 ;
				DATA_WIDTH : integer := 32
			);
	
	port ( 
	       MemWrite : in STD_LOGIC;
		     MemRead : in STD_LOGIC;
	       clk : in STD_LOGIC;
	       reset : in STD_LOGIC;
		     address : in STD_LOGIC_VECTOR( ADDR_WIDTH-1 downto 0);
		     din : in STD_LOGIC_VECTOR( DATA_WIDTH-1 downto 0);
		     dout : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
		   
		   );
end Ram;

Architecture Behavioral of Ram is

Type ram_type is array(31 downto 0 ) of STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
signal ram : ram_type := ((others=> (others=>'0')));
signal ram_reg, ram_next : ram_type := (others => (others =>'0'));
signal read_data : std_logic_vector(DATA_WIDTH-1 downto 0 ) := (others => '0');

	begin

	process(clk,reset) --harchi khastim hasas bashe mizarim inja
		begin
			if (reset ='1') then
		--	ram_reg <= (others =>(others =>'0'));
				for i IN 0 TO 31 LOOP
					ram_reg <= (OTHERS => (others => '0'));
				end LOOP;
			elsif rising_edge(clk) then 
			--	if (MemWrite ='1') then
				 ram_reg <= ram_next;
			--		ram_reg(to_integer (unsigned(address))) <= din;
				end if;
		end process;
	
		process(MemWrite, ram_reg, din, MemRead, address)
		begin
			ram_next <= ram_reg;
				if (MemWrite ='1') then
					ram_next(to_integer (unsigned(address))) <= din;
				end if;
				
		--	if (MemRead ='1') then
			--		dout <= ram_reg(to_integer(unsigned(address)));
			--	else --engar mux sakhtim
			--		dout<= (others =>'0');
		--	end if;
		end process;
	
	
	
		
		process(MemRead , address) --vorodio nemishe nevesht va khoroji ham nemishe khond
		begin
			if (MemRead ='1') then
			
	
				dout <= ram(to_integer(unsigned(address)));
			else --engar mux sakhtim
				dout<= (others =>'0');
			end if;
		end process;
 end Behavioral;
	
		
		
	