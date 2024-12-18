// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1.2 (lin64) Build 5164865 Thu Sep  5 14:36:28 MDT 2024
// Date        : Mon Dec 16 11:52:07 2024
// Host        : fmasmitsxps15 running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ trans_wiz_stub.v
// Design      : trans_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "trans_wiz,gtwizard_v3_6_16,{protocol_file=Start_from_scratch}" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(SYSCLK_IN, SOFT_RESET_TX_IN, 
  SOFT_RESET_RX_IN, DONT_RESET_ON_DATA_ERROR_IN, GT0_TX_FSM_RESET_DONE_OUT, 
  GT0_RX_FSM_RESET_DONE_OUT, GT0_DATA_VALID_IN, GT1_TX_FSM_RESET_DONE_OUT, 
  GT1_RX_FSM_RESET_DONE_OUT, GT1_DATA_VALID_IN, gt0_gtnorthrefclk0_in, 
  gt0_gtnorthrefclk1_in, gt0_gtsouthrefclk0_in, gt0_gtsouthrefclk1_in, gt0_drpaddr_in, 
  gt0_drpclk_in, gt0_drpdi_in, gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, 
  gt0_dmonitorout_out, gt0_eyescanreset_in, gt0_rxuserrdy_in, gt0_eyescandataerror_out, 
  gt0_eyescantrigger_in, gt0_rxusrclk_in, gt0_rxusrclk2_in, gt0_rxdata_out, 
  gt0_rxprbserr_out, gt0_rxprbssel_in, gt0_rxprbscntreset_in, gt0_gtxrxp_in, gt0_gtxrxn_in, 
  gt0_rxbufreset_in, gt0_rxbufstatus_out, gt0_rxdfelpmreset_in, gt0_rxmonitorout_out, 
  gt0_rxmonitorsel_in, gt0_rxoutclkfabric_out, gt0_gtrxreset_in, gt0_rxpmareset_in, 
  gt0_rxslide_in, gt0_rxresetdone_out, gt0_gttxreset_in, gt0_txuserrdy_in, gt0_txusrclk_in, 
  gt0_txusrclk2_in, gt0_txprbsforceerr_in, gt0_txbufstatus_out, gt0_txdata_in, 
  gt0_gtxtxn_out, gt0_gtxtxp_out, gt0_txoutclk_out, gt0_txoutclkfabric_out, 
  gt0_txoutclkpcs_out, gt0_txresetdone_out, gt0_txprbssel_in, gt1_gtnorthrefclk0_in, 
  gt1_gtnorthrefclk1_in, gt1_gtsouthrefclk0_in, gt1_gtsouthrefclk1_in, gt1_drpaddr_in, 
  gt1_drpclk_in, gt1_drpdi_in, gt1_drpdo_out, gt1_drpen_in, gt1_drprdy_out, gt1_drpwe_in, 
  gt1_dmonitorout_out, gt1_eyescanreset_in, gt1_rxuserrdy_in, gt1_eyescandataerror_out, 
  gt1_eyescantrigger_in, gt1_rxusrclk_in, gt1_rxusrclk2_in, gt1_rxdata_out, 
  gt1_rxprbserr_out, gt1_rxprbssel_in, gt1_rxprbscntreset_in, gt1_gtxrxp_in, gt1_gtxrxn_in, 
  gt1_rxbufreset_in, gt1_rxbufstatus_out, gt1_rxdfelpmreset_in, gt1_rxmonitorout_out, 
  gt1_rxmonitorsel_in, gt1_rxoutclkfabric_out, gt1_gtrxreset_in, gt1_rxpmareset_in, 
  gt1_rxslide_in, gt1_rxresetdone_out, gt1_gttxreset_in, gt1_txuserrdy_in, gt1_txusrclk_in, 
  gt1_txusrclk2_in, gt1_txprbsforceerr_in, gt1_txbufstatus_out, gt1_txdata_in, 
  gt1_gtxtxn_out, gt1_gtxtxp_out, gt1_txoutclk_out, gt1_txoutclkfabric_out, 
  gt1_txoutclkpcs_out, gt1_txresetdone_out, gt1_txprbssel_in, GT0_QPLLLOCK_IN, 
  GT0_QPLLREFCLKLOST_IN, GT0_QPLLRESET_OUT, GT0_QPLLOUTCLK_IN, GT0_QPLLOUTREFCLK_IN)
