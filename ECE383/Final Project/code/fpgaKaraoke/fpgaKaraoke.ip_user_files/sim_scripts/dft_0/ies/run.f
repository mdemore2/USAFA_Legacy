-makelib ies_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xbip_utils_v3_0_8 \
  "../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/dft_v4_0_14 \
  "../../../ipstatic/hdl/dft_v4_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../fpgaKaraoke.srcs/sources_1/ip/dft_0/sim/dft_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

