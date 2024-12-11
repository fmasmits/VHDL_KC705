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
    signal mmcm_lck_ind     : std_logic;
    signal mmcm_rst         : std_logic;
    signal clk_6MHz         : std_logic;
    signal clk_12MHz        : std_logic;
    
    
    ----------------------------------
    --           Components         --
    ----------------------------------
    component mmcm_sys_clk
    port
    (
        clk_sys           : in     std_logic;
        clk_out_lf1       : out    std_logic;
        clk_out_lf2       : out    std_logic;
        reset             : in     std_logic;
        locked            : out    std_logic
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

    IBUFDS_sys_clc : IBUFDS
    port map (
        I   => clk_sys_in_diff(0),     
        IB  => clk_sys_in_diff(1),   
        O   => clk_sys_in     
    );
    
    mmcm_sys_clk_wiz : mmcm_sys_clk
    port map ( 
       clk_sys      => clk_sys_in,
       clk_out_lf1  => clk_6MHz,
       clk_out_lf2  => clk_12MHz,     
       reset        => mmcm_rst,
       locked       => mmcm_lck_ind
    );
    
    vio_mmcm_lock_reset : vio_mmcm
    port map (
        clk         => clk_sys_in,
        probe_in0   => mmcm_lck_ind,
        probe_out0  => mmcm_rst
    );
    
    OBUF_sys_clk : OBUF
    port map (
        I => clk_6MHz,
        O => clk_sys_out
    );
    
    
end Behavioral;
