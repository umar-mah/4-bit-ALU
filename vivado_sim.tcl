# === Compile HDL ===
exec xvhdl and2.vhd or3.vhd xor2.vhd adder1.vhd adder4.vhd multiplexer.vhd alu_4.vhd tb_alu4.vhd

# === Elaborate ===
exec xelab tb_alu4 -debug typical -s sim_out

# === Prepare mux_in.txt with test vectors ===
# Each READ in your TB expects: A line, B line, Cin line, S0 line, S1 line
set mux_in [open "mux_in.txt" "w"]
puts $mux_in "0001"   ;# A(3 downto 0)
puts $mux_in "0011"   ;# B(3 downto 0)
puts $mux_in "0"      ;# Cin
puts $mux_in "0"      ;# S0
puts $mux_in "1"      ;# S1

# add another test vector (A,B,Cin,S0,S1)
puts $mux_in "1111"
puts $mux_in "0000"
puts $mux_in "0"
puts $mux_in "1"
puts $mux_in "0"

close $mux_in

# Touch mux_out.txt (truncate)
set mux_out [open "mux_out.txt" "w"]
puts $mux_out "# Results will be appended by VHDL testbench"
close $mux_out

# === Run Simulation ===
exec xsim sim_out -gui
