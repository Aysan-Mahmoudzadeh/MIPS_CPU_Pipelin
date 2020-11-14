LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY singlecyclecpu_tb  IS 
END ; 
 
ARCHITECTURE singlecyclecpu_tb_arch OF singlecyclecpu_tb IS
  ----Output Signal
 -- SIGNAL instruction   :  std_logic_vector (31 downto 0) := X"00000000" ;
  ----Input Signal 
  SIGNAL clk   :  STD_LOGIC := '0' ; 
  SIGNAL reset   :  STD_LOGIC :='0' ; 
  
  COMPONENT SingleCycleCPU  
    PORT ( 
            clk  : in STD_LOGIC ; 
            reset  : in STD_LOGIC
         --   instruction  : out std_logic_vector (31 downto 0) 
         ); 
  END COMPONENT ; 
  
  constant clk_period : time := 10 ns;
  
BEGIN
  DUT  : SingleCycleCPU  
    PORT MAP ( 
      --instruction   => instruction  ,
      clk   => clk  ,
      reset   => reset   ) ; 
  ------CLK_PROCESS---    
  clk_process : process
    begin
      clk <= '0';
      wait for clk_period /2;
      clk <= '1';
      wait for clk_period /2;
  end process;
  ---Simulus process
  stim_proc : process
    begin
      reset <= '1';
      wait for 10 ns;
      reset <= '0';
      wait for clk_period*10;
      
      wait;
    end process;

END ; 

