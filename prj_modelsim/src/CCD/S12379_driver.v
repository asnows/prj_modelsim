/*
模块名：
	S12379_driver
功能：
	CCD时序驱动
参数:
	sys_clk :系统输入时钟，默认100m；
	sh      :转移栅脉冲；
	f1_cnt  :f1频率参数，单位hz,用来产生发f1频率，f1_cnt = sys_clk/(f1*2)，每当div_cnt = f1_cnt时，f1翻转一次;
	f1		:二相移位脉冲1；
	f2		:二相移位脉冲2；
	rs		:输出极复位脉冲;
*/

module S12379_driver
(
input  sys_clk,
input[7:0]f1_cnt,
output sh,
output f1,
output f2,
output rs

);

localparam STATUS_IDEL = 2'd0,STATUS_PREPARE = 2'd1,STATUS_LOAD = 2'd2,STATUS_TRAN = 2'd3;
localparam LINE_WIDTH = 12'd526; //每行总像素
localparam LOAD_PLUS_WIDTH = 8'd130; //加载时脉冲宽度
localparam RS_PULSE_WIDTH = 8'd1;



reg[1:0]   status = STATUS_IDEL;


reg sh_reg;
reg f1_reg,f1_dly;
wire f2_reg;
reg rs_reg;
reg[11:0] pxl_cnt = 12'd0;
reg[7:0] div_cnt = 8'd0;
reg[3:0] rs_cnt = 4'd0;




assign f2_reg =(status == STATUS_TRAN)? ~f1_reg : 1'b0;

assign sh = sh_reg;
assign f1 = f1_reg;
assign f2 = f2_reg;
assign rs = rs_reg;


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
				div_cnt <= 8'd0;
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
				div_cnt <= 8'd0;
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
				div_cnt <= 8'd0;
			end
			
		
			if(pxl_cnt < LINE_WIDTH)
			begin
				if((~f1_dly) & f1_reg) //检测f1上升沿
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
			if((8'd20 < div_cnt ) & (div_cnt < 8'd81))//1500ns
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
			if(8'd101 < div_cnt)
			begin
				f1_reg <= 1'b1;
			end
			else
			begin
				f1_reg <= 1'b0;
			end
				
		end
		
		STATUS_TRAN:
		begin
			if(div_cnt == 8'd0)
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
			rs_cnt <= 4'd0;
			rs_reg <= 1'b0;
		end
		
		STATUS_LOAD:
		begin
			rs_reg <= 1'b0;
			rs_cnt <= 4'd0;
		end
		
		STATUS_TRAN:
		begin
		
	    	if(rs_cnt < 4'd3 )
			begin
				rs_cnt <= rs_cnt + 1'b1;
			end
			else
			begin
				rs_cnt <= 4'd0;
			end
			
			
			
			if(rs_cnt == 4'd0)
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



endmodule