library IEEE;
use IEEE.std_logic_1164.all;

entity multiplexer is

  port (
    S0   : in  std_logic;
    S1  : in  std_logic;
    B  : in  std_logic_vector(3 downto 0);
    Y  : out std_logic_vector(3 downto 0)
    );
end multiplexer;

architecture behavioral of multiplexer is
begin
	process(S0,S1,B)

	begin
		if S0 = '0' and S1 = '0' then
			Y <=  "0000";
		elsif S0 = '1' and S1 = '0' then
			Y <=  B;
		elsif S0 = '0' and S1 = '1' then
			Y <=  not B;	
		elsif S0 = '1' and S1 = '1' then
			Y <=  "1111";
		end if;
	end process;

end behavioral;
