transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+vio_RX  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.vio_RX xil_defaultlib.glbl

do {vio_RX.udo}

run

endsim

quit -force
