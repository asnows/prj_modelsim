/*
ģ������
	AD9945_driver
���ܣ�
	AD9945����ģ��
����:

	pxl_clk		: CCD ����ʱ�ӣ�
   os_tvalid	: CCD ���������Ч������dummp��
	DATA_IN		���������ݣ�
	tdata		: ������ݣ�
	tvalid		��������Ч����
	
���ԭ��

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
	

	
	//samp_cnt ����
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

	//����CLPOB
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

	//����tvalid
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