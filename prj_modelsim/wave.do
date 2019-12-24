onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/clk
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/reset
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/m_axis_tdata
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/m_axis_tlast
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/m_axis_tready
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/m_axis_tuser
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/m_axis_tvalid
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/data_reg
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/tvaild_reg
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/tuser_reg
add wave -noupdate -group axis_master /glbl/top_tb_i/axis_master_I/tlast_reg
add wave -noupdate -group axis_master -radix decimal /glbl/top_tb_i/axis_master_I/nums
add wave -noupdate -group gen_txc /glbl/top_tb_i/eth_mac_I/eth_send_I/gen_txc_I/sys_clk
add wave -noupdate -group gen_txc /glbl/top_tb_i/eth_mac_I/eth_send_I/gen_txc_I/tx_dclk
add wave -noupdate -group gen_txc /glbl/top_tb_i/eth_mac_I/eth_send_I/gen_txc_I/tx_clk
add wave -noupdate -group gen_txc /glbl/top_tb_i/eth_mac_I/eth_send_I/gen_txc_I/dclk_count
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/IP_Flags
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/IP_FraOff
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/ip_enable
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/IP_TotLen
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/IP_SrcAddr
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/IP_DestAddr
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_aclk
add wave -noupdate -group ip -color Red -itemcolor Red /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_tdata
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_tlast
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_tready
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_tuser
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_axis_tvalid
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_axis_tdata
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_axis_tlast
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_axis_tready
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_axis_tuser
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_axis_tvalid
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/state
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/ip_Check
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/ip_headCheck
add wave -noupdate -group ip -color Red -itemcolor Red -radix decimal /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/counts
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tdata_dly
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tlast_dly
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tready_dly
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tuser_dly
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tvalid_dly
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/s_tready_reg
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_tdata_reg
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_tlast_reg
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_tuser_reg
add wave -noupdate -group ip /glbl/top_tb_i/eth_mac_I/eth_send_I/ip_datagram_I/m_tvalid_reg
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/dst_mac
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/src_mac
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/eth_type
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_aclk
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_tdata
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_tlast
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_tready
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_tuser
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_axis_tvalid
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/m_axis_tdata
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/m_axis_tvalid
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/state
add wave -noupdate -group eth -radix decimal /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/counts
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/s_tdata_reg
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/tready_reg
add wave -noupdate -group eth /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/crc_data
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/mac_tx_I/clk
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/mac_tx_I/tvalid
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/mac_tx_I/tdata
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/mac_tx_I/tx_en
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/mac_tx_I/txd
add wave -noupdate -expand -group mac_tx /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/m_tdata_reg
add wave -noupdate /glbl/top_tb_i/eth_mac_I/eth_send_I/eth_datagram_I/m_tvalid_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/UDP_SrcPort
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/UDP_DestPort
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/UDP_TotLen
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/UDP_CheckSum
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/udp_enable
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_aclk
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_tdata
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_tlast
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_tready
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_tuser
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_axis_tvalid
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_axis_tdata
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_axis_tlast
add wave -noupdate -group udp -color Red -itemcolor Red /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_axis_tready
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_axis_tuser
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_axis_tvalid
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/state
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tdata_dly
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tdata_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tlast_dly
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tuser_dly
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tvalid_dly
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/s_tready_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_tdata_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_tlast_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_tuser_reg
add wave -noupdate -group udp /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/m_tvalid_reg
add wave -noupdate /glbl/top_tb_i/eth_mac_I/eth_send_I/udp_datagram_I/counts
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/sys_clk
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/dst_mac
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/src_mac
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/eth_type
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/IP_TotLen
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/IP_SrcAddr
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/IP_DestAddr
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/UDP_SrcPort
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/UDP_DestPort
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/UDP_TotLen
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_aclk
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_tdata
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_tlast
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_tready
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_tuser
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/s_axis_tvalid
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/tx_data_clk
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/tx_clk
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/txd
add wave -noupdate -expand -group eth_mac /glbl/top_tb_i/eth_mac_I/tx_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {260000 ps} 0} {{Cursor 2} {256100 ps} 1}
quietly wave cursor active 1
configure wave -namecolwidth 498
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
WaveRestoreZoom {194464 ps} {325536 ps}
