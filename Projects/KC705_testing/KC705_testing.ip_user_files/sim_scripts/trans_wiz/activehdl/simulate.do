transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+trans_wiz  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.trans_wiz xil_defaultlib.glbl

do {trans_wiz.udo}

run

endsim

quit -force
