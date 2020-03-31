onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/sys_clk
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/f2
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/rs
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/cp
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/shp
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/shd
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/dataclk
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/clk_div
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/f2_reg
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/rs_reg
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/cp_reg
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/shp_reg
add wave -noupdate -group genClk /glbl/top_tb_i/TCD1209D_i/genClk_I/shd_reg
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/pxl_clk
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/triggerMode
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/extTrigger
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f_cnt
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/sh_puls
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2_puls
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/rs_puls
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/os_tvalid
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/status
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/wait_cnt
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/pxl_cnt
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/sh_reg
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2_reg
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/rs_reg
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/tvalid_reg
add wave -noupdate -group TCD1209D_DRV /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/ext_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sys_clk
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Oper
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Ctrl
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Clamp
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/VGA_Gain
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/cfg_en
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SDATA
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SCK
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SL
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/status
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Oper_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Ctrl_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Clamp_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/VGA_Gain_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/cfg_en_dly
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/data_cnt
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sck_clk
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sdata_reg
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sl_reg
add wave -noupdate -group AD9945_CFG /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/div_cnt
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/pxl_clk
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/os_tvalid
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/CLPOB
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/PBLK
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/DATA_IN
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tdata
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tvalid
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/clpob_reg
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/os_tvalid_dly
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tdata_reg
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/clk_cnt
add wave -noupdate -group AD9945_DRV /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/samp_cnt
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/pixel_clk
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tvalid
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tdata
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/rows
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/m_axis_tdata
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/m_axis_tlast
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/m_axis_tuser
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/m_axis_tvalid
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/m_axis_tready
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/state
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/rows_count
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/cols_count
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/sh_dly
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tvalid_dly
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tuser_reg
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tlast_reg
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tvalid_reg
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tdata_reg
add wave -noupdate -group CCD2AXIS /glbl/top_tb_i/TCD1209D_i/ccd2axis_i/tdata_reg1
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/sys_clk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/triggerMode
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/extTrigger
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f_cnt
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/sh
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f1
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f2
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/rs
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/cp
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/Oper
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/Ctrl
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/Clamp
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/VGA_Gain
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/cfg_en
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/SDATA
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/SCK
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/SL
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/SHP
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/SHD
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/DATACLK
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/CLPOB
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/PBLK
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/DATA_IN
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/rows
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_tdata
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_tlast
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_tuser
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_tvalid
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_tready
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_axis_aclk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/pxl_clk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f2_clk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/rs_clk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/cp_clk
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/sh_puls
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f2_puls
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/f2_tmp
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/rs_puls
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/cp_puls
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/os_tvalid
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/m_tdata
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/AD9945_tdata
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/AD9945_tvalid
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/AD9945_tdata_reg
add wave -noupdate -group tcd1209d /glbl/top_tb_i/TCD1209D_i/AD9945_tvalid_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7510 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 335
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {218727 ps}
