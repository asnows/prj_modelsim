onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/sys_clk
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f1_cnt
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/sh
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f1
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2b
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/rs
add wave -noupdate -expand -group TCD1209D_driver -color Red /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/cp
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/status
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/sh_reg
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f1_reg
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f1_dly
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2_reg
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/f2b_reg
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/rs_reg
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/cp_reg
add wave -noupdate -expand -group TCD1209D_driver -radix unsigned /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/pxl_cnt
add wave -noupdate -expand -group TCD1209D_driver /glbl/top_tb_i/TCD1209D_i/TCD1209D_driver_I/div_cnt
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sys_clk
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Oper
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Ctrl
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Clamp
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/VGA_Gain
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/cfg_en
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SDATA
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SCK
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/SL
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/status
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Oper_dly
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Ctrl_dly
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/Clamp_dly
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/VGA_Gain_dly
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/cfg_en_dly
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/data_cnt
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sck_div
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sdata_reg
add wave -noupdate -group AD9945_cfg /glbl/top_tb_i/TCD1209D_i/AD9945_cfg_I/sl_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/sys_clk
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/sh
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/f2
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/rs
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/SHP
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/SHD
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/DATACLK
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/CLPOB
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/PBLK
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/DATA_IN
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tdata
add wave -noupdate -expand -group AD9945_driver -color Red /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tvalid
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/state
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/sh_dly
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/shp_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/shd_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/dataclk_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/tvalid_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/clpob_reg
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/f2_dly
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/rs_dly
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/shp_dly
add wave -noupdate -expand -group AD9945_driver /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/clk_cnt
add wave -noupdate -expand -group AD9945_driver -radix unsigned /glbl/top_tb_i/TCD1209D_i/AD9945_driver_i/samp_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2105090000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 349
configure wave -valuecolwidth 219
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
WaveRestoreZoom {2014495696 ps} {2195684304 ps}
