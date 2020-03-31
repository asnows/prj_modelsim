/*
模块名：
	AD9945_driver
功能：
	AD9945驱动模块
参数:

	pxl_clk		: CCD 像素时钟；
   os_tvalid	: CCD 数据输出有效（包裹dummp）
	DATA_IN		：输入数据；
	tdata		: 输出数据；
	tvalid		：数据有效脉冲
	
设计原理：

*/

module AD9945_driver
(
input  	   	pxl_clk		,
input		os_tvalid	,
output		CLPOB		,
output		PBLK		,
input[11:0] DATA_IN		,
output[11:0] tdata		,
output		 tvalid

);

	
	reg clpob_reg;
	reg[11:0] os_tvalid_dly;
	reg[11:0] tdata_reg;

	reg[7:0] clk_cnt = 8'd0;
	reg[11:0] samp_cnt = 12'd0;

	assign tvalid = os_tvalid_dly[11];
	assign tdata = tdata_reg;
	assign CLPOB = clpob_reg;
	assign PBLK = 1'b1;
	

	
	//samp_cnt 计算
	always@(posedge pxl_clk)
	begin
		if(os_tvalid)
		begin
			samp_cnt <= samp_cnt + 1'b1;
		end
		else
		begin
			samp_cnt <= 12'd0;
		end
	end

	//生成CLPOB
	always@(posedge pxl_clk)
	begin
		if((12'd13 < samp_cnt) && (samp_cnt < 12'd24))// 14 ~23 10pixels
		begin
			clpob_reg <= 1'b0;
		end
		else
		begin
			clpob_reg <= 1'b1;
		end
	end

	//生成tvalid
	always@(posedge pxl_clk)
	begin
		os_tvalid_dly <= {os_tvalid_dly[10:0],os_tvalid};
	end
	
	//data
	always@(posedge pxl_clk)
	begin
		tdata_reg <= DATA_IN;
	end
	

	
	
endmodule