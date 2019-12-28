onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tx_clk_gen /glbl/top_tb_i/mac_I/mac_tx_I/tx_clk_gen_I/sys_clk
add wave -noupdate -group tx_clk_gen /glbl/top_tb_i/mac_I/mac_tx_I/tx_clk_gen_I/tx_dclk
add wave -noupdate -group tx_clk_gen /glbl/top_tb_i/mac_I/mac_tx_I/tx_clk_gen_I/tx_clk
add wave -noupdate -group tx_clk_gen /glbl/top_tb_i/mac_I/mac_tx_I/tx_clk_gen_I/dclk_count
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_opcode
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_srcMac
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_srcIP
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_destMac
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_destIP
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_enable
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_aclk
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_tdata
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_tlast
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_tready
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_tuser
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_axis_tvalid
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_axis_tdata
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_axis_tlast
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_axis_tready
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_axis_tuser
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_axis_tvalid
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/state
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/counts
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_opcode_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_srcMac_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_srcIP_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_destMac_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/arp_destIP_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tdata_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tdata_reg
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tlast_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tuser_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tvalid_dly
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/s_tready_reg
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_tdata_reg
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_tlast_reg
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_tuser_reg
add wave -noupdate -group tx_arp /glbl/top_tb_i/mac_I/mac_tx_I/tx_arp_I/m_tvalid_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/UDP_SrcPort
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/UDP_DestPort
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/UDP_TotLen
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/UDP_CheckSum
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/udp_enable
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_aclk
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_tdata
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_tlast
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_tready
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_tuser
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_axis_tvalid
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_axis_tdata
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_axis_tlast
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_axis_tready
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_axis_tuser
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_axis_tvalid
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/state
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/counts
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tdata_dly
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tdata_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tlast_dly
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tuser_dly
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tvalid_dly
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/s_tready_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_tdata_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_tlast_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_tuser_reg
add wave -noupdate -group tx_udp /glbl/top_tb_i/mac_I/mac_tx_I/tx_udp_I/m_tvalid_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/IP_TotLen
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/IP_SrcAddr
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/IP_DestAddr
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/ip_enable
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_aclk
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_tdata
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_tlast
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_tready
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_tuser
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_axis_tvalid
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_axis_tdata
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_axis_tlast
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_axis_tready
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_axis_tuser
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_axis_tvalid
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/state
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/ip_Check
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/ip_headCheck
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/counts
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tdata_dly
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tdata_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tlast_dly
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tready_dly
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tuser_dly
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tvalid_dly
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/s_tready_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_tdata_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_tlast_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_tuser_reg
add wave -noupdate -group tx_ip /glbl/top_tb_i/mac_I/mac_tx_I/tx_ip_I/m_tvalid_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/dst_mac
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/src_mac
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/eth_type
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_aclk
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_tdata
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_tlast
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_tready
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_tuser
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_axis_tvalid
add wave -noupdate -group tx_eth -color Red -itemcolor Red -radix hexadecimal /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_axis_tdata
add wave -noupdate -group tx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_axis_tvalid
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_tdata_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_tdata_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_tvalid_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/m_tvalid_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/state
add wave -noupdate -group tx_eth -radix decimal /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/counts
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_tdata_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_tdata_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_tlast_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_tuser_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/s_tvalid_dly
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/tready_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/fcs_en
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/fcs_reset
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/fcs_out
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/fcs_data_reg
add wave -noupdate -group tx_eth /glbl/top_tb_i/mac_I/mac_tx_I/tx_eth_I/fcs_data
add wave -noupdate -group tx_oper /glbl/top_tb_i/mac_I/mac_tx_I/tx_oper_I/clk
add wave -noupdate -group tx_oper /glbl/top_tb_i/mac_I/mac_tx_I/tx_oper_I/tvalid
add wave -noupdate -group tx_oper /glbl/top_tb_i/mac_I/mac_tx_I/tx_oper_I/tdata
add wave -noupdate -group tx_oper /glbl/top_tb_i/mac_I/mac_tx_I/tx_oper_I/tx_en
add wave -noupdate -group tx_oper /glbl/top_tb_i/mac_I/mac_tx_I/tx_oper_I/txd
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/dst_mac
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/src_mac
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/eth_type
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_aclk
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_tdata
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_tvalid
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tdata
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tlast
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tready
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tuser
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tvalid
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/dst_mac_reg
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/src_mac_reg
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/eth_type_reg
add wave -noupdate -expand -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tdata_reg
add wave -noupdate -expand -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tvalid_reg
add wave -noupdate -expand -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tuser_reg
add wave -noupdate -expand -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tlast_reg
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/state
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/counts
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_tdata_dly
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_tvalid_dly
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_en
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_reset
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_data_reg
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_err_reg
add wave -noupdate -expand -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {396000 ps} 1} {{Cursor 2} {9644942 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 418
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
WaveRestoreZoom {9615328 ps} {9672672 ps}
