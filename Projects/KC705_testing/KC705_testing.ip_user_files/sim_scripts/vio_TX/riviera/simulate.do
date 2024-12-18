transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+vio_TX  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_TX xil_defaultlib.glbl

do {vio_TX.udo}

run 1000ns

endsim

quit -force
