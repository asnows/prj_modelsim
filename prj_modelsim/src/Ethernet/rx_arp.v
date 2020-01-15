/*
模块名称：rx_arp
功能：
	拆封arp包，获取arp头。
接口：
	arp_opcode :操作码。
	arp_srcMac :源MAC。
	arp_srcIP  :源IP。
	arp_destMac:目的MAC。
	arp_destIP :目的IP

设计原理：
	状态机:
	STATE_IDEL =空闲状态,此状态下，等待一帧的开始信号tuser上升沿，当接收到上游的tuser上升沿时，跳转到STATE_HEAD
	STATE_HEAD = 接收帧头，接收完帧头后，产生tuser 和tvalid 给下游接收模块使用。
	STATE_DATA = 继续接收上游传来的数据，检测到上游的tvalid下降沿后跳转到STATE_IDEL。
*/


module rx_arp
(

	output [15:0] arp_opcode  ,
	output [47:0] arp_srcMac  ,
	output [31:0] arp_srcIP   ,
	output [47:0] arp_destMac ,
	output [31:0] arp_destIP  ,

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




reg[15:0] ARP_HwType_reg 	= 16'd1		;
reg[15:0] ARP_Proto_reg 	= 16'h0800	;
reg[ 7:0] ARP_HwLen_reg 	= 8'd6		;
reg[ 7:0] ARP_ProtoLen_reg  = 8'd4		;


localparam STATE_IDEL = 2'd0,STATE_HEADER = 2'd1,STATE_DATA = 2'd2;
reg[1:0] state = STATE_IDEL;
reg [7:0] counts = 8'd0;


reg [15:0] arp_opcode_reg	;
reg [47:0] arp_srcMac_reg	;
reg [31:0] arp_srcIP_reg 	;
reg [47:0] arp_destMac_reg	;
reg [31:0] arp_destIP_reg	;




reg[7:0]   s_tdata_dly;
reg s_tlast_dly	; 
reg s_tuser_dly	;	
reg s_tvalid_dly;
reg s_tready_reg;

reg[7:0]    m_tdata_reg =8'hff;
reg 		m_tlast_reg  = 1'b0;
reg 		m_tuser_reg  = 1'b0;
reg 		m_tvalid_reg = 1'b0;




assign arp_opcode  = arp_opcode_reg	;
assign arp_srcMac  = arp_srcMac_reg	;
assign arp_srcIP   = arp_srcIP_reg 	;
assign arp_destMac = arp_destMac_reg;
assign arp_destIP  = arp_destIP_reg	;





assign s_axis_tready = (arp_enable == 1'b1)? s_tready_reg : m_axis_tready;
assign m_axis_tdata  = (arp_enable == 1'b1)? m_tdata_reg  : s_axis_tdata;
assign m_axis_tlast  = (arp_enable == 1'b1)? m_tlast_reg  : s_axis_tlast;
assign m_axis_tuser  = (arp_enable == 1'b1)? m_tuser_reg  : s_axis_tuser;
assign m_axis_tvalid = (arp_enable == 1'b1)? m_tvalid_reg : s_axis_tvalid;




always@(posedge s_axis_aclk)
begin

	s_tlast_dly	  <= s_axis_tlast  ;
	s_tuser_dly	  <= s_axis_tuser  ;
	s_tvalid_dly  <= s_axis_tvalid ;
	s_tdata_dly   <= s_axis_tdata  ;

	
end



always@(posedge s_axis_aclk)
begin
	case(state)
		STATE_IDEL:
		begin
			counts <= 8'd0;
			m_tlast_reg  <= 1'b0;
			m_tvalid_reg <= 1'b0;
			s_tready_reg <= 1'b1;
			
			if((~s_tuser_dly) & (s_axis_tuser))
			begin
				state <= STATE_HEADER;
			end
			else
			begin
				state <= STATE_IDEL;
			end
			
			
		end
		
		STATE_HEADER:
		begin
			
			counts <= counts + 1'b1;
			
			case(counts)		
				8'd0:
				begin
					 ARP_HwType_reg[15:8] <= s_tdata_dly;

				end
				8'd1:
				begin
					ARP_HwType_reg[7:0] <= s_tdata_dly;
				
				end
				8'd2:
				begin
					ARP_Proto_reg[15:8] <= s_tdata_dly;
				end
				8'd3:
				begin
					ARP_Proto_reg[7:0] <= s_tdata_dly;
				end
				8'd4:
				begin
					ARP_HwLen_reg <= s_tdata_dly;
				end
				8'd5:
				begin
					ARP_ProtoLen_reg <= s_tdata_dly;
				end
				8'd6:
				begin
					arp_opcode_reg[15:8] <= s_tdata_dly;
				end
				8'd7:
				begin
					arp_opcode_reg[7:0] <= s_tdata_dly;
				end		
				
				8'd8:
				begin
					arp_srcMac_reg[47:40] <= s_tdata_dly;
				end
				8'd9:
				begin
					arp_srcMac_reg[39:32] <= s_tdata_dly;
				end
				8'd10:
				begin
					arp_srcMac_reg[31:24] <= s_tdata_dly;
				end
				8'd11:
				begin
					arp_srcMac_reg[23:16] <= s_tdata_dly;
				end
				8'd12:
				begin
					arp_srcMac_reg[15:8] <= s_tdata_dly;
				end
				8'd13:
				begin
					arp_srcMac_reg[7:0] <= s_tdata_dly ;
				end
				8'd14:
				begin
					arp_srcIP_reg[31:24] <= s_tdata_dly;
				end
				8'd15:
				begin
					arp_srcIP_reg[23:16] <= s_tdata_dly;
				end
				8'd16:
				begin
					arp_srcIP_reg[15:8] <= s_tdata_dly;
				end
				8'd17:
				begin
					arp_srcIP_reg[7:0] <= s_tdata_dly;
				end
				
					
				8'd18:
				begin
					arp_destMac_reg[47:40] <= s_tdata_dly;
				end
				8'd19:
				begin
					arp_destMac_reg[39:32] <= s_tdata_dly;
				end
				8'd20:
				begin
					arp_destMac_reg[31:24] <= s_tdata_dly;
				end
				8'd21:
				begin
					arp_destMac_reg[23:16] <= s_tdata_dly;
				end
				8'd22:
				begin
					arp_destMac_reg[15:8] <= s_tdata_dly;
				end
				8'd23:
				begin
					arp_destMac_reg[7:0] <= s_tdata_dly;
				end
				8'd24:
				begin
					arp_destIP_reg[31:24] <= s_tdata_dly;
				end
				8'd25:
				begin
					arp_destIP_reg[23:16] <= s_tdata_dly;
				end
				8'd26:
				begin
					arp_destIP_reg[15:8] <= s_tdata_dly;
				end
				8'd27:
				begin
					arp_destIP_reg[7:0] <= s_tdata_dly;
				end		
				8'd28:
				begin
					m_tdata_reg  <= s_tdata_dly;
					m_tuser_reg  <= 1'b1;
					m_tvalid_reg <= 1'b1;
				end																																				
				
				default:
				begin
					m_tdata_reg  <= s_tdata_dly;
					m_tuser_reg  <= 1'b0;
					if(counts == 8'd45)
					begin
						m_tlast_reg  <= 1'b1;
						state <= STATE_IDEL;
					end
					
					
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