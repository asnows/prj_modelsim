/*
模块名：
	AD9945_cfg
功能：
	AD9945 配置模块
参数:
	sys_clk 	: 系统输入时钟，典型100m，用于分频产生sck = sys_clk/16 = 6.25m；
	Oper		: Operation 操作寄存器；
	Ctrl		: Control 控制寄存器;
	Clamp		: ClampLevel 黑电平钳位寄存器；
	VGA_Gain	: 增益放大寄存器；
	cfg_en		: 配置使能，上升沿有效;
	SDATA		: 输出数据
	SCK			：输出时钟 25m
	SL			：片选
	
	采用Continuous Serial Write Operation
	All register values default to 0x000 at power-up except clamp level, which defaults to 128 decimal (128 LSB clamp level).
*/

module AD9945_cfg
(
input  	   	sys_clk		,
input[6:0] 	Oper		,
input[6:0] 	Ctrl		,
input[7:0] 	Clamp		,
input[9:0] 	VGA_Gain	,
input	   	cfg_en		,
output 		SDATA		,
output 		SCK			,
output 		SL

);
localparam STATUS_IDLE = 1'b0,STATUS_TRANS = 1'b1;
localparam TRANS_NUM = 8'd63;

reg 	status = STATUS_IDLE;

reg[6:0] Oper_dly	 ;
reg[6:0] Ctrl_dly	 ;
reg[7:0] Clamp_dly	 ;
reg[9:0] VGA_Gain_dly;
reg 	 cfg_en_dly	 ;
reg[11:0] Startup = 12'h838;

reg[7:0] data_cnt = 8'd0;

wire		sck_clk;
reg 		sdata_reg = 1'b1;
reg 		sl_reg   = 1'b1;

reg[7:0]	div_cnt = 8'd0;


assign SDATA =  sdata_reg;
assign SCK   = sck_clk;//sl_reg == 1'b0 )? sck_clk : 1'b0;
assign SL    = sl_reg;
assign sck_clk = div_cnt[3];

always@(posedge sys_clk)
begin
	div_cnt <= div_cnt + 1'b1;
end


always@(posedge sck_clk)
begin
	Oper_dly	  <=Oper	;	
	Ctrl_dly	  <=Ctrl	;	
	Clamp_dly	  <=Clamp	;	
	VGA_Gain_dly  <=VGA_Gain;
	cfg_en_dly	  <=cfg_en	;
end


always@(posedge sck_clk)
begin
	if((~cfg_en_dly) & cfg_en)
	begin
		status <= STATUS_TRANS;
	end
	else
	begin
		if(data_cnt > TRANS_NUM - 1'b1)
		begin
			status <= STATUS_IDLE;
		end
	end
	
end


always@(posedge sck_clk)
begin
	case(status)
		STATUS_IDLE:
		begin
			data_cnt <= 8'd0;
		end
		STATUS_TRANS:
		begin
			
			data_cnt <= data_cnt + 1'b1;
			
		end
	endcase
end



always@(negedge sck_clk)
begin
	if(status == STATUS_TRANS)
	begin
		
		case(data_cnt)
			// A0 ~A2
			8'd0,8'd1,8'd2:
			begin
				sdata_reg <= 1'b0;
				sl_reg    <= 1'b0;
			end
			
			//opseration
			8'd3,8'd4,8'd5,8'd6,8'd7,8'd8,8'd9:
			begin
				sdata_reg <= Oper_dly[data_cnt - 8'd3];
			end
			8'd10,8'd11,8'd12,8'd13,8'd14:
			begin
				sdata_reg <= 1'b0;
			end

			//control
			8'd15,8'd16,8'd17,8'd18,8'd19,8'd20,8'd21:
			begin
				sdata_reg <= Ctrl_dly[data_cnt - 8'd15];
			end
			8'd22,8'd23,8'd24,8'd25,8'd26:
			begin
				sdata_reg <= 1'b0;
			end

			//ClampLevel
			8'd27,8'd28,8'd29,8'd30,8'd31,8'd32,8'd33,8'd34:
			begin
				sdata_reg <= Clamp_dly[data_cnt - 8'd27];
			end
			8'd35,8'd36,8'd37,8'd38:
			begin
				sdata_reg <= 1'b0;
			end

			//VGA_Gain
			8'd39,8'd40,8'd41,8'd42,8'd43,8'd44,8'd45,8'd46,8'd47,8'd48:
			begin
				sdata_reg <= VGA_Gain_dly[data_cnt - 8'd39];
			end
			8'd49,8'd50:
			begin
				sdata_reg <= 1'b0;
			end
			
			//Startup
			
			8'd51,8'd52,8'd53,8'd54,8'd55,8'd56,8'd57,8'd58,8'd59,8'd60,8'd61,8'd62:
			begin
				sdata_reg <= Startup[data_cnt - 8'd51];
			end

			8'd63:
			begin
				sdata_reg <= 1'b1;
				sl_reg    <= 1'b1;
			end
			
			default:
			begin
				sdata_reg <= 1'b1;
				sl_reg    <= 1'b1;
			end
			
		endcase
	end
	else
	begin
		sdata_reg <= 1'b1;
		sl_reg    <= 1'b1;
	end
end









endmodule