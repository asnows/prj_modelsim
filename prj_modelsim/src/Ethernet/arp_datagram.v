module arp_datagram
(

	input [15:0] arp_opcode  ,
	input [47:0] arp_srcMac	 ,
	input [31:0] arp_srcIP   ,
	input [47:0] arp_destMac ,
	input [31:0] arp_destIP  ,

	input 		arp_enable		,
	input 	    s_axis_aclk	 	,
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




localparam ARP_HwType 	= 16'd1		;
localparam ARP_Proto 	= 16'h0800	;
localparam ARP_HwLen 	= 8'd6		;
localparam ARP_ProtoLen = 8'd4		;


localparam STATE_IDEL = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;
reg[1:0] state = STATE_IDEL;
reg [7:0] counts = 8'd0;


reg [15:0] arp_opcode_dly 	;
reg [47:0] arp_srcMac_dly 	;
reg [31:0] arp_srcIP_dly  	;
reg [47:0] arp_destMac_dly	;
reg [31:0] arp_destIP_dly 	;




reg[15:0]   s_tdata_dly,s_tdata_reg;
reg s_tlast_dly	; 
reg s_tuser_dly	;	
reg s_tvalid_dly;
reg s_tready_reg;

reg[7:0]    m_tdata_reg =8'hff;
reg 		m_tlast_reg  = 1'b0;
reg 		m_tuser_reg  = 1'b0;
reg 		m_tvalid_reg = 1'b0;





assign s_axis_tready = (arp_enable == 1'b1)? s_tready_reg : m_axis_tready;
assign m_axis_tdata  = (arp_enable == 1'b1)? m_tdata_reg  : s_axis_tdata;
assign m_axis_tlast  = (arp_enable == 1'b1)? m_tlast_reg  : s_axis_tlast;
assign m_axis_tuser  = (arp_enable == 1'b1)? m_tuser_reg  : s_axis_tuser;
assign m_axis_tvalid = (arp_enable == 1'b1)? m_tvalid_reg : s_axis_tvalid;




always@(posedge s_axis_aclk)
begin
	s_tuser_dly	  <= s_axis_tuser  ;
end



always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			m_tlast_reg  <= 1'b0;
			m_tvalid_reg <= 1'b0;
			
			arp_opcode_dly 	 <= arp_opcode  ;
			arp_srcMac_dly 	 <= arp_srcMac	; 
			arp_srcIP_dly  	 <= arp_srcIP   ;
			arp_destMac_dly	 <= arp_destMac ;
			arp_destIP_dly 	 <= arp_destIP  ;
			
			if((~s_tuser_dly) & (s_axis_tuser))
			begin
				s_tready_reg <= 1'b0;
				state <= STATE_HEADER;
			end
			else
			begin
				s_tready_reg <= 1'b1;
				state <= STATE_IDEL;
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
					m_tdata_reg  <= ARP_HwType[15:8];
					m_tuser_reg  <= 1'b1;
					m_tvalid_reg <= 1'b1;
				end
				8'd1:
				begin
					m_tdata_reg  <=ARP_HwType[7:0];
					m_tuser_reg  <=1'b0;
				end
				8'd2:
				begin
					m_tdata_reg  <=ARP_Proto[15:8];
				end
				8'd3:
				begin
					m_tdata_reg  <=ARP_Proto[7:0];
				end
				8'd4:
				begin
					m_tdata_reg  <=ARP_HwLen;
				end
				8'd5:
				begin
					m_tdata_reg  <=ARP_ProtoLen;
				end
				8'd6:
				begin
					m_tdata_reg  <=arp_opcode_dly[15:8];
				end
				8'd7:
				begin
					m_tdata_reg  <=arp_opcode_dly[7:0];
				end		
				
				8'd8:
				begin
					m_tdata_reg  <=arp_srcMac_dly[47:40];
				end
				8'd9:
				begin
					m_tdata_reg  <=arp_srcMac_dly[39:32];
				end
				8'd10:
				begin
					m_tdata_reg  <=arp_srcMac_dly[31:24];
				end
				8'd11:
				begin
					m_tdata_reg  <=arp_srcMac_dly[23:16];
				end
				8'd12:
				begin
					m_tdata_reg  <=arp_srcMac_dly[15:8];
				end
				8'd13:
				begin
					m_tdata_reg  <=arp_srcMac_dly[7:0];
				end
				8'd14:
				begin
					m_tdata_reg  <=arp_srcIP_dly[31:24];
				end
				8'd15:
				begin
					m_tdata_reg  <=arp_srcIP_dly[23:16];
				end
				8'd16:
				begin
					m_tdata_reg  <=arp_srcIP_dly[15:8];
				end
				8'd17:
				begin
					m_tdata_reg  <=arp_srcIP_dly[7:0];
				end
				
					
				8'd18:
				begin
					m_tdata_reg  <=arp_destMac_dly[47:40];
				end
				8'd19:
				begin
					m_tdata_reg  <=arp_destMac_dly[39:32];
				end
				8'd20:
				begin
					m_tdata_reg  <=arp_destMac_dly[31:24];
				end
				8'd21:
				begin
					m_tdata_reg  <=arp_destMac_dly[23:16];
				end
				8'd22:
				begin
					m_tdata_reg  <=arp_destMac_dly[15:8];
				end
				8'd23:
				begin
					m_tdata_reg  <=arp_destMac_dly[7:0];
				end
				8'd24:
				begin
					m_tdata_reg  <=arp_destIP_dly[31:24];
				end
				8'd25:
				begin
					m_tdata_reg  <=arp_destIP_dly[23:16];
				end
				8'd26:
				begin
					m_tdata_reg  <=arp_destIP_dly[15:8];
				end
				8'd27:
				begin
					m_tdata_reg  <=arp_destIP_dly[7:0];
					m_tlast_reg  <= 1'b1;
					state <= STATE_IDEL;
				end																																				

				default:
				begin
					state <= STATE_IDEL;
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