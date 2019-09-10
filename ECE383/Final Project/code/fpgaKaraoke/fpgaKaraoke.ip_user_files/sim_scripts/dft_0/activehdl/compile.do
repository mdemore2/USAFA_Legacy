vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/xbip_utils_v3_0_8
vlib activehdl/dft_v4_0_14

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap xbip_utils_v3_0_8 activehdl/xbip_utils_v3_0_8
vmap dft_v4_0_14 activehdl/dft_v4_0_14

vlog -work xil_defaultlib  -sv2k12 \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_8 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work dft_v4_0_14 -93 \
"../../../ipstatic/hdl/dft_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../fpgaKaraoke.srcs/sources_1/ip/dft_0/sim/dft_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

