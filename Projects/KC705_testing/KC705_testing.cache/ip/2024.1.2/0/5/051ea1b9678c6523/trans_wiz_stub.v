// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1.2 (lin64) Build 5164865 Thu Sep  5 14:36:28 MDT 2024
// Date        : Tue Dec 17 14:26:34 2024
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
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(SOFT_RESET_TX_IN, SOFT_RESET_RX_IN, 
  DONT_RESET_ON_DATA_ERROR_IN, Q0_CLK1_GTREFCLK_PAD_N_IN, Q0_CLK1_GTREFCLK_PAD_P_IN, 
  GT0_TX_FSM_RESET_DONE_OUT, GT0_RX_FSM_RESET_DONE_OUT, GT0_DATA_VALID_IN, 
  GT0_TXUSRCLK_OUT, GT0_TXUSRCLK2_OUT, GT0_RXUSRCLK_OUT, GT0_RXUSRCLK2_OUT, gt0_drpaddr_in, 
  gt0_drpdi_in, gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, 
  gt0_dmonitorout_out, gt0_eyescanreset_in, gt0_rxuserrdy_in, gt0_eyescandataerror_out, 
  gt0_eyescantrigger_in, gt0_rxdata_out, gt0_gtxrxp_in, gt0_gtxrxn_in, gt0_rxbufreset_in, 
  gt0_rxbufstatus_out, gt0_rxdfelpmreset_in, gt0_rxmonitorout_out, gt0_rxmonitorsel_in, 
  gt0_rxoutclkfabric_out, gt0_gtrxreset_in, gt0_rxpmareset_in, gt0_rxslide_in, 
  gt0_rxresetdone_out, gt0_gttxreset_in, gt0_txuserrdy_in, gt0_txbufstatus_out, 
  gt0_txdata_in, gt0_gtxtxn_out, gt0_gtxtxp_out, gt0_txoutclkfabric_out, 
  gt0_txoutclkpcs_out, gt0_txresetdone_out, GT0_QPLLPD_IN, GT0_QPLLLOCK_OUT, 
  GT0_QPLLREFCLKLOST_OUT, GT0_QPLLOUTCLK_OUT, GT0_QPLLOUTREFCLK_OUT, sysclk_in)
/* synthesis syn_black_box black_box_pad_pin="SOFT_RESET_TX_IN,SOFT_RESET_RX_IN,DONT_RESET_ON_DATA_ERROR_IN,Q0_CLK1_GTREFCLK_PAD_N_IN,Q0_CLK1_GTREFCLK_PAD_P_IN,GT0_TX_FSM_RESET_DONE_OUT,GT0_RX_FSM_RESET_DONE_OUT,GT0_DATA_VALID_IN,gt0_drpaddr_in[8:0],gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_dmonitorout_out[7:0],gt0_eyescanreset_in,gt0_rxuserrdy_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxdata_out[31:0],gt0_gtxrxp_in,gt0_gtxrxn_in,gt0_rxbufreset_in,gt0_rxbufstatus_out[2:0],gt0_rxdfelpmreset_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_rxoutclkfabric_out,gt0_gtrxreset_in,gt0_rxpmareset_in,gt0_rxslide_in,gt0_rxresetdone_out,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txbufstatus_out[1:0],gt0_txdata_in[31:0],gt0_gtxtxn_out,gt0_gtxtxp_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,GT0_QPLLPD_IN,GT0_QPLLLOCK_OUT,GT0_QPLLREFCLKLOST_OUT,GT0_QPLLOUTREFCLK_OUT" */
/* synthesis syn_force_seq_prim="GT0_TXUSRCLK_OUT" */
/* synthesis syn_force_seq_prim="GT0_TXUSRCLK2_OUT" */
/* synthesis syn_force_seq_prim="GT0_RXUSRCLK_OUT" */
/* synthesis syn_force_seq_prim="GT0_RXUSRCLK2_OUT" */
/* synthesis syn_force_seq_prim="GT0_QPLLOUTCLK_OUT" */
/* synthesis syn_force_seq_prim="sysclk_in" */;
  input SOFT_RESET_TX_IN;
  input SOFT_RESET_RX_IN;
  input DONT_RESET_ON_DATA_ERROR_IN;
  input Q0_CLK1_GTREFCLK_PAD_N_IN;
  input Q0_CLK1_GTREFCLK_PAD_P_IN;
  output GT0_TX_FSM_RESET_DONE_OUT;
  output GT0_RX_FSM_RESET_DONE_OUT;
  input GT0_DATA_VALID_IN;
  output GT0_TXUSRCLK_OUT /* synthesis syn_isclock = 1 */;
  output GT0_TXUSRCLK2_OUT /* synthesis syn_isclock = 1 */;
  output GT0_RXUSRCLK_OUT /* synthesis syn_isclock = 1 */;
  output GT0_RXUSRCLK2_OUT /* synthesis syn_isclock = 1 */;
  input [8:0]gt0_drpaddr_in;
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
  output [31:0]gt0_rxdata_out;
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
  output [1:0]gt0_txbufstatus_out;
  input [31:0]gt0_txdata_in;
  output gt0_gtxtxn_out;
  output gt0_gtxtxp_out;
  output gt0_txoutclkfabric_out;
  output gt0_txoutclkpcs_out;
  output gt0_txresetdone_out;
  input GT0_QPLLPD_IN;
  output GT0_QPLLLOCK_OUT;
  output GT0_QPLLREFCLKLOST_OUT;
  output GT0_QPLLOUTCLK_OUT /* synthesis syn_isclock = 1 */;
  output GT0_QPLLOUTREFCLK_OUT;
  input sysclk_in /* synthesis syn_isclock = 1 */;
endmodule
