onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L xbip_utils_v3_0_8 -L dft_v4_0_14 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.dft_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {dft_0.udo}

run -all

quit -force
