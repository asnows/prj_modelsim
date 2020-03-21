/*
模块名：
	TCD1290D_driver
功能：
	CCD时序驱动
参数:
	sys_clk :系统输入时钟，默认100m；
	sh      :转移栅脉冲；
	f1_cnt  :f1频率参数，单位hz,用来产生发f1频率，f1_cnt = sys_clk/(f1*2)，每当div_cnt = f1_cnt时，f1翻转一次;
	f1		:二相移位脉冲1；
	f2		:二相移位脉冲2；
	f2b		:电荷输出脉冲;
	rs		:输出极复位脉冲;
	cp		:钳位脉冲（保持住电压水平）
设计原理：
	状态机：
		转移图：
			上电 -> STATUS_IDEL ——（延时 LOAD_PLUS_WIDTH）——>STATUS_LOAD ——（延时 LOAD_PLUS_WIDTH）——> STATUS_TRAN——（发送完LINE_WIDTH）——>  STATUS_IDEL；
		操作：
		STATUS_IDEL：所有信号初始化为0；
		STATUS_LOAD：f1_reg拉高，经过t1后sh_reg拉高，再经过t2、t3后sh_reg拉低，经过t4,t5后f1_reg拉低；
		STATUS_TRAN：根据div_cnt生成f1_reg脉冲。
		
*/

module TCD1209D_driver
(
input  sys_clk,
input[9:0]f1_cnt,
output sh,
output f1,
output f2,
output f2b,
output rs,
output cp

);

localparam STATUS_IDEL = 2'd0,STATUS_PREPARE = 2'd1,STATUS_LOAD = 2'd2,STATUS_TRAN = 2'd3;
localparam LINE_WIDTH = 12'd2100; //每行总像素
localparam LOAD_PLUS_WIDTH = 10'd300; //加载时脉冲宽度
localparam RS_PULSE_WIDTH = 10'd11;
localparam CP_PULSE_WIDTH = 10'd11;


reg[1:0]   status = STATUS_IDEL;


reg sh_reg;
reg f1_reg,f1_dly;
wire f2_reg;
wire f2b_reg;
reg rs_reg;
reg cp_reg;
reg[11:0] pxl_cnt = 12'd0;
reg[9:0] div_cnt = 10'd0;



assign f2_reg = ~f1_reg;
assign f2b_reg = ~f1_reg;

assign sh = sh_reg;
assign f1 = f1_reg;
assign f2 = f2_reg;
assign f2b= f2b_reg;
assign rs = rs_reg;
assign cp = cp_reg;

always@(posedge sys_clk)
begin
	f1_dly <= f1_reg;

end


//生成状态机
always@(posedge sys_clk)
begin
	case(status)
		STATUS_IDEL:
		begin
			pxl_cnt <= 12'd0;
			if(div_cnt < LOAD_PLUS_WIDTH)
			begin
				div_cnt <= div_cnt + 1'b1;
			end
			else
			begin
				div_cnt <= 10'd0;
				status <= STATUS_LOAD;
			end

		end		
		
		STATUS_LOAD:
		begin
			
			if(div_cnt < LOAD_PLUS_WIDTH)
			begin
				div_cnt <= div_cnt + 1'b1;
			end
			else
			begin
				div_cnt <= 10'd0;
				status <= STATUS_TRAN;
			end
	
		end
		
		STATUS_TRAN:
		begin
		
			if(div_cnt < f1_cnt - 1'b1)
			begin
				div_cnt <= div_cnt + 1'b1;
			end
			else
			begin
				div_cnt <= 10'd0;
			end
			
		
			if(pxl_cnt < LINE_WIDTH)
			begin
				//if((~f1_dly) & f1_reg) //检测f1上升沿
				if(f1_dly & (~f1_reg)) //检测f1上升沿
				begin
					pxl_cnt <= pxl_cnt + 1'b1;
				end
				
			end
			else
			begin
				status <= STATUS_IDEL;
			end
								
		end
		
		default:
		begin
			status <= STATUS_IDEL;
		end	
	endcase

end


//生成转移栅脉冲SH
always@(posedge sys_clk)
begin
	case(status)
	
		STATUS_IDEL:
		begin
			sh_reg <= 1'b0;
		end	
		
		STATUS_LOAD:
		begin
			if((10'd60 < div_cnt ) & (div_cnt < 10'd211))//1500ns
			begin
				sh_reg <= 1'b1;
			end
			else
			begin
				sh_reg <= 1'b0;
			end
			
		end		
		
		default:
		begin
			sh_reg <= 1'b0;
		end	
	endcase
end



//生成移位脉冲f1
always@(posedge sys_clk)
begin
	case(status)
		STATUS_IDEL:
		begin
			f1_reg <= 1'b0;
		end
		
		STATUS_LOAD:
		begin
			f1_reg <= 1'b1;
		end
		
		STATUS_TRAN:
		begin
			if(div_cnt == 10'd0)
			begin
				f1_reg <= ~f1_reg;
			end
		end
		
		default:
		begin
			f1_reg <= 1'b0;
		end	
	endcase
end


//生成复位脉冲rs
always@(posedge sys_clk)
begin
	case(status)
		STATUS_IDEL:
		begin
			rs_reg <= 1'b0;
		end
		
		STATUS_LOAD:
		begin
			rs_reg <= 1'b0;
		end
		
		STATUS_TRAN:
		begin
			if((f2b_reg == 1'b1) && ((1'b1 < div_cnt)&&(div_cnt < RS_PULSE_WIDTH + 1'b1 )))
			
			begin
				rs_reg <= 1'b1;
			
			end
			else
			begin
				rs_reg <= 1'b0;
			end
			
		end
		
		default:
		begin
			rs_reg <= 1'b0;
		end	
	endcase
end

//生成钳位脉冲cp
always@(posedge sys_clk)
begin
	case(status)
		STATUS_IDEL:
		begin
			cp_reg <= 1'b0;
		end
		
		STATUS_LOAD:
		begin
			cp_reg <= 1'b0;
		end
		
		STATUS_TRAN:
		begin
			if((f2b_reg == 1'b1) && ((CP_PULSE_WIDTH  < div_cnt)&&(div_cnt < CP_PULSE_WIDTH + CP_PULSE_WIDTH) ))
			begin
				cp_reg <= 1'b1;
			
			end
			else
			begin
				cp_reg <= 1'b0;
			end
			
		end
		
		default:
		begin
			cp_reg <= 1'b0;
		end	
	endcase
end


endmodule