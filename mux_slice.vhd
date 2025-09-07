library IEEE;
use IEEE.std_logic_1164.all;

entity mux_slice is
  port (
    S0    : in  std_logic;
    S1    : in  std_logic;
    B_in  : in  std_logic; 
    Y_out : out std_logic
  );
end mux_slice;

architecture structural of mux_slice is
  component and2
    port(input1, input2 : in std_logic; output : out std_logic);
  end component;

  component or3
    port(input1, input2, input3 : in std_logic; output : out std_logic);
  end component;

  component inverter
    port(input : in std_logic; output : out std_logic);
  end component;

  signal nS0, nS1, nB     : std_logic;
  signal sel10, sel01, sel11 : std_logic;
  signal b10, b01, b11    : std_logic;
begin
  inv_S0: inverter port map(input => S0, output => nS0);
  inv_S1: inverter port map(input => S1, output => nS1);
  inv_B : inverter port map(input => B_in, output => nB);

  and_S0nS1: and2 port map(input1 => S0,  input2 => nS1, output => sel10);
  and_nS0S1: and2 port map(input1 => nS0, input2 => S1,  output => sel01);
  and_S0S1 : and2 port map(input1 => S0,  input2 => S1,  output => sel11);

  and10: and2 port map(input1 => B_in, input2 => sel10, output => b10);
  and01: and2 port map(input1 => nB,   input2 => sel01, output => b01);
  b11 <= sel11;

  or_out: or3 port map(input1 => b10, input2 => b01, input3 => b11, output => Y_out);
end structural;
