transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+vio_TRANS  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_TRANS xil_defaultlib.glbl

do {vio_TRANS.udo}

run 1000ns

endsim

quit -force
