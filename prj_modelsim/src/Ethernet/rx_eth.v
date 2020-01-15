/*
模块名称：rx_eth
功能：
	拆封以太网帧，获取以太网帧头。
接口：
	dst_mac	:目的MAC。
	src_mac :源MAC。
	eth_type:以太网类型。

设计原理：
	状态机:
	STATE_IDEL =空闲状态,此状态下，等待一帧的开始信号tvalid上升沿，当接收到上游的tvalid上升沿时，跳转到STATE_PREA
	STATE_PREA = 开始接收前导码。
	STATE_HEAD = 接收帧头，接收完帧头后，产生tuser 和tvalid 给下游接收模块使用。
	STATE_DATA = 继续接收上游传来的数据，检测到上游的tvalid下降沿后跳转到STATE_IDEL，并做FCS验证。
	
*/


module rx_eth
(

output[47:0] dst_mac	,
output[47:0] src_mac	,
output[15:0] eth_type	,
input 	    s_axis_aclk		,
input[7:0]  s_axis_tdata    ,
input       s_axis_tvalid   ,

output[7:0]  m_axis_tdata    ,
output       m_axis_tlast    ,
input        m_axis_tready   ,
output       m_axis_tuser    ,
output       m_axis_tvalid   ,
output		 fcs_err
  
);

localparam HSM = 8'd39,LSM=8'd32;
localparam STATE_IDEL = 3'd0,STATE_PREA = 3'd1,STATE_HEAD = 3'd2,STATE_DATA = 3'd3,STATE_CRC = 3'd4;
reg[7:0]   preamble[7:0];

reg[47:0] dst_mac_reg ;
reg[47:0] src_mac_reg ;
reg[15:0] eth_type_reg;

reg[7:0] m_tdata_reg = 8'hff;
reg 	 m_tvalid_reg = 1'b0;
reg 	 m_tuser_reg = 1'b0;
reg 	 m_tlast_reg = 1'b0;

reg[31:0] 	m_tdata_dly ;
reg[3:0] 	m_tvalid_dly;
reg[3:0]  	m_tuser_dly ;
reg[3:0]  	m_tlast_dly ;







reg[2:0] state = STATE_IDEL;
reg[2:0] state2 = STATE_IDEL;
reg[7:0] counts = 8'd0;
reg[7:0] counts2 = 8'd0;

reg[39:0] s_tdata_dly ;
reg[4:0]  s_tvalid_dly;


reg			fcs_en = 1'b0;
reg			fcs_reset = 1'b0;


reg  [7:0]  fcs_data_reg;
wire [31:0] fcs_data;
reg fcs_err_reg = 1'b0;







assign dst_mac  = dst_mac_reg  ;
assign src_mac  = src_mac_reg  ;
assign eth_type = eth_type_reg ;
assign m_axis_tdata  = m_tdata_reg ;
assign m_axis_tlast  = m_tlast_reg ;
assign m_axis_tuser	 = m_tuser_reg ;
assign m_axis_tvalid = m_tvalid_reg;
assign fcs_err = fcs_err_reg;



always@(posedge s_axis_aclk)
begin

	s_tvalid_dly <= {s_tvalid_dly[4:0],s_axis_tvalid} ;
	s_tdata_dly  <= {s_tdata_dly[31:0],s_axis_tdata}  ;
				
end


always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			m_tdata_reg  <= 8'hff;
			m_tvalid_reg <= 1'b0;
			m_tlast_reg  <= 1'b0; 	
			fcs_en <= 1'b0;
		    			
			if((~s_tvalid_dly[4]) & s_tvalid_dly[3])
			begin
				state <= STATE_PREA;
				fcs_reset <= 1'b0;	
				fcs_err_reg <=1'b0;				
				
			end
			else
			begin
				state <= STATE_IDEL;
				fcs_reset <= 1'b1;				
			end					
		end
		STATE_PREA:
		begin
			counts <= counts + 1'b1;
			
			preamble[7 - counts] <= s_tdata_dly[HSM:LSM];
			
			if(counts == 8'd6)
			begin
				fcs_en <= 1'b1;
			end
			
			
			if(counts == 8'd7)
			begin
				state <= STATE_HEAD;
				counts <= 8'd0;
				
			end
			
		end
		STATE_HEAD:
		begin
			counts <= counts + 1'b1;
			case(counts)
				// dst_mac
				8'd0:
				begin
					dst_mac_reg[47:40] <= s_tdata_dly[HSM:LSM] ;
					
				end
				8'd1:
				begin
					dst_mac_reg[39:32] <= s_tdata_dly[HSM:LSM];
				end
				8'd2:
				begin
					dst_mac_reg[31:24] <= s_tdata_dly[HSM:LSM];
				end
				8'd3:
				begin
					dst_mac_reg[23:16] <= s_tdata_dly[HSM:LSM];
				end
				8'd4:
				begin
					dst_mac_reg[15:8] <= s_tdata_dly[HSM:LSM];
				end
				8'd5:
				begin
					dst_mac_reg[7:0] <= s_tdata_dly[HSM:LSM];
				end
				// src_mac
				8'd6:
				begin
					src_mac_reg[47:40] <= s_tdata_dly[HSM:LSM];
				end
				8'd7:
				begin
					src_mac_reg[39:32] <= s_tdata_dly[HSM:LSM];
				end
				8'd8:
				begin
					src_mac_reg[31:24] <= s_tdata_dly[HSM:LSM];
				end
				8'd9:
				begin
					src_mac_reg[23:16] <= s_tdata_dly[HSM:LSM];
				end
				8'd10:
				begin
					src_mac_reg[15:8]  <= s_tdata_dly[HSM:LSM];
				end
				8'd11:
				begin
					src_mac_reg[7:0]  <= s_tdata_dly[HSM:LSM];
				end
				
				// eth_type
				8'd12:
				begin
					eth_type_reg[15:8]<= s_tdata_dly[HSM:LSM];
				end
				8'd13:
				begin
					eth_type_reg[7:0]<= s_tdata_dly[HSM:LSM];
				end	
				
				8'd14:
				begin
					m_tuser_reg 	<= 1'b1;
					m_tdata_reg 	<= s_tdata_dly[HSM:LSM];
					m_tvalid_reg    <= 1'b1;
					state <= STATE_DATA;
				end	

				
			endcase					
		end
		STATE_DATA:
		begin
			m_tdata_reg 	<= s_tdata_dly[HSM:LSM];
			m_tvalid_reg    <= s_tvalid_dly[0];
			m_tuser_reg 	<= 1'b0;
			counts 		    <= 8'd0;
			
			if(s_tvalid_dly[0] & (~s_axis_tvalid))
			begin			
				state <= STATE_IDEL;
				m_tlast_reg <= 1'b1; 

				if(fcs_data == s_tdata_dly[31:0])
				begin
					fcs_err_reg <= 1'b0;
				end
				else
				begin
					fcs_err_reg <= 1'b1;
				end

				
			end			
		end	
		
		default:
		begin
			state <= STATE_IDEL;
		end

	endcase

end




 eth_fcs eth_fcs_I
 (
	 .Clk	(s_axis_aclk), 
	 .Reset	(fcs_reset), 
	 .Data_in(s_tdata_dly[31:24]), 
	 .Enable(fcs_en), 
	 .Crc   (fcs_data),
	 .CrcNext()
 );
 

endmodule