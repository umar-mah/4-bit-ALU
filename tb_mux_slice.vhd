library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity tb_mux_slice is
end tb_mux_slice;

architecture test of tb_mux_slice is

  component mux_slice
    port (
      S0 : in  std_logic;
      S1 : in  std_logic;
      B  : in  std_logic;
      Y  : out std_logic
    );
  end component;

  for mux_1 : mux_slice use entity work.mux_slice(structural);

  -- Testbench signals
  signal s0_tb, s1_tb : std_logic := '0';
  signal b_tb         : std_logic;
  signal y_tb         : std_logic;
begin


  mux_1 : mux_slice port map (s0_tb, s1_tb, b_tb, y_tb);


  io_process : process
    file infile  : text is in  "mux_in.txt";
    file outfile : text is out "mux_out.txt";
    variable buf  : line;
    variable vs0  : std_logic;
    variable vs1  : std_logic;
    variable vb   : std_logic;
    variable vy   : std_logic;
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
      wait for 10 ns;

      -- capture output
      vy := y_tb;

      -- write Y to output file
      write(buf, vy);
      writeline(outfile, buf);
    end loop;

    wait; -- stop simulation
  end process io_process;

end test;
