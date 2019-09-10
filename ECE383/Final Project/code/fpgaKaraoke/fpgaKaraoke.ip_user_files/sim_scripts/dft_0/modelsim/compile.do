vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xbip_utils_v3_0_8
vlib modelsim_lib/msim/dft_v4_0_14

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap xbip_utils_v3_0_8 modelsim_lib/msim/xbip_utils_v3_0_8
vmap dft_v4_0_14 modelsim_lib/msim/dft_v4_0_14

vlog -work xil_defaultlib -64 -incr -sv \
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

