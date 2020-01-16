onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/clk
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/read_en
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/data_valid
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/data_out
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/read_count
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/rd_data
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/valid_reg
add wave -noupdate -group img_read_file /glbl/top_tb_i/tb_img_I/read_file_i/data_rd
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/vsync
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_aclk
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_tready
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_tdata
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_tkeep
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_tlast
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/s_axis_tvalid
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/m_axis_tdata
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/m_axis_tlast
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/m_axis_tuser
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/m_axis_tvalid
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/m_axis_tready
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/row_pixels_count
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/tlast_tmp
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/tuser_tmp
add wave -noupdate -group img_video_cap /glbl/top_tb_i/tb_img_I/video_caputure_0_i/tuser
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_aclk
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tdata
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tlast
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tuser
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tvalid
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tready
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_0_tlast
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_0_tuser
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_0_tvalid
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_0_tdata
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_1_tlast
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_1_tuser
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_1_tvalid
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_1_tdata
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_2_tlast
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_2_tuser
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_2_tvalid
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/m_axis_line_buff_2_tdata
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tdata_dly1
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tdata_dly2
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tdata_dly3
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tdata_dly4
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tlast_dly1
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tlast_dly2
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tlast_dly3
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tlast_dly4
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tuser_dly1
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tuser_dly2
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tuser_dly3
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tuser_dly4
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tvalid_dly1
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tvalid_dly2
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tvalid_dly3
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/s_axis_tvalid_dly4
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_0_tdata_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_tdata_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_tdata_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_0_tlast_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_tlast_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_tlast_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_0_tuser_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_tuser_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_tuser_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_0_tvalid_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_tvalid_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_tvalid_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_count
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/tlast_reg
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/compelet_count
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_tlast_rise
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/compelet_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/srst_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/fifo_1_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/fifo_2_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/srst_1_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/srst_2_reset
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_dout_1
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_dout_2
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_rd
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_rd
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_wr
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_wr
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_wr_ctrl
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1_rd_ctrl
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_wr_ctrl
add wave -noupdate -group img_maxtri3x3 /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_2_rd_ctrl
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/ALMOSTEMPTY
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/ALMOSTFULL
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/DBITERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/DO
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/DOP
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/ECCPARITY
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/EMPTY
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/FULL
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RDCOUNT
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RDERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/SBITERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/WRCOUNT
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/WRERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/DI
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/DIP
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/INJECTDBITERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/INJECTSBITERR
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RDCLK
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RDEN
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/REGCE
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RST
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/RSTREG
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/WRCLK
add wave -noupdate -group img_FIFO36E /glbl/top_tb_i/tb_img_I/maxtri3x3_shift_i/line_buff_1/FIFO36E1_inst/WREN
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/clk
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/write_en
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/stop_en
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/data_in
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/done
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/write_count
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/done_reg
add wave -noupdate -expand -group img_write_file /glbl/top_tb_i/tb_img_I/write_file_0/data_wr0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {396000 ps} 1} {{Cursor 2} {25883277043 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 418
configure wave -valuecolwidth 92
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
WaveRestoreZoom {24956894010 ps} {29730550842 ps}
