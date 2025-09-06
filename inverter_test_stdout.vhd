library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;


entity inverter_test_stdout is
end inverter_test_stdout;



architecture test of inverter_test_stdout is
  component
    inverter port (
      input     : in std_logic;
      output    : out std_logic
      );
  end component;

  for il: inverter use entity work.inverter(structural);
  signal ip,op : std_logic;
  signal clock : std_logic;
  procedure print_output is
  	variable out_line: line;
  begin
  	write(out_line, string' (" input="));
  	write(out_line, ip);
  	write(out_line, string' (" output="));
  	write(out_line, op);
  	writeline(output, out_line);
  end print_output;
 
begin

  il : inverter port map (ip,op);
  io_print: process
  	variable out_line : line;
  begin
  	ip <= '0' after 1 ns;
  	wait for 2 ns;
  	write(out_line, string' (" input="));
  	write(out_line, ip);
  	write(out_line, string' (" output="));
  	write(out_line, op);
  	writeline(output, out_line); 	
        wait for 1 ns;
        
        ip <= '1' after 1 ns;
        wait for 2 ns;
        print_output;
        wait for 1 ns;
        
        ip <= '0' after 1 ns;
        wait for 2 ns;
        print_output;
        wait for 1 ns;
   end process io_print;
 end test;
