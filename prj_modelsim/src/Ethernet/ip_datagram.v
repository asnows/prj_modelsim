module ip_datagram
(
	input[15:0] IP_TotLen,//Total Length
	input[31:0] IP_SrcAddr,
	input[31:0] IP_DestAddr,
	input 		ip_enable	,
	input 	    s_axis_aclk,
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

localparam STATE_IDLE = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;

//IP_Header Define
localparam IP_Version = 4'd4;
localparam IP_HeaderLen = 4'd5;
localparam IP_TOS = 8'd0;//Type of Service
localparam IP_ID = 16'D0;
localparam IP_Flags = 3'd2;
localparam IP_FraOff = 13'd0;
localparam IP_TTL = 8'd64;
localparam IP_Protocol = 8'd17;//UDP	


reg[1:0] state = STATE_IDLE;
wire[23:0]  ip_Check;
wire[15:0]  ip_headCheck;
reg [7:0] counts = 8'd0;

reg[15:0]   s_tdata_dly,s_tdata_reg  ;
reg s_tlast_dly	; 
reg s_tready_dly;
reg s_tuser_dly	;	
reg s_tvalid_dly;
reg s_tready_reg;

reg[7:0]   m_tdata_reg =8'hff;
reg m_tlast_reg  = 1'b0;
reg m_tuser_reg  = 1'b0;
reg m_tvalid_reg = 1'b0;

assign ip_Check  =  {4'd0,IP_Version,IP_HeaderLen,IP_TOS} + {4'd0,IP_TotLen} + {4'd0,IP_ID} + {4'd0,IP_Flags,IP_FraOff} + {4'd0,IP_TTL,IP_Protocol}
				 +  {4'd0,IP_SrcAddr[31:16]} + {4'd0,IP_SrcAddr[15:0]}+ {4'd0,IP_DestAddr[31:16]} + {4'd0,IP_DestAddr[15:0]};

assign ip_headCheck = ~(ip_Check[15:0] + ip_Check[23:16]);

assign s_axis_tready =  (ip_enable == 1'b1)? s_tready_reg : m_axis_tready;
assign m_axis_tdata  =  (ip_enable == 1'b1)? m_tdata_reg  : s_axis_tdata ;
assign m_axis_tlast  =  (ip_enable == 1'b1)? s_tlast_dly  : s_axis_tlast ;
assign m_axis_tuser  =  (ip_enable == 1'b1)? m_tuser_reg  : s_axis_tuser ;
assign m_axis_tvalid =  (ip_enable == 1'b1)? m_tvalid_reg : s_axis_tvalid; 


always@(posedge s_axis_aclk)
begin
	s_tlast_dly	  <= s_axis_tlast  ;
	s_tuser_dly	  <= s_axis_tuser  ;
	s_tvalid_dly  <= s_axis_tvalid ;

end



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
	STATE_IDLE:
	begin
		
		counts <= 8'd0;
		m_tdata_reg  <=8'hff;
		m_tuser_reg  <= 1'b0;
		
		if((~s_tuser_dly) & s_axis_tuser)
		begin
			state <= STATE_HEADER;
			s_tready_reg <= 1'b0;
		end
		else
		begin
			state <= STATE_IDLE;
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
				m_tdata_reg  <={IP_Version,IP_HeaderLen};
				m_tuser_reg  <= 1'b1;
			end
			8'd1:
			begin
				m_tdata_reg  <=IP_TOS;
				m_tuser_reg  <=1'b0;
			end
			8'd2:
			begin
				m_tdata_reg  <=IP_TotLen[15:8];
			end
			8'd3:
			begin
				m_tdata_reg  <=IP_TotLen[7:0];
			end
			8'd4:
			begin
				m_tdata_reg  <=IP_ID[15:8];
			end
			8'd5:
			begin
				m_tdata_reg  <=IP_ID[7:0];
			end
			8'd6:
			begin
				m_tdata_reg  <={IP_Flags,IP_FraOff[12:8]};
			end
			8'd7:
			begin
				m_tdata_reg  <=IP_FraOff[7:0];
			end
			8'd8:
			begin
				m_tdata_reg  <=IP_TTL;
			end
			8'd9:
			begin
				m_tdata_reg  <=IP_Protocol;
			end
			8'd10:
			begin
				m_tdata_reg  <=ip_headCheck[15:8];
			end
			8'd11:
			begin
				m_tdata_reg  <=ip_headCheck[7:0];
			end
			8'd12:
			begin
				m_tdata_reg  <=IP_SrcAddr[31:24];
			end
			8'd13:
			begin
				m_tdata_reg  <=IP_SrcAddr[23:16];
			end
			8'd14:
			begin
				m_tdata_reg  <=IP_SrcAddr[15:8];
			end
			8'd15:
			begin
				m_tdata_reg  <=IP_SrcAddr[7:0];
			end
			8'd16:
			begin
				m_tdata_reg  <=IP_DestAddr[31:24];
			end
			8'd17:
			begin
				m_tdata_reg  <=IP_DestAddr[23:16];
			end
			8'd18:
			begin
				m_tdata_reg  <=IP_DestAddr[15:8];
			end
			8'd19:
			begin
				m_tdata_reg  <=IP_DestAddr[7:0];
			end
			8'd20:
			begin
				m_tdata_reg  <=s_tdata_reg[15:8];
				s_tready_reg <= 1'b1;
			end
			8'd21:
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
		if((~s_tlast_dly) & s_axis_tlast)
		begin
			state <= STATE_IDLE;
		end

	end
	default:
	begin	

		state <= STATE_IDLE;					
	end	
	endcase	
end






endmodule