/* synthesis syn_black_box black_box_pad_pin="SOFT_RESET_TX_IN,SOFT_RESET_RX_IN,DONT_RESET_ON_DATA_ERROR_IN,GT0_TX_FSM_RESET_DONE_OUT,GT0_RX_FSM_RESET_DONE_OUT,GT0_DATA_VALID_IN,GT1_TX_FSM_RESET_DONE_OUT,GT1_RX_FSM_RESET_DONE_OUT,GT1_DATA_VALID_IN,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_dmonitorout_out[7:0],gt0_eyescanreset_in,gt0_rxuserrdy_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxdata_out[31:0],gt0_rxprbserr_out,gt0_rxprbssel_in[2:0],gt0_rxprbscntreset_in,gt0_gtxrxp_in,gt0_gtxrxn_in,gt0_rxbufreset_in,gt0_rxbufstatus_out[2:0],gt0_rxdfelpmreset_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_rxoutclkfabric_out,gt0_gtrxreset_in,gt0_rxpmareset_in,gt0_rxslide_in,gt0_rxresetdone_out,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txprbsforceerr_in,gt0_txbufstatus_out[1:0],gt0_txdata_in[31:0],gt0_gtxtxn_out,gt0_gtxtxp_out,gt0_txoutclk_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,gt0_txprbssel_in[2:0],gt1_drpaddr_in[8:0],gt1_drpdi_in[15:0],gt1_drpdo_out[15:0],gt1_drpen_in,gt1_drprdy_out,gt1_drpwe_in,gt1_dmonitorout_out[7:0],gt1_eyescanreset_in,gt1_rxuserrdy_in,gt1_eyescandataerror_out,gt1_eyescantrigger_in,gt1_rxdata_out[31:0],gt1_rxprbserr_out,gt1_rxprbssel_in[2:0],gt1_rxprbscntreset_in,gt1_gtxrxp_in,gt1_gtxrxn_in,gt1_rxbufreset_in,gt1_rxbufstatus_out[2:0],gt1_rxdfelpmreset_in,gt1_rxmonitorout_out[6:0],gt1_rxmonitorsel_in[1:0],gt1_rxoutclkfabric_out,gt1_gtrxreset_in,gt1_rxpmareset_in,gt1_rxslide_in,gt1_rxresetdone_out,gt1_gttxreset_in,gt1_txuserrdy_in,gt1_txprbsforceerr_in,gt1_txbufstatus_out[1:0],gt1_txdata_in[31:0],gt1_gtxtxn_out,gt1_gtxtxp_out,gt1_txoutclk_out,gt1_txoutclkfabric_out,gt1_txoutclkpcs_out,gt1_txresetdone_out,gt1_txprbssel_in[2:0],GT0_QPLLLOCK_IN,GT0_QPLLREFCLKLOST_IN,GT0_QPLLRESET_OUT,GT0_QPLLOUTREFCLK_IN" */
/* synthesis syn_force_seq_prim="SYSCLK_IN" */
/* synthesis syn_force_seq_prim="gt0_gtnorthrefclk0_in" */
/* synthesis syn_force_seq_prim="gt0_gtnorthrefclk1_in" */
/* synthesis syn_force_seq_prim="gt0_gtsouthrefclk0_in" */
/* synthesis syn_force_seq_prim="gt0_gtsouthrefclk1_in" */
/* synthesis syn_force_seq_prim="gt0_drpclk_in" */
/* synthesis syn_force_seq_prim="gt0_rxusrclk_in" */
/* synthesis syn_force_seq_prim="gt0_rxusrclk2_in" */
/* synthesis syn_force_seq_prim="gt0_txusrclk_in" */
/* synthesis syn_force_seq_prim="gt0_txusrclk2_in" */
/* synthesis syn_force_seq_prim="gt1_gtnorthrefclk0_in" */
/* synthesis syn_force_seq_prim="gt1_gtnorthrefclk1_in" */
/* synthesis syn_force_seq_prim="gt1_gtsouthrefclk0_in" */
/* synthesis syn_force_seq_prim="gt1_gtsouthrefclk1_in" */
/* synthesis syn_force_seq_prim="gt1_drpclk_in" */
/* synthesis syn_force_seq_prim="gt1_rxusrclk_in" */
/* synthesis syn_force_seq_prim="gt1_rxusrclk2_in" */
/* synthesis syn_force_seq_prim="gt1_txusrclk_in" */
/* synthesis syn_force_seq_prim="gt1_txusrclk2_in" */
/* synthesis syn_force_seq_prim="GT0_QPLLOUTCLK_IN" */;
  input SYSCLK_IN /* synthesis syn_isclock = 1 */;
  input SOFT_RESET_TX_IN;
  input SOFT_RESET_RX_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  input GT0_DATA_VALID_IN;
  output GT1_TX_FSM_RESET_DONE_OUT;
  output GT1_RX_FSM_RESET_DONE_OUT;
  input GT1_DATA_VALID_IN;
  input gt0_gtnorthrefclk0_in /* synthesis syn_isclock = 1 */;
  input gt0_gtnorthrefclk1_in /* synthesis syn_isclock = 1 */;
  input gt0_gtsouthrefclk0_in /* synthesis syn_isclock = 1 */;
  input gt0_gtsouthrefclk1_in /* synthesis syn_isclock = 1 */;
  input [8:0]gt0_drpaddr_in;
  input gt0_drpclk_in /* synthesis syn_isclock = 1 */;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  output [7:0]gt0_dmonitorout_out;
  input gt0_eyescanreset_in;
  input gt0_rxuserrdy_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  input gt0_rxusrclk_in /* synthesis syn_isclock = 1 */;
  input gt0_rxusrclk2_in /* synthesis syn_isclock = 1 */;
  output [31:0]gt0_rxdata_out;
  output gt0_rxprbserr_out;
  input [2:0]gt0_rxprbssel_in;
  input gt0_rxprbscntreset_in;
  input gt0_gtxrxp_in;
  input gt0_gtxrxn_in;
  input gt0_rxbufreset_in;
  output [2:0]gt0_rxbufstatus_out;
  input gt0_rxdfelpmreset_in;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  output gt0_rxoutclkfabric_out;
  input gt0_gtrxreset_in;
  input gt0_rxpmareset_in;
  input gt0_rxslide_in;
  output gt0_rxresetdone_out;
  input gt0_gttxreset_in;
  input gt0_txuserrdy_in;
  input gt0_txusrclk_in /* synthesis syn_isclock = 1 */;
  input gt0_txusrclk2_in /* synthesis syn_isclock = 1 */;
  input gt0_txprbsforceerr_in;
  output [1:0]gt0_txbufstatus_out;
  input [31:0]gt0_txdata_in;
  output gt0_gtxtxn_out;
  output gt0_gtxtxp_out;
  output gt0_txoutclk_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  input [2:0]gt0_txprbssel_in;
  input gt1_gtnorthrefclk0_in /* synthesis syn_isclock = 1 */;
  input gt1_gtnorthrefclk1_in /* synthesis syn_isclock = 1 */;
  input gt1_gtsouthrefclk0_in /* synthesis syn_isclock = 1 */;
  input gt1_gtsouthrefclk1_in /* synthesis syn_isclock = 1 */;
  input [8:0]gt1_drpaddr_in;
  input gt1_drpclk_in /* synthesis syn_isclock = 1 */;
  input [15:0]gt1_drpdi_in;
  output [15:0]gt1_drpdo_out;
  input gt1_drpen_in;
  output gt1_drprdy_out;
  input gt1_drpwe_in;
  output [7:0]gt1_dmonitorout_out;
  input gt1_eyescanreset_in;
  input gt1_rxuserrdy_in;
  output gt1_eyescandataerror_out;
  input gt1_eyescantrigger_in;
  input gt1_rxusrclk_in /* synthesis syn_isclock = 1 */;
  input gt1_rxusrclk2_in /* synthesis syn_isclock = 1 */;
  output [31:0]gt1_rxdata_out;
  output gt1_rxprbserr_out;
  input [2:0]gt1_rxprbssel_in;
  input gt1_rxprbscntreset_in;
  input gt1_gtxrxp_in;
  input gt1_gtxrxn_in;
  input gt1_rxbufreset_in;
  output [2:0]gt1_rxbufstatus_out;
  input gt1_rxdfelpmreset_in;
  output [6:0]gt1_rxmonitorout_out;
  input [1:0]gt1_rxmonitorsel_in;
  output gt1_rxoutclkfabric_out;
  input gt1_gtrxreset_in;
  input gt1_rxpmareset_in;
  input gt1_rxslide_in;
  output gt1_rxresetdone_out;
  input gt1_gttxreset_in;
  input gt1_txuserrdy_in;
  input gt1_txusrclk_in /* synthesis syn_isclock = 1 */;
  input gt1_txusrclk2_in /* synthesis syn_isclock = 1 */;
  input gt1_txprbsforceerr_in;
  output [1:0]gt1_txbufstatus_out;
  input [31:0]gt1_txdata_in;
  output gt1_gtxtxn_out;
  output gt1_gtxtxp_out;
  output gt1_txoutclk_out;
  output gt1_txoutclkfabric_out;
  output gt1_txoutclkpcs_out;
  output gt1_txresetdone_out;
  input [2:0]gt1_txprbssel_in;
  input GT0_QPLLLOCK_IN;
  input GT0_QPLLREFCLKLOST_IN;
  output GT0_QPLLRESET_OUT;
  input GT0_QPLLOUTCLK_IN /* synthesis syn_isclock = 1 */;
  input GT0_QPLLOUTREFCLK_IN;
endmodule
