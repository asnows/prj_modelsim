module rx_ip
(
	output[15:0] IP_TotLen	,//Total Length
	output[ 7:0] IP_Protocol,
	output[31:0] IP_SrcAddr	,
	output[31:0] IP_DestAddr,
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
	output       m_axis_tvalid   ,
	output		 ip_Check_err
		
);

localparam STATE_IDLE = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;


reg[ 3:0] IP_Version_reg 	= 4'd0;
reg[ 3:0] IP_HeaderLen_reg 	= 4'd0;
reg[ 7:0] IP_TOS_reg 		= 8'd0;//Type of Service
reg[15:0] IP_TotLen_reg 	= 16'd0;
reg[15:0] IP_ID_reg 		= 16'd0;
reg[ 2:0] IP_Flags_reg 		= 3'd0;
reg[12:0] IP_FraOff_reg 	= 13'd0;
reg[ 7:0] IP_TTL_reg 		= 8'd0;
reg[ 7:0] IP_Protocol_reg 	= 8'd0;//UDP
reg[15:0] ip_headCheck_reg	= 16'd0;
reg[31:0] IP_SrcAddr_reg 	= 32'd0;
reg[31:0] IP_DestAddr_reg	= 32'd0;
reg ip_Check_err_Reg =1'b0;




reg[1:0] state = STATE_IDLE;
wire[23:0]  ip_Check;
wire[15:0]  ip_headCheck;
reg [7:0] counts = 8'd0;

reg[7:0]   s_tdata_dly ;
reg s_tlast_dly,s_tlast_dly2; 
reg s_tready_dly;
reg s_tuser_dly	;	
reg s_tvalid_dly;
reg s_tready_reg;

reg[7:0]   m_tdata_reg =8'hff;
reg m_tlast_reg  = 1'b0;
reg m_tuser_reg  = 1'b0;
reg m_tvalid_reg = 1'b0;

reg ip_Check_enable =1'b0;

