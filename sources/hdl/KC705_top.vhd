library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use UNISIM.vcomponents.ALL;

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

    Port ( 
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
    
    signal rx_usr_rdy       : std_logic;
    signal rx_prbs_err      : std_logic;
    signal rx_buf_stat      : std_logic_vector(2 downto 0);
    signal rx_monitor       : std_logic_vector(6 downto 0);
    signal rx_rst_done      : std_logic;
    signal rx_prbs_sel      : std_logic_vector(2 downto 0);
    signal rx_prbs_cntr_rst : std_logic;
    signal rx_buf_rst       : std_logic;
    signal rx_dfe_lpm_rst   : std_logic;
    signal rx_monitor_sel   : std_logic_vector(1 downto 0);
    signal rx_gtrx_rst      : std_logic;
    signal rx_pma_rst       : std_logic;
    signal rx_slide         : std_logic;
    
    signal tx_buf_stat      : std_logic_vector(1 downto 0);
    signal tx_rst_done      : std_logic;
    signal tx_usr_rdy       : std_logic;
    signal tx_prbs_sel      : std_logic_vector(2 downto 0);
    signal tx_prbs_frc_err  : std_logic;
    signal tx_gttx_rst      : std_logic;
    
    signal digital_monitor  : std_logic_vector(7 downto 0);
    signal eye_scan_rst     : std_logic;
    signal eye_data_err     : std_logic;
    signal eye_scan_trig    : std_logic;
    
    signal rx_data_in       : std_logic_vector(31 downto 0);
    signal tx_data_out      : std_logic_vector(31 downto 0);
    
    ----------------------------------
    --           Components         --
    ---------------------------------- 
    component vio_tra_set
    port (
        clk         : in    std_logic;
        probe_in0   : in    std_logic;                      -- trans
        probe_in1   : in    std_logic;                      -- trans
        probe_in2   : in    std_logic_vector(15 downto 0);  -- drp
        probe_in3   : in    std_logic;                      -- drp
        probe_in4   : in    std_logic;                      -- qpll
        probe_in5   : in    std_logic;                      -- qpll   
        probe_in6   : in    std_logic_vector(7 downto 0);   -- misc
        probe_in7   : in    std_logic;                      -- misc
        probe_out0  : out   std_logic;                      -- trans
        probe_out1  : out   std_logic;                      -- trans
        probe_out2  : out   std_logic;                      -- trans
        probe_out3  : out   std_logic;                      -- trans
        probe_out4  : out   std_logic_vector(8  downto 0);  -- drp
        probe_out5  : out   std_logic_vector(15 downto 0);  -- drp
        probe_out6  : out   std_logic;                      -- drp
        probe_out7  : out   std_logic;                      -- drp
        probe_out8  : out   std_logic;                      -- qpll 
        probe_out9  : out   std_logic;                      -- misc   
        probe_out10 : out   std_logic                       -- misc   
    );
    end component;
    
    component vio_RxTx
    port (
        clk         : in    std_logic;
        probe_in0   : in    std_logic;
        probe_in1   : in    std_logic_vector(2 downto 0);
        probe_in2   : in    std_logic_vector(6 downto 0);
        probe_in3   : in    std_logic;
        probe_in4   : in    std_logic_vector(1 downto 0);
        probe_in5   : in    std_logic;
        probe_out0  : out   std_logic;
        probe_out1  : out   std_logic_vector(2 downto 0);
        probe_out2  : out   std_logic;
        probe_out3  : out   std_logic;
        probe_out4  : out   std_logic;
        probe_out5  : out   std_logic_vector(1 downto 0);
        probe_out6  : out   std_logic;
        probe_out7  : out   std_logic;
        probe_out8  : out   std_logic;
        probe_out9  : out   std_logic;
        probe_out10 : out   std_logic;
        probe_out11 : out   std_logic;
        probe_out12 : out   std_logic_vector(2 downto 0)
    );
    end component;
    
    component ila_data_in
    port (
        clk         : in std_logic;
        probe0      : in std_logic_vector(31 downto 0);
        probe1      : in std_logic_vector(31 downto 0)    
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
        gt0_rxprbscntreset_in                   : in   std_logic;                           -- rx prbs control reset
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
    --           Components         --
    ----------------------------------
    IBUFGDS_sys_clk : IBUFGDS
    port map (
        I   => clk_sys_diff(0),
        IB  => clk_sys_diff(1),
        O   => clk_sys
    );
    
    trans_wiz_TxRx : trans_wiz
    port map (
            SOFT_RESET_TX_IN                => trans_tx_rst,
            SOFT_RESET_RX_IN                => trans_rx_rst,
            DONT_RESET_ON_DATA_ERROR_IN     => trans_rst_on_err,
        
            GT0_TX_FSM_RESET_DONE_OUT       => trans_tx_done,
            GT0_RX_FSM_RESET_DONE_OUT       => trans_rx_done,
            GT0_DATA_VALID_IN               => trans_valid_data,
            
            SYSCLK_IN                       => clk_sys,
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
            gt0_rxuserrdy_in                => rx_usr_rdy,
            gt0_rxprbserr_out               => rx_prbs_err,
            gt0_rxprbssel_in                => rx_prbs_sel,
            gt0_rxprbscntreset_in           => rx_prbs_cntr_rst,
            gt0_rxdata_out                  => rx_data_in,
            gt0_gtxrxp_in                   => data_in_diff(0),
            gt0_gtxrxn_in                   => data_in_diff(1),
            gt0_rxbufreset_in               => rx_buf_rst,
            gt0_rxbufstatus_out             => rx_buf_stat,
            gt0_rxdfelpmreset_in            => rx_dfe_lpm_rst,
            gt0_rxmonitorout_out            => rx_monitor,
            gt0_rxmonitorsel_in             => rx_monitor_sel,
            gt0_rxoutclkfabric_out          => open,
            gt0_gtrxreset_in                => rx_gtrx_rst,
            gt0_rxpmareset_in               => rx_pma_rst,
            gt0_rxslide_in                  => rx_slide,
            gt0_rxresetdone_out             => rx_rst_done,
            
            --------------------------------- TX Ports ---------------------------------
            gt0_gttxreset_in                => tx_gttx_rst,
            gt0_txuserrdy_in                => tx_usr_rdy,
            gt0_txprbsforceerr_in           => tx_prbs_frc_err,
            gt0_txbufstatus_out             => tx_buf_stat,
            gt0_txdata_in                   => tx_data_out,
            gt0_gtxtxn_out                  => data_out_diff(1),
            gt0_gtxtxp_out                  => data_out_diff(0),
            gt0_txoutclkfabric_out          => open,
            gt0_txoutclkpcs_out             => open,
            gt0_txresetdone_out             => tx_rst_done,
            gt0_txprbssel_in                => tx_prbs_sel,
    
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

    vio_transceiver_settings : vio_tra_set
    port map (
        clk         => clk_sys,
        probe_in0   => trans_rx_done,
        probe_in1   => trans_tx_done,
        probe_in2   => drp_dout,
        probe_in3   => drp_rdy,
        probe_in4   => qpll_lckd,
        probe_in5   => qpll_ref_lost,
        probe_in6   => digital_monitor,
        probe_in7   => eye_data_err,
        probe_out0  => trans_rx_rst,
        probe_out1  => trans_tx_rst,
        probe_out2  => trans_rst_on_err,
        probe_out3  => trans_valid_data,
        probe_out4  => drp_addr,
        probe_out5  => drp_din,
        probe_out6  => drp_wen,
        probe_out7  => drp_en,
        probe_out8  => qpll_pd,
        probe_out9  => eye_scan_rst,
        probe_out10 => eye_scan_trig
    );
    
    vio_rxtx_settings : vio_RxTx
    port map (
        clk         => clk_sys,
        probe_in0   => rx_prbs_err,
        probe_in1   => rx_buf_stat,
        probe_in2   => rx_monitor,
        probe_in3   => rx_rst_done,
        probe_in4   => tx_buf_stat,
        probe_in5   => tx_rst_done,
        probe_out0  => rx_usr_rdy,
        probe_out1  => rx_prbs_sel,
        probe_out2  => rx_prbs_cntr_rst,
        probe_out3  => rx_buf_rst,
        probe_out4  => rx_dfe_lpm_rst,
        probe_out5  => rx_monitor_sel,
        probe_out6  => rx_gtrx_rst,
        probe_out7  => rx_pma_rst,
        probe_out8  => rx_slide,
        probe_out9  => tx_gttx_rst,
        probe_out10 => tx_usr_rdy,
        probe_out11 => tx_prbs_frc_err,
        probe_out12 => tx_prbs_sel
    );
    
    ila_data_inout : ila_data_in
    port map (
        clk => clk_sys,
        probe0 => rx_data_in,
        probe1 => tx_data_out
    );
    
    
end Behavioral;
