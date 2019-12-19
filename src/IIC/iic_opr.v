/*
模块名称：iic_opr
功能：
	IIC 发送数据时序实现
接口：
	clk		: 输入时钟
	sendByte:一次需要发送的字节数，发送完成后才产生停止位。
	tvalid	:输入数据有效。
	tdata	:输入数据。
	tready	:模块就绪，当模块处于空闲状态时，此信号设置1；当模块正在发送数据时，此信号设置为0。
	SCL		:IIC 输出时钟线。
	SDA		:IIC 输出数据线。
	
设计原理：
	状态机:
	IDEL=空闲状态,此状态下，SCL，SDA，tready都为高电平。，STAR
	START = 开始状态，此状态下，产生开始位。
	SEND  = 发送状态，此状态下，发送数据，根据sendBytes 来判断总共需要发送多少位。
	STOP  = 停止状态，此状态下，产生停止位（实际是把SDA拉低，把停止位推辞到IDLE里面去产生）
	
	tready的产生：利用时钟下降沿驱动
		1.初始值位高电平，在IDLE 状态下，当检测到tvalid上升沿后，tready设置位低电平（表示IIC进入忙碌）。进入STOP后，重新设置位高电平。
		2.在发送多个字节情况下，每当发送8位后，设置为高电平一个时钟周期。以便接收下一个待发送的数据。
	
	SCL的产生：利用时钟上升沿驱动
		1.初始值位高电平，在START 和 SEND 状态下，每次取反
		2.在STOP状态下。重新设置为高电平
	SDA的产生：利用时钟下降沿驱动
		1.初始值位高电平，在START 被拉低，产生起始位。
		2.在SEND 状态下，当SCL为低电平的时候，更新数据
		3.在STOP状态下。被设置为低电平，以便在下一个周期中产生停止位
	

*/




module iic_opr
(
	input clk,
	input[7:0] sendBytes,
	input tvalid,
	input[7:0] tdata,
	output tready,
	output SCL,
	output SDA
);

	localparam  START =2'b00,SEND = 2'b01, STOP = 2'b10,IDEL = 2'b11;

	 
	reg[1:0] state = IDEL;

	wire clk_n;

	reg tready_reg = 1'b1;
	reg scl_reg = 1'b1;
	reg sda_reg = 1'b1;
	reg[7:0] tdata_dly;

	reg tvalid_dly;
	reg[15:0] sendBits = 16'd0;
	reg[15:0] Bit_Counts= 16'd0;


	// 字节数转换成需要发送的位数
	//assign sendBits = (sendBytes << 3);
	assign clk_n = ~clk;

	assign tready = tready_reg;
	assign SCL = scl_reg;
	assign SDA = sda_reg;

	always@(posedge clk)
	begin
		tvalid_dly <= tvalid;
		
		// if(tvalid == 1'b1)
		// begin
			// tdata_dly  <= tdata;	
		// end
		
		tdata_dly  <= tdata;	
		//sendBits = (sendBytes << 3);
	end


	// 产生状态机
	always@(posedge clk)
	begin
		case(state)
			IDEL:
			begin
				if(~tvalid_dly & tvalid) // 上升沿
				begin
					state <= START;
				end
				else
				begin
					state <= IDEL;
				end
				
			end
			START:
			begin
				state <= SEND;	
				Bit_Counts <= 16'd0;
				sendBits = (sendBytes << 3);				
			end
			SEND:
			begin
				if(Bit_Counts < sendBits)
				begin
					if(scl_reg == 1'b0)
					begin
						//在IIC SCL 高电平时计数
						Bit_Counts <= Bit_Counts + 1;
					end
					state <= SEND;	
				end
				else
				begin
					
					state <= STOP;	
				end
			end
			STOP:
			begin
				state <= IDEL;	
			end
			
			default:
			begin
				state <= IDEL;
			end
				
		endcase
	end

	//产生SCL
	always@(posedge clk)
	begin
		case(state)
			IDEL:
			begin
				scl_reg <= 1'b1;
			end
			START:
			begin
				//scl_reg <= 1'b1;
				scl_reg <= ~scl_reg;
			end
			SEND:
			begin
				scl_reg <= ~scl_reg;
			end
			STOP:
			begin
				scl_reg <= 1'b1;
			end	
			default:
			begin
				scl_reg <= 1'b1;
			end
				
		endcase
	end


	// 产生SDA
	always@(posedge clk_n)
	begin
		case(state)
			IDEL:
			begin
				sda_reg <= 1'b1;
			end
			START:
			begin
				sda_reg <= 1'b0;
			end
			SEND:
			begin
				if(scl_reg == 1'b0)
				begin
					//在scl_reg 低电平改变数据
					sda_reg <= tdata_dly[Bit_Counts%8];
				end
				else
				begin
					sda_reg <= sda_reg;
				end
				
				
			end
			STOP:
			begin
				// 拉低，以便在下一个状态下好产生停止位
				sda_reg <= 1'b0;
				
			end	
			default:
			begin
				sda_reg <= 1'b1;
			end
				
		endcase
	end

	// 产生ready 信号
	always@(posedge clk_n)
	begin
		case(state)
			IDEL:
			begin
				if(~tvalid_dly & tvalid == 1'b1)
				begin
					tready_reg <= 1'b0;
				end
				else
				begin
					tready_reg <= 1'b1;
				end	
			end

			SEND:
			begin
				
				//当只传送一个字节及最后一个字节时，不需要产生tready
				if((sendBytes > 8'd1) && (Bit_Counts < (sendBits - 8'd4)))
				begin

				
					if((Bit_Counts > 15'd0) && ((Bit_Counts%8) == 15'd7) && (scl_reg == 1'b0))
					begin
						tready_reg <= 1'b1;
					end
					else
					begin
						tready_reg <= 1'b0;
					end	
				end
				
			end
					
		endcase
	end





endmodule