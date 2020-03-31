/*
模块名：
	TCD1290D_driver
功能：
	CCD时序驱动
参数:
	pxl_clk 	:系统输入时钟，默认20m；等于f1的频率
	sh_puls     :转移栅脉冲；
	f_cnt   	:行频设置 f_cnt  = [1000000000(ns)/（ 行频 x 50ns）] - 2125; 最大值为19997875（行频 = 1行），最小值为0（行频 = 9411）
	f2_puls		:二相移位脉冲2，原理图上已实现f2b = f2；
	rs_puls		:输出极复位脉冲;
	cp_puls		:钳位脉冲（保持住电压水平）
	os_tvalid 	:输出数据有效, f2下降沿开始输出
设计原理：
	1、f1的频率等于pxl_clk的频率
*/

module TCD1209D_driver
(
input  pxl_clk,
input  triggerMode, //1 = 外部触发，0=内部触发
input  extTrigger,  //外部触发输入，
input[24:0]f_cnt, 
output sh_puls,
output f2_puls,
output rs_puls,
output os_tvalid

);

localparam STATUS_IDEL = 2'd0,STATUS_LOAD = 2'd1,STATUS_TRAN = 2'd2,STATUS_WAIT = 2'd3;
localparam LINE_WIDTH = 23'd2088; //每行总像素, 每行最小 2088 + 37 = 2125 个clk
reg[1:0]   status = STATUS_IDEL;



reg[24:0] wait_cnt = 25'd0;
reg[24:0] pxl_cnt = 25'd0;

reg sh_reg;
reg f2_reg;
reg rs_reg;
reg tvalid_reg;
reg ext_dly;

assign sh_puls = sh_reg;
assign f2_puls = f2_reg;
assign rs_puls = rs_reg;
assign os_tvalid = tvalid_reg;



always@(posedge pxl_clk)
begin
	ext_dly <= triggerMode;
end

always@(posedge pxl_clk)
begin
	if(triggerMode == 1'b1)
	begin
		wait_cnt <= 25'd0;
	end
	else
	begin
		wait_cnt <= f_cnt;
	end	
end


//生成状态机
always@(posedge pxl_clk)
begin
	case(status)
		STATUS_IDEL: //1 clk
		begin
			pxl_cnt <= 25'd0;
			tvalid_reg <= 1'b0;
			
			case(triggerMode)
				1'b0:
				begin
					status <= STATUS_LOAD;
				end
				
				1'b1:
				begin
					if( (~ext_dly) & triggerMode)
					begin
						status <= STATUS_LOAD;
					end
				end
				
				default:
				begin
					status <= STATUS_LOAD;
				end		
				
			endcase
			
		end		
		
		STATUS_LOAD: //35 clk
		begin
			
			if(pxl_cnt < 25'd34)
			begin
				pxl_cnt <= pxl_cnt + 1'b1;
			end
			else
			begin
				pxl_cnt <= 25'd0;
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
				pxl_cnt <= 25'd0;
				
				status <= STATUS_WAIT;
			end
								
		end
		
		STATUS_WAIT:  //1 clk
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


//生成转移栅脉冲SH,移位脉冲f1,复位脉冲rs
always@(negedge pxl_clk)
begin
	case(status)
		STATUS_LOAD:
		begin
			case(pxl_cnt)
				25'd0,25'd1,25'd2,25'd3,25'd4:
				begin
					sh_reg <= 1'b0;
					f2_reg <= 1'b0;
					rs_reg <= 1'b0;
				end
				25'd5,25'd6,25'd7,25'd8,25'd9,25'd10,25'd11,25'd12,25'd13,25'd14,
				25'd15,25'd16,25'd17,25'd18,25'd19,25'd20,25'd21,25'd22,25'd23,25'd24,
				25'd25,25'd26,25'd27,25'd28,25'd29:
				begin
					sh_reg <= 1'b1;
					f2_reg <= 1'b0;
					rs_reg <= 1'b0;				
				end	
				
				25'd30,25'd31,25'd32,25'd33,25'd34:
				begin
					sh_reg <= 1'b0;
					f2_reg <= 1'b0;
					rs_reg <= 1'b0;				
				end
				default:
				begin
					sh_reg <= 1'b0;
					f2_reg <= 1'b1;
					rs_reg <= 1'b1;						
				end	
			endcase
		end
		default:
		begin
			sh_reg <= 1'b0;
			f2_reg <= 1'b1;
			rs_reg <= 1'b1;						
		end	
	endcase
end

endmodule