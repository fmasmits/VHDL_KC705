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
        clk_sys_in_diff     : in    std_logic_vector(1 downto 0);
        clk_sys_out         : out   std_logic
    );
    
end KC705_top;

architecture Behavioral of KC705_top is
    
    ----------------------------------
    --            Signals           --
    ----------------------------------
    signal clk_sys_in       : std_logic;
    signal clk_sys_gl       : std_logic;
    signal mmcm_lck_ind     : std_logic;
    signal mmcm_rst         : std_logic;
    signal clk_lf           : std_logic;
    signal clk_lf_div2      : std_logic;
    signal clk_trans        : std_logic;
    
    
    ----------------------------------
    --           Components         --
    ----------------------------------
    component mmcm_sys_clk_wiz
    port
    (
        clk_in          : in     std_logic;
        clk_out_lf      : out    std_logic;
        clk_out_lfdiv2  : out    std_logic;
        clk_out_trans   : out    std_logic;
        reset           : in     std_logic;
        locked          : out    std_logic
    );
    end component;
    
    component vio_mmcm
    port (
        clk         : in    std_logic;
        probe_in0   : in    std_logic;
        probe_out0  : out   std_logic 
    );
    end component;
 
begin

    IBUFGDS_sys_clc : IBUFGDS
    port map (
        I   => clk_sys_in_diff(0),     
        IB  => clk_sys_in_diff(1),   
        O   => clk_sys_gl     
    );
    
    mmcm_sys_clk : mmcm_sys_clk_wiz
    port map ( 
       clk_in           => clk_sys_gl,
       clk_out_lf       => clk_lf,          --6.25  MHz clock signal
       clk_out_lfdiv2   => clk_lf_div2,     --12.50 MHz clock signal
       clk_out_trans    => clk_trans,       --160   MHz clock signal
       reset            => mmcm_rst, 
       locked           => mmcm_lck_ind
    );
    
    vio_mmcm_lck_rst : vio_mmcm
    port map (
        clk         => clk_sys_gl,
        probe_in0   => mmcm_lck_ind,
        probe_out0  => mmcm_rst
    );
    
    OBUF_sys_clk : OBUF
    port map (
        I => clk_lf,
        O => clk_sys_out
    );
    
    
end Behavioral;
