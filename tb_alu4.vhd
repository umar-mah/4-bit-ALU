library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity tb_alu4 is
end tb_alu4;

architecture test of tb_alu4 is

  component alu_4
  port (
	A : in  std_logic_vector(3 downto 0);
	B : in  std_logic_vector(3 downto 0);
	Cin : in  std_logic;
	S0 : in  std_logic;
	S1 : in  std_logic;
	G : out  std_logic_vector(3 downto 0);
	Cout : out std_logic
  );
  end component;

  for alu_4_temp : alu_4 use entity work.alu_4(structural);

  signal a_tb         : std_logic_vector(3 downto 0) := (others => '0');
  signal b_tb         : std_logic_vector(3 downto 0) := (others => '0');
  signal cin_tb, cout_tb : std_logic := '0';
  signal s0_tb, s1_tb : std_logic := '0';
  signal g_tb         : std_logic_vector(3 downto 0);
  signal clock        : std_logic := '0';

begin


  alu_4_temp : alu_4 port map (a_tb, b_tb, cin_tb, s0_tb, s1_tb, g_tb, cout_tb);

  clk : process
  begin
    clock <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process clk;


  io_process : process
    file infile  : text is in  "alu4_in.txt";
    file outfile : text is out "alu4_out.txt";
    variable buf  : line;
    variable va   : std_logic_vector(3 downto 0);
    variable vb   : std_logic_vector(3 downto 0);
    variable vcin   : std_logic;
    variable vs0  : std_logic;
    variable vs1  : std_logic;
    variable vg   : std_logic_vector(3 downto 0);
    variable vcout   : std_logic;
  begin
    while not endfile(infile) loop
      -- read A (4 bits)
      readline(infile, buf);
      read(buf, va);
      a_tb <= va;

      -- read B (4 bits)
      readline(infile, buf);
      read(buf, vb);
      b_tb <= vb;

      -- read Cin
      readline(infile, buf);
      read(buf, vcin);
      cin_tb <= vcin;

      -- read S0
      readline(infile, buf);
      read(buf, vs0);
      s0_tb <= vs0;

      -- read S1
      readline(infile, buf);
      read(buf, vs1);
      s1_tb <= vs1;

      wait until falling_edge(clock);

      vg := g_tb;
      vcout := cout_tb;
      -- write G
      write(buf, vg);
      writeline(outfile, buf);
       -- write Cout
      write(buf, vcout);
      writeline(outfile, buf);
    end loop;

    wait;
  end process io_process;

end test;
