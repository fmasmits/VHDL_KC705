-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1.2 (lin64) Build 5164865 Thu Sep  5 14:36:28 MDT 2024
-- Date        : Wed Dec 18 18:28:26 2024
-- Host        : fmasmitsxps15 running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/fma_smits/documents/UU_afstuderen/VHDL_UU_KC705/sources/ip/vio_RxTx/vio_RxTx_stub.vhdl
-- Design      : vio_RxTx
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_RxTx is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 6 downto 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out4 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out5 : out STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_out6 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out7 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out8 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out9 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out10 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out11 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out12 : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );

end vio_RxTx;

architecture stub of vio_RxTx is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[0:0],probe_in1[2:0],probe_in2[6:0],probe_in3[0:0],probe_in4[1:0],probe_in5[0:0],probe_out0[0:0],probe_out1[2:0],probe_out2[0:0],probe_out3[0:0],probe_out4[0:0],probe_out5[1:0],probe_out6[0:0],probe_out7[0:0],probe_out8[0:0],probe_out9[0:0],probe_out10[0:0],probe_out11[0:0],probe_out12[2:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2024.1.2";
begin
end;
