-- Excersize 4
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
       if (falling_edge(CLK)) then
         if (LD = '1') then
           R_out <= R_in;
         end if;
       end if;
    end process;
end reg_arc;    

library IEEE;
use IEEE.std_logic_1164.ALL;
      
--entity declaration for crk_ex4----------------------------------------------------- 
entity crk_ex4 is
  port(
        LDB,LDA,S0,S1,CLK,RD : in std_logic;
        X,Y : in std_logic_vector(7 downto 0);
        RB,RA : out std_logic_vector (7 downto 0)
       );
end crk_ex4;

architecture crk_ex4_arc of crk_ex4 is
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
  --intermediate signal declarations
  signal mux_result_1, mux_result_2, REGA_result, REGB_result : std_logic_vector(7 downto 0);
  signal and_result_1, and_result_2 : std_logic;
  
   begin
    Mux1_2_to_1: mux_2t1
                        port map (
                                    x => X,
                                    y => Y,
                                    SEL => S1,
                                    mux_out => mux_result_1
                                  );
     Mux2_2_to_1: mux_2t1
                        port map (
                                    x => REGB_result,
                                    y => Y,
                                    SEL => S0,
                                    mux_out => mux_result_2
                                  );
     REGA: reg
                        port map (
                                    R_in => mux_result_2,
                                    CLK => CLK,
                                    LD => and_result_2,
                                    R_out => RA
                                  );
      REGB: reg
                        port map (
                                    R_in => mux_result_1,
                                    CLK => CLK,
                                    LD => and_result_1,
                                    R_out => REGB_result
                                  );   
     and_result_1 <= LDB AND (NOT RD);
     and_result_2 <= LDA AND RD;
      RB <= REGB_result;
      
 end crk_ex4_arc; 
