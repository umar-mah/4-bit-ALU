-- file: multiplexer.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity multiplexer is
  port (
    S0 : in  std_logic;
    S1 : in  std_logic;
    B  : in  std_logic_vector(3 downto 0);
    Y  : out std_logic_vector(3 downto 0)
  );
end multiplexer;

architecture structural of multiplexer is
  component mux_slice
    port (
      S0    : in  std_logic;
      S1    : in  std_logic;
      B_in  : in  std_logic;
      Y_out : out std_logic
    );
  end component;
begin
  bit0: mux_slice port map(S0 => S0, S1 => S1, B_in => B(0), Y_out => Y(0));
  bit1: mux_slice port map(S0 => S0, S1 => S1, B_in => B(1), Y_out => Y(1));
  bit2: mux_slice port map(S0 => S0, S1 => S1, B_in => B(2), Y_out => Y(2));
  bit3: mux_slice port map(S0 => S0, S1 => S1, B_in => B(3), Y_out => Y(3));
end structural;
