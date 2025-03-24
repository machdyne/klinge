blinky_klinge:
	mkdir -p output
	yosys -q -p "synth_ecp5 -top blinky -json output/blinky_klinge.json" rtl/blinky_klinge.v
	nextpnr-ecp5 --25k --package CABGA256 --lpf klinge_v1.lpf --json output/blinky_klinge.json --textcfg output/klinge_blinky_out.config
	ecppack -v --compress --freq 2.4 output/klinge_blinky_out.config --bit output/klinge.bit

prog:
	openFPGALoader -c usb-blaster output/klinge.bit
