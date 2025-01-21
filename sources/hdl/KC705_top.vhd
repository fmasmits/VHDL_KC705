library IEEE;
library UNISIM;
library xpm;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use UNISIM.vcomponents.all;
use xpm.vcomponents.all;

entity KC705_top is
  generic (
  
    -- Generics passed to top module by "Hog"":
    -- Global Generic Variables
    GLOBAL_DATE        : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_TIME        : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_VER         : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_SHA         : std_logic_vector(31 downto 0) := (others => '0');
    TOP_VER            : std_logic_vector(31 downto 0) := (others => '0');
    TOP_SHA            : std_logic_vector(31 downto 0) := (others => '0');
    CON_VER            : std_logic_vector(31 downto 0) := (others => '0');
    CON_SHA            : std_logic_vector(31 downto 0) := (others => '0');
    HOG_VER            : std_logic_vector(31 downto 0) := (others => '0');
    HOG_SHA            : std_logic_vector(31 downto 0) := (others => '0');
    IPS_VER            : std_logic_vector(31 downto 0) := (others => '0');
    IPS_SHA            : std_logic_vector(31 downto 0) := (others => '0');
    XIL_DEFAULTLIB_VER : std_logic_vector(31 downto 0) := (others => '0');
    XIL_DEFAULTLIB_SHA : std_logic_vector(31 downto 0) := (others => '0');
    OTHERS_VER         : std_logic_vector(31 downto 0) := (others => '0');
    OTHERS_SHA         : std_logic_vector(31 downto 0) := (others => '0');
    
    --IPBus XML
    XML_SHA            : std_logic_vector(31 downto 0) := (others => '0');
    XML_VER            : std_logic_vector(31 downto 0) := (others => '0');
    
    -- Project flavor
    FLAVOUR            : integer                       := 0
    );

    port ( 
        clk_sys_diff            : in    std_logic_vector(1 downto 0);       -- 200 MHz clock
        clk_trans_diff          : in    std_logic_vector(1 downto 0);       -- 125 MHz clock
        data_out_diff           : out   std_logic_vector(1 downto 0);
        data_in_diff            : in    std_logic_vector(1 downto 0)
    );
    
end KC705_top;

