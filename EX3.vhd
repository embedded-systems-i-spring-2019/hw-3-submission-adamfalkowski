-- Excersize 3
library IEEE;
use IEEE.std_logic_1164.ALL;

--entity declaration for 2 to 1 MUX------------------------------------------------
entity mux_2t1 is
  port(
      X,Y : in std_logic_vector(7 downto 0);
      mux_out : out std_logic_vector(7 downto 0)
      SEL : in std_logic;
       );
end mux_2t1;
  
--architecture declaration for 2 to 1 mux--------------------------------------------
architecture mux_2t1_arc of mux_2t1 is
  begin
    process(SEL)
      begin
        if (SEL = '0') then
          mux_out <= X;
        elseif (SEL = '1') then
          mux_out <= Y;
        else 
          mux_out <= '0';
        end if;
     end process;
end mux_2t1_arc;
          
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
 
entity crk_ex3 is
  port(
        LDB,LDA,S0,S1,CLK : in std_logic;
        X,Y : in std_logic_vector(7 downto 0);
        RB : out std_logic_vector (7 downto 0)
       );
end crk_ex3;
  
    

