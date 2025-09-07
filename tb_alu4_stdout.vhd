library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity tb_alu4_stdout is
end tb_alu4_stdout;

architecture test of tb_alu4_stdout is

  component alu_4
    port (
      A    : in  std_logic_vector(3 downto 0);
      B    : in  std_logic_vector(3 downto 0);
      Cin  : in  std_logic;
      S0   : in  std_logic;
      S1   : in  std_logic;
      G    : out std_logic_vector(3 downto 0);
      Cout : out std_logic
    );
  end component;

  for alu_inst : alu_4 use entity work.alu_4(structural);


  signal a_tb, b_tb : std_logic_vector(3 downto 0) := (others => '0');
  signal cin_tb, s0_tb, s1_tb, cout_tb : std_logic := '0';
  signal g_tb : std_logic_vector(3 downto 0);
  signal clock : std_logic := '0';

begin


  alu_inst : alu_4 port map (
    A => a_tb,
    B => b_tb,
    Cin => cin_tb,
    S0 => s0_tb,
    S1 => s1_tb,
    G => g_tb,
    Cout => cout_tb
  );

  clk_proc : process
  begin
    while true loop
      clock <= '0';
      wait for 5 ns;
      clock <= '1';
      wait for 5 ns;
    end loop;
  end process;

  stim_proc : process
  begin

    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '0'; s0_tb <= '0'; s1_tb <= '0';
    wait for 10 ns;


    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '0'; s0_tb <= '0'; s1_tb <= '1';
    wait for 10 ns;


    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '0'; s0_tb <= '1'; s1_tb <= '0';
    wait for 10 ns;


    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '0'; s0_tb <= '1'; s1_tb <= '1';
    wait for 10 ns;
    
    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '1'; s0_tb <= '0'; s1_tb <= '0';
    wait for 10 ns;


    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '1'; s0_tb <= '0'; s1_tb <= '1';
    wait for 10 ns;


    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '1'; s0_tb <= '1'; s1_tb <= '0';
    wait for 10 ns;

    a_tb <= "0001"; b_tb <= "1110"; cin_tb <= '1'; s0_tb <= '1'; s1_tb <= '1';
    wait for 10 ns;
    a_tb <= "1111"; b_tb <= "1111"; cin_tb <= '0'; s0_tb <= '1'; s1_tb <= '0';
    wait for 10 ns;
    a_tb <= "1111"; b_tb <= "0000"; cin_tb <= '1'; s0_tb <= '0'; s1_tb <= '1';
    wait for 10 ns;

    wait;
  end process stim_proc;

end test;