architecture Behavioral of KC705_top is
    
    ----------------------------------
    --            Signals           --
    ----------------------------------
    signal clk_sys          : std_logic;            -- 200 MHz clock
    signal clk_sys_div2     : std_logic;            -- 100 MHz clock
    signal clk_fabric_rx    : std_logic;            -- recovered clk from received data
    signal clk_pcs_tx    : std_logic;               -- pcs clock from tx
    
    --         vio signals          --
    signal drp_rst          : std_logic;   
    signal drp_en           : std_logic;
    signal drp_rdy          : std_logic;
    signal drp_wen          : std_logic;
    signal drp_addr         : std_logic_vector(8  downto 0);
    signal drp_din          : std_logic_vector(15 downto 0);
    signal drp_dout         : std_logic_vector(15 downto 0);
    
    signal qpll_lckd        : std_logic;
    signal qpll_pd          : std_logic;
    signal qpll_ref_lost    : std_logic;
    
    signal trans_rx_rst     : std_logic;
    signal trans_tx_rst     : std_logic;
    signal trans_rst_on_err : std_logic;
    signal trans_rx_done    : std_logic;
    signal trans_tx_done    : std_logic;
    signal trans_valid_data : std_logic;
    
    signal digital_monitor  : std_logic_vector(7 downto 0);
    signal eye_scan_rst     : std_logic;
    signal eye_data_err     : std_logic;
    signal eye_scan_trig    : std_logic;

    --         cdc signals          --
    signal vio_rx_in        : std_logic_vector(11 downto 0);
    signal vio_rx_in_sync   : std_logic_vector(11 downto 0);
    signal vio_rx_out       : std_logic_vector(43 downto 0);
    signal vio_rx_out_sync  : std_logic_vector(43 downto 0);
    
    signal vio_tx_in        : std_logic_vector(37 downto 0);
    signal vio_tx_in_dff    : std_logic_vector(37 downto 0);
    signal vio_tx_in_sync   : std_logic_vector(37 downto 0);
    signal vio_tx_out       : std_logic_vector(2 downto 0);
    signal vio_tx_out_sync  : std_logic_vector(2 downto 0);
    
    --        fifo signals          --
    signal vio_fifo_tx_in   : std_logic_vector(3 downto 0);
    signal vio_fifo_rx_in   : std_logic_vector(1 downto 0);
    
    
    
    ----------------------------------
    --           Components         --
    ---------------------------------- 
    
    component ck_wiz
    port(
      clk_out_div2      : out    std_logic;
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1_p         : in     std_logic;
      clk_in1_n         : in     std_logic
     );
    end component;


    component vio_tra_set
    port (
        clk         : in    std_logic;
        probe_in0   : in    std_logic;                      -- trans
        probe_in1   : in    std_logic;                      -- trans
        probe_in2   : in    std_logic;                      -- qpll
        probe_in3   : in    std_logic;                      -- qpll   
        probe_in4   : in    std_logic_vector(7 downto 0);   -- misc
        probe_in5   : in    std_logic;                      -- misc
        probe_out0  : out   std_logic;                      -- trans
        probe_out1  : out   std_logic;                      -- trans
        probe_out2  : out   std_logic;                      -- trans
        probe_out3  : out   std_logic;                      -- trans
        probe_out4  : out   std_logic;                      -- qpll 
        probe_out5  : out   std_logic;                      -- misc   
        probe_out6  : out   std_logic                       -- misc   
    );
    end component;
    
    component vio_drp
    port(
        clk         : in    std_logic;                      -- drp
        probe_in0   : in    std_logic_vector(15 downto 0);  -- drp
        probe_in1   : in    std_logic;                      -- drp
        probe_out0  : out   std_logic_vector(8 downto 0);   -- drp
        probe_out1  : out   std_logic_vector(15 downto 0);  -- drp
        probe_out2  : out   std_logic;                      -- drp
        probe_out3  : out   std_logic                       -- drp
    );
    end component;
    
    component vio_Rx
    port(
        clk         : in    std_logic;
        probe_in0   : in    std_logic;
        probe_in1   : in    std_logic_vector(2 downto 0);
        probe_in2   : in    std_logic_vector(6 downto 0);
        probe_in3   : in    std_logic;
        probe_out0  : out   std_logic;
        probe_out1  : out   std_logic_vector(2 downto 0);
        probe_out2  : out   std_logic;
        probe_out3  : out   std_logic;
        probe_out4  : out   std_logic;
        probe_out5  : out   std_logic_vector(1 downto 0);
        probe_out6  : out   std_logic;
        probe_out7  : out   std_logic;
        probe_out8  : out   std_logic 
    );
    end component;
    
    component fifo_rx_in
    port (
        rst             : in  std_logic;
        wr_clk          : in  std_logic;
        rd_clk          : in  std_logic;
        din             : in  std_logic_vector(11 downto 0);
        wr_en           : in  std_logic;
        rd_en           : in  std_logic;
        dout            : out std_logic_vector(11 downto 0);
        full            : out std_logic;
        empty           : out std_logic
    );
    end component;
    
    component vio_Tx
    port(
        clk         : in    std_logic;
        probe_in0   : in    std_logic_vector(1 downto 0);
        probe_in1   : in    std_logic;
        probe_out0  : out   std_logic;
        probe_out1  : out   std_logic;
        probe_out2  : out   std_logic;
        probe_out3  : out   std_logic_vector(2 downto 0);
        probe_out4  : out   std_logic_vector(31 downto 0)
    );
    end component;

    component fifo_tx_in
    port (
        rst             : in  std_logic;
        wr_clk          : in  std_logic;
        rd_clk          : in  std_logic;
        din             : in  std_logic_vector(37 downto 0);
        wr_en           : in  std_logic;
        rd_en           : in  std_logic;
        dout            : out std_logic_vector(37 downto 0);
        full            : out std_logic;
        overflow        : out std_logic;
        empty           : out std_logic;
        underflow       : out std_logic
    );
    end component;
    
    component ila_Rx_data
    port (
        clk         : in std_logic;
        probe0      : in std_logic_vector(31 downto 0)
    );
    end component;
    
    
    component trans_wiz 
    port (
        SOFT_RESET_TX_IN                        : in   std_logic;                           -- reset Tx channel
        SOFT_RESET_RX_IN                        : in   std_logic;                           -- reset Rx channel
        DONT_RESET_ON_DATA_ERROR_IN             : in   std_logic;                           -- Setting to reset itself when counting many errors (should be 0)
        
        GT0_TX_FSM_RESET_DONE_OUT               : out  std_logic;                           -- reset Tx channel done indicator
        GT0_RX_FSM_RESET_DONE_OUT               : out  std_logic;                           -- reset Rx channel done indicator
        GT0_DATA_VALID_IN                       : in   std_logic;                           -- Ensures valid data transmission
        
        SYSCLK_IN                               : in   std_logic;                           -- Same as the drp_clk_in
        Q0_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
        Q0_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
        GT0_TXUSRCLK_OUT                        : out  std_logic;                           -- relation between USRCLK and USRCLK2 depend on data width
        GT0_TXUSRCLK2_OUT                       : out  std_logic;                           -- relation between USRCLK and USRCLK2 depend on data width
        GT0_RXUSRCLK_OUT                        : out  std_logic;                           -- Srelation between USRCLK and USRCLK2 depend on data width
        GT0_RXUSRCLK2_OUT                       : out  std_logic;                           -- relation between USRCLK and USRCLK2 depend on data width
    
        --_________________________________________________________________________
        --GT0  (X0Y0)
        --____________________________CHANNEL PORTS________________________________
        ---------------------------- Channel - DRP Ports  --------------------------
        gt0_drpaddr_in                          : in   std_logic_vector(8 downto 0);        -- DRP settings (nog kijken wat precies)
        gt0_drpdi_in                            : in   std_logic_vector(15 downto 0);       -- DRP data in
        gt0_drpdo_out                           : out  std_logic_vector(15 downto 0);       -- DRP data out
        gt0_drpen_in                            : in   std_logic;                           -- DRP enable   
        gt0_drprdy_out                          : out  std_logic;                           -- DRP ready
        gt0_drpwe_in                            : in   std_logic;                           -- DRP write enable
        
        --------------------------- Digital Monitor Ports --------------------------
        gt0_dmonitorout_out                     : out  std_logic_vector(7 downto 0);
        gt0_eyescanreset_in                     : in   std_logic;
        gt0_eyescandataerror_out                : out  std_logic;
        gt0_eyescantrigger_in                   : in   std_logic;
        
        --------------------------------- RX Ports ---------------------------------
        gt0_rxuserrdy_in                        : in   std_logic;                           -- rx user ready signal
        gt0_rxdata_out                          : out  std_logic_vector(31 downto 0);       -- rx Data na parallelisering
        gt0_rxprbserr_out                       : out  std_logic;                           -- rx prbs error                indicator
        gt0_rxprbssel_in                        : in   std_logic_vector(2 downto 0);        -- rx prbs select
        gt0_rxprbscntreset_in                   : in   std_logic;                           -- rx prbs counter reset
        gt0_gtxrxp_in                           : in   std_logic;                           -- rx differential - p data input
        gt0_gtxrxn_in                           : in   std_logic;                           -- rx differential - n data input
        gt0_rxbufreset_in                       : in   std_logic;                           -- rx buffer reset
        gt0_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);        -- rx buffer status             indicators
        gt0_rxdfelpmreset_in                    : in   std_logic;                           -- rx dfe lpm reset
        gt0_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);        -- rx monitor                   indicators
        gt0_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);        -- rx monitor select
        gt0_rxoutclkfabric_out                  : out  std_logic;                           -- rx clk out from the fabric
        gt0_gtrxreset_in                        : in   std_logic;                           -- rx gt reset
        gt0_rxpmareset_in                       : in   std_logic;                           -- rx pma reset 
        gt0_rxslide_in                          : in   std_logic;                           -- rx slide (used for correcting phase shifts)
        gt0_rxresetdone_out                     : out  std_logic;                           -- rx reset done                indicator
        
        --------------------------------- TX Ports ---------------------------------
        gt0_gttxreset_in                        : in   std_logic;                           -- tx gt reset
        gt0_txuserrdy_in                        : in   std_logic;                           -- tx user ready signal
        gt0_txprbsforceerr_in                   : in   std_logic;                           -- tx force error into the data
        gt0_txbufstatus_out                     : out  std_logic_vector(1 downto 0);        -- tx buffer status
        gt0_txdata_in                           : in   std_logic_vector(31 downto 0);       -- tx parralel data die je verstuurt        
        gt0_gtxtxn_out                          : out  std_logic;                           -- tx differential - n data output
        gt0_gtxtxp_out                          : out  std_logic;                           -- tx differential - p data output
        gt0_txoutclkfabric_out                  : out  std_logic;                           -- tx clock from the fabric 
        gt0_txoutclkpcs_out                     : out  std_logic;                           -- tx clock out from pcs (physical coding sublayer)
        gt0_txresetdone_out                     : out  std_logic;                           -- tx reset done indicator
        gt0_txprbssel_in                        : in   std_logic_vector(2 downto 0);        -- tx prbs select    

        --____________________________COMMON PORTS________________________________
        GT0_QPLLPD_IN                           : in   std_logic;                           -- Power down
        GT0_QPLLLOCK_OUT                        : out  std_logic;                           -- PLL lock indicator
        GT0_QPLLREFCLKLOST_OUT                  : out  std_logic;                           -- Indicator if the phase is lost
        GT0_QPLLOUTCLK_OUT                      : out  std_logic;                           -- QPLL out clock
        GT0_QPLLOUTREFCLK_OUT                   : out  std_logic                            -- QPLL out reference clock    
    );
    end component;
 
