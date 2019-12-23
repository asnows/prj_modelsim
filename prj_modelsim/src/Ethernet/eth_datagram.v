module eth_datagram
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
  
)


localparam STATE_IDEL = 3'd0,STATE_PREA = 3'd1,STATE_HEAD = 3'd2,STATE_DATA = 3'd3,STATE_CRC = 3'd4;
reg[7:0] tdata_reg = 8'hff;
reg tvalid_reg = 1'b0;


reg[2:0] state = STATE_IDEL;
reg[7:0] counts = 8'd0;

reg[15:0]  	tdata_dly  ;
reg 	  	tready_reg =1'b1;
wire [31:0] crc_data;



always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			tdata_reg = 8'hff;
			
			tdata_dly <= {tdata_dly[7:0],s_axis_tdata};
			
			if(s_axis_tuser)
			begin
				state <= STATE_PREA;	
				tready_reg <= 1'b0;
				tvalid_reg <= 1'b1;
			end
			else
			begin
				state <= STATE_IDEL;
				tready_reg <= 1'b1;
				tvalid_reg <= 1'b0;
			end
			
		end
		STATE_PREA:
		begin
			if(counts == 8'd6)
			begin
				counts 		<= 8'd0
				tdata_reg 	<= 8'hd5;								
				state 		<= STATE_HEAD;
				
			end
			else
			begin
				counts 		<= counts + 1'b1;
				tdata_reg 	<= 8'h55;	
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
					tdata_reg 	<= dst_mac[47:40];
				end
				8'd1:
				begin
					tdata_reg 	<= dst_mac[39:32];
				end
				8'd2:
				begin
					tdata_reg 	<= dst_mac[31:24];
				end
				8'd3:
				begin
					tdata_reg 	<= dst_mac[23:16];
				end
				8'd4:
				begin
					tdata_reg 	<= dst_mac[15:8];
				end
				8'd5:
				begin
					tdata_reg 	<= dst_mac[7:0];
				end
				
				// src_mac
				8'd6:
				begin
					tdata_reg 	<= src_mac[47:40];
				end
				8'd7:
				begin
					tdata_reg 	<= src_mac[39:32];
				end
				8'd8:
				begin
					tdata_reg 	<= src_mac[31:24];
				end
				8'd9:
				begin
					tdata_reg 	<= src_mac[23:16];
				end
				8'd10:
				begin
					tdata_reg 	<= src_mac[15:8];
				end
				8'd11:
				begin
					tdata_reg 	<= src_mac[7:0];
				end
				
				// eth_type
				8'd6:
				begin
					tdata_reg 	<= eth_type[16:8];
				end
				8'd7:
				begin
					tdata_reg 	<= eth_type[7:0];
				end	
					
				// tdata_dly
				8'd6:
				begin
					tdata_reg 	<= tdata_dly[16:8];
					tready_reg 	<= 1'b1;
				end
				8'd7:
				begin
					tdata_reg 	<= tdata_dly[7:0];
					state 		<= STATE_DATA;	
				end	

			endcase					
		end
		STATE_DATA:
		begin
			tdata_reg 	<= tdata;
			counts 		<= 8'd0	
			if(s_axis_tlast)
			begin			
				state <= STATE_DATA;	
			end	
					
		end

		STATE_CRC:
		begin
			counts <= counts + 1'b1;
			case(counts)
				8'd0:
				begin
					tdata_reg 	<= crc_data[31:24];
				end
				8'd1:
				begin
					tdata_reg 	<= crc_data[23:16];
				end
				8'd2:
				begin
					tdata_reg 	<= crc_data[15:8];
				end
				8'd3:
				begin
					
					tdata_reg 	<= crc_data[7:0];
					state 		<= STATE_IDEL;
				end	
			endcase
		end
		
		default:
		begin
			state <= STATE_IDEL;
		end

	endcase

end

endmodule