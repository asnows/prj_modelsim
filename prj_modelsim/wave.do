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
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/vsync
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_aclk
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_tready
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_tdata
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_tkeep
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_tlast
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/s_axis_tvalid
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/m_axis_tdata
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/m_axis_tlast
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/m_axis_tuser
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/m_axis_tvalid
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/m_axis_tready
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/row_pixels_count
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/tlast_tmp
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/tuser_tmp
add wave -noupdate -group video_cap /glbl/top_tb_i/video_caputure_0_i/tuser
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/clk
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/read_en
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/data_valid
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/data_out
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/read_count
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/rd_data
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/valid_reg
add wave -noupdate -group read_file /glbl/top_tb_i/read_file_i/data_rd
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
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/dst_mac
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/src_mac
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/eth_type
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_aclk
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_tdata
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_axis_tvalid
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tdata
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tlast
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tready
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tuser
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_axis_tvalid
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/dst_mac_reg
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/src_mac_reg
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/eth_type_reg
add wave -noupdate -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tdata_reg
add wave -noupdate -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tvalid_reg
add wave -noupdate -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tuser_reg
add wave -noupdate -group rx_eth -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/m_tlast_reg
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/state
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/counts
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_tdata_dly
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/s_tvalid_dly
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_en
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_reset
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_data_reg
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_err_reg
add wave -noupdate -group rx_eth /glbl/top_tb_i/mac_I/mac_rx_I/rx_eth_I/fcs_data
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_TotLen
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_Protocol
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_SrcAddr
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_DestAddr
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_enable
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_aclk
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_tdata
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_tlast
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_tready
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_tuser
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_axis_tvalid
add wave -noupdate -group rx_ip -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_axis_tdata
add wave -noupdate -group rx_ip -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_axis_tlast
add wave -noupdate -group rx_ip -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_axis_tready
add wave -noupdate -group rx_ip -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_axis_tuser
add wave -noupdate -group rx_ip -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_axis_tvalid
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_Check_err
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_Version_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_HeaderLen_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_TOS_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_TotLen_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_ID_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_Flags_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_FraOff_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_TTL_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_Protocol_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_headCheck_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_SrcAddr_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/IP_DestAddr_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_Check_err_Reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/state
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_Check
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_headCheck
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/counts
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tdata_dly
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tlast_dly
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tready_dly
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tuser_dly
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tvalid_dly
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/s_tready_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_tdata_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_tlast_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_tuser_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/m_tvalid_reg
add wave -noupdate -group rx_ip /glbl/top_tb_i/mac_I/mac_rx_I/rx_ip_I/ip_Check_enable
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_SrcPort
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_DestPort
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_TotLen
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_CheckSum
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/udp_enable
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_aclk
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_tdata
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_tlast
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_tready
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_tuser
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_axis_tvalid
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_axis_tdata
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_axis_tlast
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_axis_tready
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_axis_tuser
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_axis_tvalid
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/state
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_SrcPort_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_DestPort_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_TotLen_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/UDP_CheckSum_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/counts
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_tdata_dly
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_tlast_dly
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_tuser_dly
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_tvalid_dly
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/s_tready_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_tdata_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_tlast_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_tuser_reg
add wave -noupdate -group rx_udp /glbl/top_tb_i/mac_I/mac_rx_I/rx_udp_I/m_tvalid_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_opcode
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_srcMac
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_srcIP
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_destMac
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_destIP
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_enable
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_aclk
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_tdata
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_tlast
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_tready
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_tuser
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_axis_tvalid
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_axis_tdata
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_axis_tlast
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_axis_tready
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_axis_tuser
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_axis_tvalid
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/ARP_HwType_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/ARP_Proto_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/ARP_HwLen_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/ARP_ProtoLen_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/state
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/counts
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_opcode_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_srcMac_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_srcIP_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_destMac_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/arp_destIP_reg
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_tdata_dly
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_tlast_dly
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_tuser_dly
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_tvalid_dly
add wave -noupdate -group rx_arp /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/s_tready_reg
add wave -noupdate -group rx_arp -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_tdata_reg
add wave -noupdate -group rx_arp -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_tlast_reg
add wave -noupdate -group rx_arp -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_tuser_reg
add wave -noupdate -group rx_arp -color Red -itemcolor Red /glbl/top_tb_i/mac_I/mac_rx_I/rx_arp_I/m_tvalid_reg
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/clk
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/write_en
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/stop_en
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/data_in
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/done
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/write_count
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/done_reg
add wave -noupdate -group write_file /glbl/top_tb_i/write_file_0/data_wr0
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