begin

    ----------------------------------
    --    Clock domain crossing     --
    ----------------------------------
--    i_xpm_cdc_vio_tx_in : xpm_cdc_array_single
--    generic map (
--          DEST_SYNC_FF   => 4,           -- DECIMAL; range: 2-10
--          INIT_SYNC_FF   => 0,           -- DECIMAL; 0/1 = disable/enable simulation init values
--          SIM_ASSERT_CHK => 0,           -- DECIMAL; 0/1 = disable/enable simulation messages
--          SRC_INPUT_REG  => 0,           -- DECIMAL; 0/1 = do not/do register input
--          WIDTH          => 38
--    ) port map (
--          dest_out => vio_tx_in_dff,  
--          dest_clk => clk_pcs_tx,      -- 1-bit input: Clock signal for the destination clock domain.
--          src_clk  => clk_sys_div2,      -- 1-bit input: optional; required when SRC_INPUT_REG = 1
--          src_in   => vio_tx_in        
--    );
    
    i_fifo_tx_in : fifo_tx_in
    port map (
        rst             => '0',
        wr_clk          => clk_sys_div2,
        rd_clk          => clk_pcs_tx,
        din             => vio_tx_in,
        wr_en           => '1',
        rd_en           => '1',
        dout            => vio_tx_in_sync,
        full            => vio_fifo_tx_in(0),
        overflow        => vio_fifo_tx_in(1),
        empty           => vio_fifo_tx_in(2),
        underflow       => vio_fifo_tx_in(3)
    );
    
    i_xpm_cdc_vio_tx_out : xpm_cdc_array_single
    generic map (
          DEST_SYNC_FF   => 4,           -- DECIMAL; range: 2-10
          INIT_SYNC_FF   => 0,           -- DECIMAL; 0/1 = disable/enable simulation init values
          SIM_ASSERT_CHK => 0,           -- DECIMAL; 0/1 = disable/enable simulation messages
          SRC_INPUT_REG  => 0,           -- DECIMAL; 0/1 = do not/do register input
          WIDTH          => 3
    ) port map (
          dest_out => vio_tx_out_sync,  
          dest_clk => clk_sys_div2,      -- 1-bit input: Clock signal for the destination clock domain.
          src_clk  => clk_pcs_tx,     -- 1-bit input: optional; required when SRC_INPUT_REG = 1
          src_in   => vio_tx_out        
    );
    
