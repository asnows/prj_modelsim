module tx_eth
(

input[47:0] dst_mac,
input[47:0] src_mac,
input[15:0] eth_type,
input 	    s_axis_aclk,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,

output[7:0] m_axis_tdata	,
output      m_axis_tvalid   
  
);


localparam STATE_IDEL = 3'd0,STATE_PREA = 3'd1,STATE_HEAD = 3'd2,STATE_DATA = 3'd3,STATE_CRC = 3'd4;
reg[7:0] m_tdata_reg = 8'hff;
reg[7:0] m_tdata_dly = 8'hff;
reg m_tvalid_reg = 1'b0;
reg m_tvalid_dly = 1'b0;


reg[2:0] state = STATE_IDEL;
reg[7:0] counts = 8'd0;

reg[15:0]  	s_tdata_dly , s_tdata_reg;
reg s_tlast_dly	; 
reg s_tuser_dly	;	
reg s_tvalid_dly;

reg 	  	tready_reg =1'b1;
reg			fcs_en = 1'b0;
reg			fcs_reset = 1'b0;
reg 		fcs_out = 1'b0;

reg  [7:0]  fcs_data_reg;
wire [31:0] fcs_data;






assign s_axis_tready = tready_reg;
assign m_axis_tdata  = (fcs_out == 1'b1)? fcs_data_reg : m_tdata_dly ;
assign m_axis_tvalid = m_tvalid_dly;




always@(posedge s_axis_aclk)
begin
	s_tlast_dly	  <= s_axis_tlast  ;
	s_tuser_dly	  <= s_axis_tuser  ;
	s_tvalid_dly  <= s_axis_tvalid ;
	s_tdata_dly <= {s_tdata_dly[7:0],s_axis_tdata};
		
end


always@(posedge s_axis_aclk)
begin
	if((state == STATE_PREA) && (counts == 8'd1))
	begin
		s_tdata_reg <= s_tdata_dly;
	end
	
end


always@(posedge s_axis_aclk)
begin
	m_tdata_dly  <= m_tdata_reg;
	m_tvalid_dly <= m_tvalid_reg;
end


always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			m_tdata_reg <= 8'hff;
			m_tvalid_reg <= 1'b0;
			fcs_en <= 1'b0;
			fcs_out <= 1'b0;
		
			if((~s_tuser_dly) & s_axis_tuser)
			begin
				state <= STATE_PREA;	
				tready_reg <= 1'b0;
				fcs_reset <= 1'b0;
			end
			else
			begin
				state <= STATE_IDEL;
				tready_reg <= 1'b1;
				fcs_reset <= 1'b1;
			end
			
			
		end
		STATE_PREA:
		begin
			m_tvalid_reg <= 1'b1;
			if(counts == 8'd7)
			begin
				counts 		<= 8'd0;
				m_tdata_reg 	<= 8'hd5;								
				state 		<= STATE_HEAD;
				
			end
			else
			begin
				counts 		<= counts + 1'b1;
				m_tdata_reg 	<= 8'h55;	
				state 		<= STATE_PREA;
			end						
		end
		STATE_HEAD:
		begin
			counts <= counts + 1'b1;
			case(counts)
				// dst_mac
				8'd0:
				begin
					m_tdata_reg 	<= dst_mac[47:40];
					fcs_en <= 1'b1;
				end
				8'd1:
				begin
					m_tdata_reg 	<= dst_mac[39:32];
				end
				8'd2:
				begin
					m_tdata_reg 	<= dst_mac[31:24];
				end
				8'd3:
				begin
					m_tdata_reg 	<= dst_mac[23:16];
				end
				8'd4:
				begin
					m_tdata_reg 	<= dst_mac[15:8];
				end
				8'd5:
				begin
					m_tdata_reg 	<= dst_mac[7:0];
				end
				
				// src_mac
				8'd6:
				begin
					m_tdata_reg 	<= src_mac[47:40];
				end
				8'd7:
				begin
					m_tdata_reg 	<= src_mac[39:32];
				end
				8'd8:
				begin
					m_tdata_reg 	<= src_mac[31:24];
				end
				8'd9:
				begin
					m_tdata_reg 	<= src_mac[23:16];
				end
				8'd10:
				begin
					m_tdata_reg 	<= src_mac[15:8];
				end
				8'd11:
				begin
					m_tdata_reg 	<= src_mac[7:0];
				end
				
				// eth_type
				8'd12:
				begin
					m_tdata_reg 	<= eth_type[15:8];
				end
				8'd13:
				begin
					m_tdata_reg 	<= eth_type[7:0];
				end	
					
				// s_tdata_dly
				8'd14:
				begin
					m_tdata_reg 	<= s_tdata_reg[15:8];
					tready_reg 		<= 1'b1;
				end
				8'd15:
				begin
					m_tdata_reg 	<= s_tdata_reg[7:0];
					state 		<= STATE_DATA;	
				end	

			endcase					
		end
		STATE_DATA:
		begin
			m_tdata_reg 	<= s_axis_tdata;
			counts 		<= 8'd0;
			if((~s_tlast_dly) & s_axis_tlast)
			begin			
				state <= STATE_CRC;	
				tready_reg 	<= 1'b0;
				
				
			end	
					
		end

		STATE_CRC:
		begin
			counts <= counts + 1'b1;
			
			case(counts)
				8'd0:
				begin
					fcs_en <= 1'b0;
					
				end			
				8'd1:
				begin
					fcs_out <= 1'b1;
					fcs_data_reg 	<= fcs_data[31:24];
				end
				8'd2:
				begin
					fcs_data_reg 	<= fcs_data[23:16];
				end
				8'd3:
				begin
					fcs_data_reg 	<= fcs_data[15:8];
				end
				8'd4:
				begin
					fcs_data_reg 	<= fcs_data[7:0];
					state 		    <= STATE_IDEL;
					m_tvalid_reg    <= 1'b0;
				end	
			endcase
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
	 .Data_in(m_tdata_reg), 
	 .Enable(fcs_en), 
	 .Crc   (fcs_data),
	 .CrcNext()
 );
 

endmodule