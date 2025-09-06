library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity multiplexer_test is
end multiplexer_test;

architecture test of multiplexer_test is

  component multiplexer
    port (
      S0 : in  std_logic;
      S1 : in  std_logic;
      B  : in  std_logic_vector(3 downto 0);
      Y  : out std_logic_vector(3 downto 0)
    );
  end component;

  for mux_1 : multiplexer use entity work.multiplexer(behavioral);

  -- Testbench signals
  signal s0_tb, s1_tb : std_logic := '0';
  signal b_tb         : std_logic_vector(3 downto 0) := (others => '0');
  signal y_tb         : std_logic_vector(3 downto 0);
  signal clock        : std_logic := '0';

begin


  mux_1 : multiplexer port map (s0_tb, s1_tb, b_tb, y_tb);

  clk : process
  begin
    clock <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process clk;


  io_process : process
    file infile  : text is in  "mux_in.txt";
    file outfile : text is out "mux_out.txt";
    variable buf  : line;
    variable vs0  : std_logic;
    variable vs1  : std_logic;
    variable vb   : std_logic_vector(3 downto 0);
    variable vy   : std_logic_vector(3 downto 0);
  begin
    while not endfile(infile) loop
      -- read S0
      readline(infile, buf);
      read(buf, vs0);
      s0_tb <= vs0;

      -- read S1
      readline(infile, buf);
      read(buf, vs1);
      s1_tb <= vs1;

      -- read B (4 bits)
      readline(infile, buf);
      read(buf, vb);
      b_tb <= vb;

      -- wait for DUT to update at clock edge
      wait until falling_edge(clock);

      -- capture output
      vy := y_tb;

      -- write Y to output file
      write(buf, vy);
      writeline(outfile, buf);
    end loop;

    wait; -- stop simulation
  end process io_process;

end test;
