/*
ģ������
	AD9945_driver
���ܣ�
	AD9945����ģ��
����:
	sys_clk 	: ϵͳ����ʱ�ӣ�Ĭ��100m����CCD����ģ���sys_clk��ȣ�
	rs_plus		: CCD ��λ���壻
	pclk		: CCD ����ʱ�ӣ�
	SHP			: AD�����ο�ʱ�ӣ�
	SHD			: AD����ʱ�ӣ�
	DATACLK		: ���ݲ���ʱ��;
	DATA_IN		���������ݣ�
	tdata		: ������ݣ�
	tvalid		��������Ч����
	
���ԭ��
	SHP ��rs��λ������ʱ1��sys_clk�����ȴ�����ɡ�
	SHD ��pclk �½�������ȡ�������ɡ�
	DATACLK ��pclkȡ������,������f2��
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
	
	
	
	localparam SAMP_NUM = 12'd2088; // һ֡������
	localparam RS_LOW_WIDTH = 2;  //rs��������, ��λ10ns
	localparam RS_DLY_NUM   = 2;  // shp �����ccd rs ����ʱ������λ10ns (sys_clk = 10ns)
    localparam SHP_DLY_NUM  = 8;  // shd �����shp ����ʱ���� ��λ10ns


 
	
	
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


	//���� SHP
	always@(posedge sys_clk)
	begin
		shp_reg <= rs_plus;
	end

	//���� SHD
	always@(posedge sys_clk)
	begin
		shd_reg	<= pclk_dly & (~pclk);
	end

	
	
	//samp_cnt ����
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

	//����CLPOB
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

	//����tvalid
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