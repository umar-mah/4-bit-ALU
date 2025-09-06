library IEEE;
use IEEE.std_logic_1164.all;

entity alu_4 is
port (
	A : in  std_logic_vector(3 downto 0);
	B : in  std_logic_vector(3 downto 0);
	Cin : in  std_logic;
	S0 : in  std_logic;
	S1 : in  std_logic;
	G : out  std_logic_vector(3 downto 0);
	Cout : out std_logic
);
end alu_4;
architecture structural of alu_4 is

	component multiplexer
	    port (
	      S0 : in  std_logic;
	      S1 : in  std_logic;
	      B  : in  std_logic_vector(3 downto 0);
	      Y  : out std_logic_vector(3 downto 0)
	    );
	  end component;

	component adder4
	  port (
	    input1   : in  std_logic_vector(3 downto 0);
	    input2   : in  std_logic_vector(3 downto 0);
	    carryin  : in  std_logic;
	    sum      : out std_logic_vector(3 downto 0);
	    carryout : out std_logic
	    );
	end component;
      	signal mux_out : std_logic_vector(3 downto 0);
         for u_mux   : multiplexer use entity work.multiplexer(structural);
	 for u_adder : adder4     use entity work.adder4(structural);
	begin

	 u_mux : multiplexer port map (S0 => S0, S1 => S1, B => B, Y => mux_out);

	  u_adder : adder4 port map (input1 => A, input2 => mux_out, carryin => Cin, sum => G, carryout => Cout);

end structural;
