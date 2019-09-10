vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/xbip_utils_v3_0_8
vlib questa_lib/msim/dft_v4_0_14

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap xbip_utils_v3_0_8 questa_lib/msim/xbip_utils_v3_0_8
vmap dft_v4_0_14 questa_lib/msim/dft_v4_0_14

vlog -work xil_defaultlib -64 -sv \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_8 -64 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work dft_v4_0_14 -64 -93 \
"../../../ipstatic/hdl/dft_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../fpgaKaraoke.srcs/sources_1/ip/dft_0/sim/dft_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

