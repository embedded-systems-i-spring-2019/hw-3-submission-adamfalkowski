-- Excersize 3
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
        mux_out <= X when '0',
                   Y when '1',
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
      
--entity declaration for crk_ex3----------------------------------------------------- 
entity crk_ex3 is
  port(
        LDB,LDA,S0,S1,CLK : in std_logic;
        X,Y : in std_logic_vector(7 downto 0);
        RB : out std_logic_vector (7 downto 0)
       );
end crk_ex3;
  
architecture crk_ex3_arc of crk_ex3 is
  --component declaration
  component mux2t1
    port( 
          A,B : in std_logic_vector(7 downto 0);
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
  --intermediate signal declarations
  signal mux_result_1, mux_result_2, REGA_result, REGB_result : std_logic_vector(7 downto 0);
  begin
    Mux1_2_to_1: mux2t1
                        port map (
                                    A => X,
                                    B => REGB_result,
                                    SEL => S0,
                                    mux_out => mux_result_1
                                  );
     Mux2_2_to_1: mux2t1
                        port map (
                                    A => REGA_result,
                                    B => Y,
                                    SEL => S1,
                                    mux_out => mux_result_2
                                  );
     REGA: reg
                        port map (
                                    R_in => mux_result_1,
                                    CLK => CLK,
                                    LD => LDA,
                                    R_out => REGA_result
                                  );
      REGB: reg
                        port map (
                                    R_in => mux_result_2,
                                    CLK => CLK,
                                    LD => LDB,
                                    R_out => REGB_result
                                  );   
      RB <= REGB_result;
 end crk_ex3_arc; 
         
