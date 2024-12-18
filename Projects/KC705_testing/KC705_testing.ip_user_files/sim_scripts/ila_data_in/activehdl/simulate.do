transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_data_in  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.ila_data_in xil_defaultlib.glbl

do {ila_data_in.udo}

run

endsim

quit -force
