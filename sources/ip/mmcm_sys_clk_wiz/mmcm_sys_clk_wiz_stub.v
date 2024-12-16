// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1.2 (lin64) Build 5164865 Thu Sep  5 14:36:28 MDT 2024
// Date        : Thu Dec 12 15:09:17 2024
// Host        : fmasmitsxps15 running 64-bit Ubuntu 20.04.6 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top mmcm_sys_clk_wiz -prefix
//               mmcm_sys_clk_wiz_ mmcm_sys_clk_wiz_stub.v
// Design      : mmcm_sys_clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module mmcm_sys_clk_wiz(clk_out_lf, clk_out_lfdiv2, clk_out_trans, 
  reset, locked, clk_in)
/* synthesis syn_black_box black_box_pad_pin="reset,locked,clk_in" */
/* synthesis syn_force_seq_prim="clk_out_lf" */
/* synthesis syn_force_seq_prim="clk_out_lfdiv2" */
/* synthesis syn_force_seq_prim="clk_out_trans" */;
  output clk_out_lf /* synthesis syn_isclock = 1 */;
  output clk_out_lfdiv2 /* synthesis syn_isclock = 1 */;
  output clk_out_trans /* synthesis syn_isclock = 1 */;
  input reset;
  output locked;
  input clk_in;
endmodule
