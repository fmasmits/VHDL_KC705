-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1.2 (lin64) Build 5164865 Thu Sep  5 14:36:28 MDT 2024
-- Date        : Thu Dec 12 15:09:17 2024
-- Host        : fmasmitsxps15 running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top mmcm_sys_clk_wiz -prefix
--               mmcm_sys_clk_wiz_ mmcm_sys_clk_wiz_stub.vhdl
-- Design      : mmcm_sys_clk_wiz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mmcm_sys_clk_wiz is
  Port ( 
    clk_out_lf : out STD_LOGIC;
    clk_out_lfdiv2 : out STD_LOGIC;
    clk_out_trans : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end mmcm_sys_clk_wiz;

architecture stub of mmcm_sys_clk_wiz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out_lf,clk_out_lfdiv2,clk_out_trans,reset,locked,clk_in";
begin
end;
