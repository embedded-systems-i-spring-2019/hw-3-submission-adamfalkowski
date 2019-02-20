--excersize 2 (using structural modeling)

library IEEE;
use IEEE.std_logic_1164.ALL;

--entity declaration for 4:1 MUX
entity mux4t1 is
  port( A,B,C,D : in std_logic_vector(7 downto 0);
       MS : in std_logic_vector (1 downto 0);
       mux_out : out std_logic_vector (7 downto 0));
  end mux4t1;
  
  --architecture of 4:1 MUX
  architecture mux4t1_arc of mux4t1 is
    begin 
      with MS select
      mux_out <= A when "00",
                 B when "01",
                 C when "10",
                 D when "11",
                  (others => '0') when others;
    end mux4t1_arc;
    
    --entity declaration for 1:2 decoder
    entity decoder1t2 is
      port( DS: in std_logic;
           D1: out std_logic;
           D2: out std_logic);
      end decoder1t2;
      
      --architecture for decoder
      architecture decoder1t2_arc of decoder1t2 is 
        begin
          case DS is
            when "0" => 
                        D1 <= "1";
                        D2 <= "0";
            when "1" =>
                        D1 <= "0";
                        D2 <= "1";
            when others =>
                        D1 <= "0";
                        D2 <= "0";
          end case;
            
        
       
          
        
           
           
    
    
    
       


