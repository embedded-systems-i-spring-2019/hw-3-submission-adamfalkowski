-- Excersize 6
library IEEE;
use IEEE.std_logic_1164.ALL;

--entity declaration for 2 to 1 MUX------------------------------------------------
entity mux_2t1 is
  port(
      X,Y : in std_logic_vector(7 downto 0);
      mux_out : out std_logic_vector(7 downto 0);
      SEL : in std_logic
       );
end mux_2t1;
--architecture declaration for 2 to 1 mux--------------------------------------------
architecture mux_2t1_arc of mux_2t1 is
  begin
    with SEL select
        mux_out <= X when '1',
                   Y when '0',
                   (others => '0') when others;
end mux_2t1_arc;

library IEEE;
use IEEE.std_logic_1164.ALL;     
     
--entity declaration for register----------------------------------------------------
entity reg is
  port( R_in: in std_logic_vector(7 downto 0);
        CLK: in std_logic;
        LD: in std_logic;
        R_out: out std_logic_vector (7 downto 0)); 
end reg;
  
--architecture declaration for register-----------------------------------------------
architecture reg_arc of reg is
  begin
    reg_prc: process(CLK)
    begin
       if (rising_edge(CLK)) then
         if (LD = '1') then
           R_out <= R_in;
         end if;
       end if;
    end process;
end reg_arc;    

library IEEE;
use IEEE.std_logic_1164.ALL;

--entity declaration for decoder----------------------------------------------------
entity decoder1t2 is
      port( DS: in std_logic;
           D1: out std_logic;
           D2: out std_logic);
end decoder1t2;

    
--architecture for decoder-----------------------------------------------------------
architecture decoder1t2_arc of decoder1t2 is 
    begin
      process(DS) 
      begin
       case DS is
            when '0' => 
                        D1 <= '1';
                        D2 <= '0';
            when '1' =>
                        D1 <= '0';
                        D2 <= '1';
            when others =>
                        D1 <= '0';
                        D2 <= '0';
        
        end case;
       end process;   
end decoder1t2_arc; 

library IEEE;
use IEEE.std_logic_1164.ALL;
      
--entity declaration for crk_ex6----------------------------------------------------- 
entity crk_ex6 is
  port(
        SEL1, SEL2, CLK: in std_logic;
        A,B,C : in std_logic_vector(7 downto 0);
        RAP,RBP : out std_logic_vector (7 downto 0)
       );
end crk_ex6;

architecture crk_ex6_arc of crk_ex6 is
  --component declaration
  component mux_2t1
    port( 
          x,y : in std_logic_vector(7 downto 0);
          SEL : in std_logic;
          mux_out: out std_logic_vector(7 downto 0)
         );
    end component;
  
   component reg
    port( 
        R_in : in std_logic_vector(7 downto 0);
        CLK,LD : in std_logic;
        R_out: out std_logic_vector (7 downto 0)); 
  end component;
  
     component decoder1t2
        port(
            DS: in std_logic;
            D1,D2 :out std_logic
            );
    end component;
    
  --intermediate signal declarations
  signal mux_result : std_logic_vector(7 downto 0);
  signal d_out1,d_out2 : std_logic;
  
   begin
    Mux1_2_to_1: mux_2t1
                        port map (
                                    x => A,
                                    y => B,
                                    SEL => SEL1,
                                    mux_out => mux_result
                                  );
     decoder:decoder1t2
                        port map (
                                  DS =>SEL2,
                                  D1 => d_out1,
                                  D2=> d_out2
                                  );
   
     REGA: reg
                        port map (
                                    R_in => mux_result,
                                    CLK => CLK,
                                    LD => d_out1,
                                    R_out => RAP
                                  );
      REGB: reg
                        port map (
                                    R_in => C,
                                    CLK => CLK,
                                    LD => d_out2,
                                    R_out => RBP
                                  );   
 
      
 end crk_ex6_arc; 
