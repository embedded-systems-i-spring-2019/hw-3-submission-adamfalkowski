--excersize 1 (using behavior modeling)

library IEEE;
use IEEE.std_logic_1164.all;

-- entity declaration
entity crk1 is 
port(A,B : in std_logic_vector(7 downto 0);
	LDA,SEL,CLK : in std_logic;
	F : out std_logic_vector(7 downto 0));
end crk1;

--architecture decleration
architecture crk1_arc of crk1 is
	signal mux_result :std_logic_vector(7 downto 0);
begin

	ra: process(CLK) 
	begin
		if (rising_edge(CLK)) then
			if (LDA = '1') then
				F <= mux_result;
			end if;
		end if;
	end process;

	with SEL select
	mux_result <= A when '0', B when '1', (others => '0') when others;
end crk1_arc;
