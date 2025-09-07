exec xvhdl and2.vhd or3.vhd xor2.vhd adder1.vhd adder4.vhd inverter.vhd mux_slice.vhd multiplexer.vhd alu_4.vhd tb_alu4_stdout.vhd

exec xelab tb_alu4_stdout -debug typical -s sim_out

exec xsim sim_out -gui

