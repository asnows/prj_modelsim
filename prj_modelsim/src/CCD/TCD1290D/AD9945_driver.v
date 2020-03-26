/*
模块名：
	AD9945_driver
功能：
	AD9945驱动模块
参数:
	sys_clk 	: 系统输入时钟，默认100m，与CCD驱动模块的sys_clk相等；
	rs_plus		: CCD 复位脉冲；
	pclk		: CCD 像素时钟；
	SHP			: AD采样参考时钟；
	SHD			: AD采样时钟；
	DATACLK		: 数据采样时钟;
	DATA_IN		：输入数据；
	tdata		: 输出数据；
	tvalid		：数据有效脉冲
	
设计原理：
	SHP 由rs复位脉冲延时1个sys_clk脉冲后却反生成。
	SHD 由pclk 下降沿脉冲取反后生成。
	DATACLK 由pclk取反生成,即等于f2。
*/

module AD9945_driver
(
input  	   	sys_clk		,
input       pclk		,
input		rs_plus		,
input		os_tvalid	,

output 		SHP			,
output    	SHD			,
output    	DATACLK		,
output		CLPOB		,
output		PBLK		,
input[11:0] DATA_IN		,

output[11:0] tdata		,
output		 tvalid

);

	localparam STATE_IDLE = 2'b00, STATE_SAMP= 2'b10,STATE_OUT= 2'b11;
	
	
	
	localparam SAMP_NUM = 12'd2088; // 一帧采样数
	localparam RS_LOW_WIDTH = 2;  //rs低脉冲宽度, 单位10ns
	localparam RS_DLY_NUM   = 2;  // shp 相对于ccd rs 的延时量，单位10ns (sys_clk = 10ns)
    localparam SHP_DLY_NUM  = 8;  // shd 相对于shp 的延时量， 单位10ns


 
	
	
	reg[1:0] state = STATE_IDLE;
	reg shp_reg;
	reg shd_reg;
	reg tvalid_reg;
	reg clpob_reg;

	reg[10:0] os_tvalid_dly;
	reg[11:0] tdata_reg;



	reg[7:0] clk_cnt = 8'd0;
	reg[11:0] samp_cnt = 12'd0;
	reg pclk_dly;
	
	
	assign SHP = ~shp_reg;
	assign SHD = ~shd_reg;
	assign DATACLK = pclk;
	assign tvalid = os_tvalid_dly[10];
	assign tdata = tdata_reg;
	assign CLPOB = clpob_reg;
	assign PBLK = 1'b1;
	

	always@(posedge sys_clk)
	begin
		pclk_dly <= pclk;
		
	end


	//生成 SHP
	always@(posedge sys_clk)
	begin
		shp_reg <= rs_plus;
	end

	//生成 SHD
	always@(posedge sys_clk)
	begin
		shd_reg	<= pclk_dly & (~pclk);
	end

	
	
	//samp_cnt 计算
	always@(posedge DATACLK)
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
	always@(posedge DATACLK)
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
	always@(posedge DATACLK)
	begin
		os_tvalid_dly <= {os_tvalid_dly[9:0],os_tvalid};
	end
	
	//data
	always@(posedge DATACLK)
	begin
		tdata_reg <= DATA_IN;
	end
	

	
	
endmodule