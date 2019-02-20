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
      process(DS) 
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
       end process;   
end decoder1t2_arc; 

--entity declaration for register
entity reg is
  port( R_in: in std_logic_vector(7 downto 0);
        CLK: in std_logic;
        LD: in std_logic;
        R_out: in std_logic_vector (7 downto 0)); 
end reg;
  
--architecture declaration for register
architecture reg_arc of reg is
  begin
    reg_prc: process(CLK)
    begin
       if (falling_edge(CLK)) then
         if (LD = "1") then
           R_out <= R_in;
         end if;
       end if;
    end process;
end reg_arc;
         
--entity declaration for entire circuit
entity crk_ex2 is
  port(X,Y,Z : in std_logi_vector (7 downto 0);
       DS, CLK : in std_logic;
       MS : in std_logic_vector (1 downto 0);
       RA, RB : out std_logic_vector (7 downto 0));
end crk_ex2;
  
--architecture delacartion for crk_ex2
  
architecture crk_ex2_arc of crk_ex2 is
  --component declaration first
  component mux4t1  --dont need the is keyword
    port( A,B,C,D : in std_logic_vector(7 downto 0);
       MS : in std_logic_vector (1 downto 0);
       mux_out : out std_logic_vector (7 downto 0));
  end component; --end without using name of component
  
  component decoder1t2
    port( DS: in std_logic;
           D1: out std_logic;
           D2: out std_logic);
  end component;
       
  component reg
    port( R_in: in std_logic_vector(7 downto 0);
        CLK: in std_logic;
        LD: in std_logic;
        R_out: in std_logic_vector (7 downto 0)); 
  end component;
  --intermediate signal declaration
  signal mux_result : std_logic_vector(7 donwto 0); --no in or out bc its an intermediate signal
  signal RA_result : std_logic_vector(7 downto 0); -- result of first register to be inputed to the second
  signal RB_result :std_logic_vector(7 downto 0);       
  signal decoder_result_1, decoder_result_2 : std_logic;
          
  begin
    MUX_4_to_1: mux4t1 
                        port map (
                                  A => X,
                                  B => Y,
                                  C => Z,
                                  D => RB_result,
                                  MS => MS,
                                  mux_out => mux_result
                                  );
    Decoder_1_to_2: decoder1t2 
                          portmap (
                                   DS => DS,
                                   D1 => decoder_result_1,
                                   D2 => decoder_result_2
                                   );

   RegisterA: reg
                          portmap (
                                    R_in => mux_result,
                                    CLK => CLK,
                                    LD => decoder_result_2,
                                    R_out => RA_result
                                   );
 RegisterB: reg
                          portmap (
                                    R_in => RA_result,
                                    CLK => CLK,
                                    LD => decoder_result_1
                                    R_out => RB_result
                                   );
RA_result => RA;
RB_result => RB;
end crk_ex2_arc;

           
           
    
    
    
       