--    i_xpm_cdc_vio_rx_in : xpm_cdc_array_single
--    generic map (
--          DEST_SYNC_FF   => 4,           -- DECIMAL; range: 2-10
--          INIT_SYNC_FF   => 0,           -- DECIMAL; 0/1 = disable/enable simulation init values
--          SIM_ASSERT_CHK => 0,           -- DECIMAL; 0/1 = disable/enable simulation messages
--          SRC_INPUT_REG  => 0,           -- DECIMAL; 0/1 = do not/do register input
--          WIDTH          => 12
--    ) port map (
--          dest_out => vio_rx_in_sync,  
--          dest_clk => clk_fabric_rx,      -- 1-bit input: Clock signal for the destination clock domain.
--          src_clk  => clk_sys_div2,      -- 1-bit input: optional; required when SRC_INPUT_REG = 1
--          src_in   => vio_rx_in        
--    );
    
    i_fifo_rx_in : fifo_rx_in
    port map (
        rst             => '0',
        wr_clk          => clk_sys_div2,
        rd_clk          => clk_fabric_rx,
        din             => vio_rx_in,
        wr_en           => '1',
        rd_en           => '1',
        dout            => vio_rx_in_sync,
        full            => vio_fifo_rx_in(0),
        empty           => vio_fifo_rx_in(1)
    );
    
    i_xpm_cdc_vio_rx_out : xpm_cdc_array_single
    generic map (
          DEST_SYNC_FF   => 4,           -- DECIMAL; range: 2-10
          INIT_SYNC_FF   => 0,           -- DECIMAL; 0/1 = disable/enable simulation init values
          SIM_ASSERT_CHK => 0,           -- DECIMAL; 0/1 = disable/enable simulation messages
          SRC_INPUT_REG  => 0,           -- DECIMAL; 0/1 = do not/do register input
          WIDTH          => 44
    ) port map (
          dest_out => vio_rx_out_sync,  
          dest_clk => clk_sys_div2,      -- 1-bit input: Clock signal for the destination clock domain.
          src_clk  => clk_fabric_rx,     -- 1-bit input: optional; required when SRC_INPUT_REG = 1
          src_in   => vio_rx_out        
    );
    
    ----------------------------------
    --           Components         --
    ----------------------------------
    
    
    i_clk_wiz : ck_wiz
      port map ( 
      clk_out_div2 => clk_sys_div2,              
      reset        => '0',
      locked       => open,
      clk_in1_p    => clk_sys_diff(0),
      clk_in1_n    => clk_sys_diff(1)
    );
    
    
    i_trans_wiz : trans_wiz
    port map (
            SOFT_RESET_TX_IN                => trans_tx_rst,
            SOFT_RESET_RX_IN                => trans_rx_rst,
            DONT_RESET_ON_DATA_ERROR_IN     => trans_rst_on_err,
        
            GT0_TX_FSM_RESET_DONE_OUT       => trans_tx_done,
            GT0_RX_FSM_RESET_DONE_OUT       => trans_rx_done,
            GT0_DATA_VALID_IN               => trans_valid_data,
            
            SYSCLK_IN                       => clk_sys_div2,
            Q0_CLK0_GTREFCLK_PAD_P_IN       => clk_trans_diff(0),
            Q0_CLK0_GTREFCLK_PAD_N_IN       => clk_trans_diff(1),
            GT0_TXUSRCLK_OUT                => open,
            GT0_TXUSRCLK2_OUT               => open,
            GT0_RXUSRCLK_OUT                => open,
            GT0_RXUSRCLK2_OUT               => open,
    
            --_________________________________________________________________________
            --                             GT0  (X0Y0)
            --____________________________CHANNEL PORTS________________________________
            
            ---------------------------- Channel - DRP Ports  --------------------------
            gt0_drpaddr_in                  => drp_addr,
            gt0_drpdi_in                    => drp_din,
            gt0_drpdo_out                   => drp_dout,
            gt0_drpen_in                    => drp_en,
            gt0_drprdy_out                  => drp_rdy,
            gt0_drpwe_in                    => drp_wen,
            
            --------------------------- Digital Monitor Ports --------------------------
            gt0_dmonitorout_out             => digital_monitor,
            gt0_eyescanreset_in             => eye_scan_rst,
            gt0_eyescandataerror_out        => eye_data_err,
            gt0_eyescantrigger_in           => eye_scan_trig,
            
            --------------------------------- RX Ports ---------------------------------
            gt0_rxuserrdy_in                => vio_rx_in_sync(0),
            gt0_rxprbserr_out               => vio_rx_out(0),
            gt0_rxprbssel_in                => vio_rx_in_sync(3 downto 1),
            gt0_rxprbscntreset_in           => vio_rx_in_sync(4),
            gt0_rxdata_out                  => vio_rx_out(43 downto 12),
            gt0_gtxrxp_in                   => data_in_diff(0),
            gt0_gtxrxn_in                   => data_in_diff(1),
            gt0_rxbufreset_in               => vio_rx_in_sync(5),
            gt0_rxbufstatus_out             => vio_rx_out(3 downto 1),
            gt0_rxdfelpmreset_in            => vio_rx_in_sync(6),
            gt0_rxmonitorout_out            => vio_rx_out(10 downto 4),
            gt0_rxmonitorsel_in             => vio_rx_in_sync(8 downto 7),
            gt0_rxoutclkfabric_out          => clk_fabric_rx,
            gt0_gtrxreset_in                => vio_rx_in_sync(9),
            gt0_rxpmareset_in               => vio_rx_in_sync(10),
            gt0_rxslide_in                  => vio_rx_in_sync(11),
            gt0_rxresetdone_out             => vio_rx_out(11),
            
            --------------------------------- TX Ports ---------------------------------
            gt0_gttxreset_in                => vio_tx_in_sync(0),
            gt0_txuserrdy_in                => vio_tx_in_sync(1),
            gt0_txprbsforceerr_in           => vio_tx_in_sync(2),
            gt0_txbufstatus_out             => vio_tx_out(1 downto 0),
            gt0_txdata_in                   => vio_tx_in_sync(37 downto 6),
            gt0_gtxtxn_out                  => data_out_diff(1),
            gt0_gtxtxp_out                  => data_out_diff(0),
            gt0_txoutclkfabric_out          => open,
            gt0_txoutclkpcs_out             => clk_pcs_tx,
            gt0_txresetdone_out             => vio_tx_out(2),
            gt0_txprbssel_in                => vio_tx_in_sync(5 downto 3),
            
            --____________________________COMMON PORTS________________________________
            GT0_QPLLPD_IN                   => qpll_pd,                   
            GT0_QPLLLOCK_OUT                => qpll_lckd,
            GT0_QPLLREFCLKLOST_OUT          => qpll_ref_lost,
            GT0_QPLLOUTCLK_OUT              => open,
            GT0_QPLLOUTREFCLK_OUT           => open
    );



    ----------------------------------
    --            VIO's             --
    ---------------------------------- 

    i_vio_tra_set : vio_tra_set
    port map (
        clk         => clk_sys_div2,
        probe_in0   => trans_rx_done,
        probe_in1   => trans_tx_done,
        probe_in2   => qpll_lckd,
        probe_in3   => qpll_ref_lost,
        probe_in4   => digital_monitor,
        probe_in5   => eye_data_err,
        probe_out0  => trans_rx_rst,
        probe_out1  => trans_tx_rst,
        probe_out2  => trans_rst_on_err,
        probe_out3  => trans_valid_data,
        probe_out4  => qpll_pd,
        probe_out5  => eye_scan_rst,
        probe_out6  => eye_scan_trig
    );
    
    i_vio_drp : vio_drp
    port map (
      clk         => clk_sys_div2,
      probe_in0   => drp_dout,
      probe_in1   => drp_rdy,
      probe_out0  => drp_addr,
      probe_out1  => drp_din,
      probe_out2  => drp_wen,
      probe_out3  => drp_en
    );
   
    i_vio_rx : vio_Rx
    port map (
      clk         => clk_sys_div2,
      probe_in0   => vio_rx_out_sync(0),
      probe_in1   => vio_rx_out_sync(3 downto 1),
      probe_in2   => vio_rx_out_sync(10 downto 4),
      probe_in3   => vio_rx_out_sync(11),
      probe_out0  => vio_rx_in(0),
      probe_out1  => vio_rx_in(3 downto 1),
      probe_out2  => vio_rx_in(4),
      probe_out3  => vio_rx_in(5),
      probe_out4  => vio_rx_in(6),
      probe_out5  => vio_rx_in(8 downto 7),
      probe_out6  => vio_rx_in(9),
      probe_out7  => vio_rx_in(10),
      probe_out8  => vio_rx_in(11)
    );

    i_ila_rx_data : ila_Rx_data
    port map (
        clk     => clk_sys_div2,
        probe0  => vio_rx_out_sync(43 downto 12)
    );
        
    i_vio_tx : vio_Tx
    port map (
      clk         => clk_sys_div2,
      probe_in0   => vio_tx_out_sync(1 downto 0),
      probe_in1   => vio_tx_out_sync(2),
      probe_out0  => vio_tx_in(0),
      probe_out1  => vio_tx_in(1),
      probe_out2  => vio_tx_in(2),
      probe_out3  => vio_tx_in(5 downto 3),
      probe_out4  => vio_tx_in(37 downto 6)
    );
    
end Behavioral;
