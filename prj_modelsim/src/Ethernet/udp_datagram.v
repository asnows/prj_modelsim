module udp_datagram
(

input[15:0] UDP_SrcPort,
input[15:0] UDP_DestPort,
input[15:0] UDP_TotLen,//Total Length
input[15:0] UDP_CheckSum,//Total Length

input 		udp_enable		,
input 	    s_axis_aclk		,
input[7:0]  s_axis_tdata    ,
input       s_axis_tlast    ,
output      s_axis_tready   ,
input       s_axis_tuser    ,
input       s_axis_tvalid   ,

output[7:0]  m_axis_tdata    ,
output       m_axis_tlast    ,
input        m_axis_tready   ,
output       m_axis_tuser    ,
output       m_axis_tvalid   

);



localparam STATE_IDEL = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;

reg[1:0] state = STATE_IDEL;


reg [7:0] counts = 8'd0;

reg[15:0]   s_tdata_dly,s_tdata_reg;
reg s_tlast_dly	; 
reg s_tuser_dly	;	
reg s_tvalid_dly;
reg s_tready_reg;

reg[7:0]   m_tdata_reg =8'hff;
reg m_tlast_reg  = 1'b0;
reg m_tuser_reg  = 1'b0;
reg m_tvalid_reg = 1'b0;





assign s_axis_tready =  (udp_enable == 1'b1)?  s_tready_reg : m_axis_tready;
assign m_axis_tdata  =  (udp_enable == 1'b1)?  m_tdata_reg  : s_axis_tdata ;
assign m_axis_tlast  =  (udp_enable == 1'b1)?  s_tlast_dly  : s_axis_tlast ;
assign m_axis_tuser  =  (udp_enable == 1'b1)?  m_tuser_reg  : s_axis_tuser ;
assign m_axis_tvalid =  (udp_enable == 1'b1)?  m_tvalid_reg : s_axis_tvalid; 

always@(posedge s_axis_aclk)
begin
	s_tlast_dly	  <= s_axis_tlast  ;
	s_tuser_dly	  <= s_axis_tuser  ;
	s_tvalid_dly  <= s_axis_tvalid ;
	s_tdata_dly <= {s_tdata_dly[7:0],s_axis_tdata};
end

always@(posedge s_axis_aclk)
begin
	if((state == STATE_HEADER) && (counts == 8'd1))
	begin
		s_tdata_reg <= s_tdata_dly;
	end
	
end



always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			m_tvalid_reg <= 1'b0;
			if((~s_tuser_dly) & s_axis_tuser)
			begin
				state <= STATE_HEADER;
				s_tready_reg <= 1'b0;
			end
			else
			begin
				state <= STATE_IDEL;
				s_tready_reg <= 1'b1;
			end	
			
		end
		
		STATE_HEADER:
		begin
			if(m_axis_tready)
			begin
				counts <= counts + 1'b1;
			end
			
			case(counts)
				8'd0:
				begin
					m_tdata_reg  <= UDP_SrcPort[15:8];
					m_tuser_reg  <= 1'b1;
					m_tvalid_reg <= 1'b1;
				end
				8'd1:
				begin
					m_tdata_reg  <=UDP_SrcPort[7:0];
					m_tuser_reg  <=1'b0;
				end
				8'd2:
				begin
					m_tdata_reg  <=UDP_DestPort[15:8];
				end
				8'd3:
				begin
					m_tdata_reg  <=UDP_DestPort[7:0];
				end
				8'd4:
				begin
					m_tdata_reg  <=UDP_TotLen[15:8];
				end
				8'd5:
				begin
					m_tdata_reg  <=UDP_TotLen[7:0];
				end
				8'd6:
				begin
					m_tdata_reg  <=UDP_CheckSum[15:8];
				end
				8'd7:
				begin
					m_tdata_reg  <=UDP_CheckSum[7:0];
				end
				
				8'd8:
				begin
					m_tdata_reg  <=s_tdata_reg[15:8];
					s_tready_reg <= 1'b1;
				end
				8'd9:
				begin
					m_tdata_reg  <=s_tdata_reg[7:0];
					state <= STATE_DATA;
				end
				
				default:
				begin
				end
			endcase
		end
		
		STATE_DATA:
		begin
			m_tdata_reg  <= s_axis_tdata;
			
			if((~s_tlast_dly)& s_axis_tlast)
			begin
				state <= STATE_IDEL;
			end			
		end						
	endcase	
end







endmodule