assign ip_Check  =  {4'd0,IP_Version_reg,IP_HeaderLen_reg,IP_TOS_reg} + {4'd0,IP_TotLen_reg} + {4'd0,IP_ID_reg} + {4'd0,IP_Flags_reg,IP_FraOff_reg} + {4'd0,IP_TTL_reg,IP_Protocol_reg}
				 +  {4'd0,IP_SrcAddr_reg[31:16]} + {4'd0,IP_SrcAddr_reg[15:0]}+ {4'd0,IP_DestAddr_reg[31:16]} + {4'd0,IP_DestAddr_reg[15:0]};

assign ip_headCheck = ~(ip_Check[15:0] + ip_Check[23:16]);


// assign ip_Check  =  {4'd0,IP_Version,IP_HeaderLen,IP_TOS} + {4'd0,IP_TotLen} + {4'd0,IP_ID} + {4'd0,IP_Flags,IP_FraOff} + {4'd0,IP_TTL,IP_Protocol}
				 // +  {4'd0,IP_SrcAddr[31:16]} + {4'd0,IP_SrcAddr[15:0]}+ {4'd0,IP_DestAddr[31:16]} + {4'd0,IP_DestAddr[15:0]};

// assign ip_headCheck = ~(ip_Check[15:0] + ip_Check[23:16]);


assign IP_TotLen	= IP_TotLen_reg	;
assign IP_Protocol  = IP_Protocol_reg;
assign IP_SrcAddr	= IP_SrcAddr_reg;
assign IP_DestAddr  = IP_DestAddr_reg;


assign s_axis_tready =  (ip_enable == 1'b1)? s_tready_reg : m_axis_tready;
assign m_axis_tdata  =  (ip_enable == 1'b1)? m_tdata_reg  : s_axis_tdata ;
assign m_axis_tlast  =  (ip_enable == 1'b1)? m_tlast_reg  : s_axis_tlast ;
assign m_axis_tuser  =  (ip_enable == 1'b1)? m_tuser_reg  : s_axis_tuser ;
assign m_axis_tvalid =  (ip_enable == 1'b1)? m_tvalid_reg : s_axis_tvalid; 
assign ip_Check_err  = ip_Check_err_Reg;

always@(posedge s_axis_aclk)
begin
	s_tlast_dly	  <= s_axis_tlast  ;
	s_tuser_dly	  <= s_axis_tuser  ;
	s_tvalid_dly  <= s_axis_tvalid ;
	s_tdata_dly	  <= s_axis_tdata ;
	
	s_tlast_dly2 <= s_tlast_dly;

end

always@(posedge s_axis_aclk)
begin
	if(ip_Check_enable == 1'b1)
	begin
		ip_Check_err_Reg <= (ip_headCheck == ip_headCheck_reg )? 1'b0:1'b1;
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
		m_tlast_reg  <=  1'b0;
		m_tvalid_reg <= 1'b0;
		s_tready_reg <= 1'b1;
		
		if((~s_tuser_dly) & s_axis_tuser)
		begin
			state <= STATE_HEADER;
			
		end
		else
		begin
			state <= STATE_IDLE;
			
		end
		
		
	end
	STATE_HEADER:
	begin

		counts <= counts + 1'b1;
		
		case(counts)
			8'd0:
			begin
				{IP_Version_reg,IP_HeaderLen_reg} <= s_tdata_dly ;
				
			end
			8'd1:
			begin
				IP_TOS_reg <= s_tdata_dly;
				
			end
			8'd2:
			begin
				IP_TotLen_reg[15:8] <= s_tdata_dly;
			end
			8'd3:
			begin
				IP_TotLen_reg[7:0] <= s_tdata_dly;
			end
			8'd4:
			begin
				IP_ID_reg[15:8] <= s_tdata_dly;
			end
			8'd5:
			begin
				IP_ID_reg[7:0] <= s_tdata_dly;
			end
			8'd6:
			begin
				{IP_Flags_reg,IP_FraOff_reg[12:8]} <= s_tdata_dly;
			end
			8'd7:
			begin
				IP_FraOff_reg[7:0] <= s_tdata_dly;
			end
			8'd8:
			begin
				IP_TTL_reg <= s_tdata_dly;
			end
			8'd9:
			begin
				IP_Protocol_reg <= s_tdata_dly;
			end
			8'd10:
			begin
				ip_headCheck_reg[15:8] <= s_tdata_dly;
			end
			8'd11:
			begin
				ip_headCheck_reg[7:0] <= s_tdata_dly;
			end
			8'd12:
			begin
				IP_SrcAddr_reg[31:24] <= s_tdata_dly;
			end
			8'd13:
			begin
				IP_SrcAddr_reg[23:16] <= s_tdata_dly;
			end
			8'd14:
			begin
				IP_SrcAddr_reg[15:8] <= s_tdata_dly;
			end
			8'd15:
			begin
				IP_SrcAddr_reg[7:0] <= s_tdata_dly;
			end
			8'd16:
			begin
				IP_DestAddr_reg[31:24] <= s_tdata_dly;
			end
			8'd17:
			begin
				IP_DestAddr_reg[23:16] <= s_tdata_dly;
			end
			8'd18:
			begin
				IP_DestAddr_reg[15:8] <= s_tdata_dly;
			end
			8'd19:
			begin
				IP_DestAddr_reg[7:0] <= s_tdata_dly;
				ip_Check_enable <= 1'b1;
				
			end
			
			8'd20:
			begin
				m_tdata_reg <= s_tdata_dly;
				ip_Check_enable <= 1'b0;
				m_tuser_reg  <= 1'b1;
				m_tvalid_reg <= 1'b1;
				state <= STATE_DATA;
			end
			
			default:
			begin
			end		
		endcase
	end
	STATE_DATA:
	begin
		m_tdata_reg  <= s_tdata_dly;	
		m_tuser_reg  <= 1'b0;
		if((~s_tlast_dly2) & s_tlast_dly)
		begin
			m_tlast_reg  <=  1'b1;
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
