transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+vio_DRP  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.vio_DRP xil_defaultlib.glbl

do {vio_DRP.udo}

run

endsim

quit -force
