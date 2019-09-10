onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+dft_0 -L xil_defaultlib -L xpm -L xbip_utils_v3_0_8 -L dft_v4_0_14 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.dft_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {dft_0.udo}

run -all

endsim

quit -force
