module tb_lvds
(
	input clk_200m,
	input clk_445_5m,
	input resetn

);

wire dataout_p,dataout_n;
wire tx_clkdiv;
reg[9:0] tx_data;


reg[7:0] counts = 8'd0;



always@(negedge tx_clkdiv)
begin
	if(!resetn)
	begin
		counts <= 8'd0;
	end
	else
	begin
		if(counts < 200)
		begin
			counts <= counts + 1'b1;
		end
		
		if((counts < 5))
		begin
			//tx_data <= 10'b01_0101_0101;
			tx_data <= 8'h77;
		end
		else if( (counts >= 8'd5) && (counts <= 8'd20))
		begin
			tx_data <= 8'd0;
			//tx_data <= 10'h277;
		end
		else if( (counts >= 8'd20) && (counts <= 8'd150))
		begin
			tx_data <= 8'h277;
		end
		else
		begin
			tx_data <= {$random} % 256;
		end
		
		
	end
	
	
	
end




lvds
#(

	.GROUP("group_0"),
	.DIFF_TERM ("FALSE"),
	.CHANNEL_RX (4),
	.CHANNEL_TX (1),
	.IDELAY_OFFSET ( 2),
	.DATA_RATE  ("DDR"),
	.DATA_WIDTH (8 )
)
lvds_i
(
	.clrl_refclk	(clk_200m	),
	.reset			(~resetn	),
	.bit_align_en	(1'b1		),
	.rx_clkin_p		(clk_445_5m	),
	.rx_clkin_n		(~clk_445_5m),
	.datain_p		({4{dataout_p}}	),
	.datain_n		({4{dataout_n}}	),
	.pattern		(8'h77),
	.tx_data		(tx_data),
	.tx_clkdiv 		(tx_clkdiv),
	.tx_clk_p		(),
	.tx_clk_n		(),
	.dataout_p		(dataout_p),
	.dataout_n		(dataout_n),
	.rx_data_clk	(),
	.rx_data  		()

	
);



endmodule