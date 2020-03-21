/*
模块名：
	TCD1290D_driver
功能：
	CCD时序驱动
参数:
	sys_clk :系统输入时钟，默认100m；
	sh      :转移栅脉冲；
	f_cnt   :行频设置 f_cnt = 1000000000(ns)/（行频 x 160）, 最大值为8388608（行频 = 1行），最小值为2102（行频 = 2973）
	f1		:二相移位脉冲1；
	f2		:二相移位脉冲2，原理图上已实现f2b = f2；
	rs		:输出极复位脉冲;
	cp		:钳位脉冲（保持住电压水平）
	pclk	:像素时钟，与f1同频同相，供下游AD模块使用
	rs_plus	:输出复位脉冲，供下游AD模块使用,
	os_tvalid :输出数据有效, f2下降沿开始输出
设计原理：
		1、固定像素时钟pxl_clk为6.25m 时钟周期 = 160ns,由sys_clk 计数产生。同时生成同频率不同相位和脉宽的 rs_clk_reg和cp_clk_reg。
		   此时能达到的最高行频是2973行
		2、f1由pxl_clk 或上f1_reg产生。
		3、rs由rs_clk_reg 或上rs_reg 产生
		4、cp由cp_clk_reg 或上rs_reg 产生
*/

module TCD1209D_driver
(
input  sys_clk,
input[22:0]f_cnt, 
output sh,
output f1,
output f2,
output f2b,
output rs,
output cp,
output pclk,
output rs_plus,
output os_tvalid

);

localparam STATUS_IDEL = 2'd0,STATUS_LOAD = 2'd1,STATUS_TRAN = 2'd2,STATUS_WAIT = 2'd3;
localparam LINE_WIDTH = 12'd2088; //每行总像素
reg[1:0]   status = STATUS_IDEL;

reg sh_reg;
reg f1_reg;
reg rs_reg;

reg[22:0] wait_cnt = 23'd0;
reg[22:0] pxl_cnt = 23'd0;
reg[3:0]clk_div = 4'd0;
reg pxl_clk_reg;
reg rs_clk_reg;
reg cp_clk_reg;
wire pxl_clk;
wire f1_tmp;
reg tvalid_reg;


assign pxl_clk = pxl_clk_reg;
assign f1_tmp  = (pxl_clk | f1_reg);

assign sh = sh_reg;
assign f1 = f1_tmp;
assign f2 = ~f1_tmp;
assign rs = rs_reg & rs_clk_reg;
assign cp = rs_reg & cp_clk_reg;
assign pclk = pxl_clk;
assign rs_plus = rs_clk_reg;
assign os_tvalid = tvalid_reg;

always@(posedge sys_clk)
begin
	if(f_cnt <= (LINE_WIDTH + 23'd14))
	begin
		wait_cnt = 23'd0;
	end
	else
	begin
		wait_cnt <= f_cnt - LINE_WIDTH - 23'd13;
	end
	
end




always@(posedge sys_clk)
begin
	if(clk_div < 15)// 时钟计算
	begin
		clk_div <= clk_div + 1;
	end
	else
	begin
		clk_div <= 4'd0;
	end	
end



always@(posedge sys_clk)
begin
	case(clk_div)
		4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7:
		begin
			pxl_clk_reg <= 1'b1;
			rs_clk_reg  <= 1'b0;
			cp_clk_reg  <= 1'b0;
		end		
		4'd8,4'd9:
		begin
			pxl_clk_reg <= 1'b0;
			rs_clk_reg  <= 1'b1;
			cp_clk_reg  <= 1'b0;
		end
		4'd10,4'd11:
		begin
			pxl_clk_reg <= 1'b0;
			rs_clk_reg  <= 1'b0;
			cp_clk_reg  <= 1'b1;
		end

		4'd12,4'd13,4'd14,4'd15:
		begin
			pxl_clk_reg <= 1'b0;
			rs_clk_reg  <= 1'b0;
			cp_clk_reg  <= 1'b0;
		end
		
		default:
		begin
			pxl_clk_reg <= 1'b0;
			rs_clk_reg  <= 1'b0;
			cp_clk_reg  <= 1'b0;				
		end
		
		
	endcase
end



//生成状态机
always@(posedge pxl_clk)
begin
	case(status)
		STATUS_IDEL: //1 clk
		begin
			
			pxl_cnt <= 12'd0;
			tvalid_reg <= 1'b0;
			status <= STATUS_LOAD;

		end		
		
		STATUS_LOAD: //13 clk
		begin
			
			if(pxl_cnt < 12)
			begin
				pxl_cnt <= pxl_cnt + 1'b1;
				
			end
			else
			begin
				pxl_cnt <= 23'd0;
				status <= STATUS_TRAN;
			end
	
		end
		
		STATUS_TRAN: //2088 clk
		begin
			tvalid_reg <= 1'b1;
			if(pxl_cnt < LINE_WIDTH - 1'b1)
			begin
				pxl_cnt <= pxl_cnt + 1'b1;
			end
			else
			begin
				pxl_cnt <= 23'd0;
				
				status <= STATUS_WAIT;
			end
								
		end
		
		STATUS_WAIT:
		begin
			tvalid_reg <= 1'b0;
			if(pxl_cnt < wait_cnt)
			begin
				pxl_cnt <= pxl_cnt + 1'b1;
			end
			else
			begin
				pxl_cnt <= 23'd0;
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
always@(posedge pxl_clk)
begin
	case(status)
		
		STATUS_LOAD:
		begin
			if((23'd1 < pxl_cnt ) & (pxl_cnt < 10'd10))//8*160 = 1280ns
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



//生成移位脉冲f1,生成复位脉冲rs
always@(posedge pxl_clk)
begin
	case(status)
		
		STATUS_LOAD:
		begin
			if(pxl_cnt < 12)
			begin
				f1_reg <= 1'b1;
				rs_reg <= 1'b0;
			end
			else
			begin
				f1_reg <= 1'b0;
				rs_reg <= 1'b1;
			end

		end
				
		default:
		begin
			f1_reg <= 1'b0;
			rs_reg <= 1'b1;
		end	
	endcase
end

endmodule