`timescale 1ns / 1ps

module top_tb
(
);

    reg clk_200m,clk_50m,clk_500m,clk_1000m,clk_100m;
	reg clk_445_5m;
    wire clk;
	wire tready;
    reg resetn = 1'b0;
    
    reg[7:0] data_test = 8'd0;
    reg tvalid = 1'b0;
    reg[7:0] tdata = 8'ha7;
	reg[7:0] tdata2 = 8'd0;
    
    
    always 
    begin
        #2.5 clk_200m = 0;
        #2.5 clk_200m = 1;
    end

    always 
    begin
        #10 clk_50m = 0;
        #10 clk_50m = 1;
    end

	always
	begin
		#1 clk_500m = 0;
		#1 clk_500m = 1;
	end
	
	always
	begin
		#0.5 clk_1000m = 0;
		#0.5 clk_1000m = 1;
	end
	
	always
	begin
		#5 clk_100m = 0;
		#5 clk_100m = 1;
	end

	always
	begin
		#1.12 clk_445_5m = 0;
		#1.12 clk_445_5m = 1;
	end

	
	
    
    initial
    begin

	 #0 tvalid = 1'b0;	
     #100 resetn = 1;
	 #100 tdata2 <=8'd3;
	 
	 #300 tdata2 <=8'd4;
	
    end











	always@(posedge clk)
	begin
		if(tvalid & tready)
		begin
			tdata <= tdata + 1'b1;
		end		
	end
	  
	assign clk = clk_50m;
	

	
	
	always@(posedge clk)
	begin
		if(resetn == 1'b1)
		begin
			tvalid <= 1'b1;
		end
		
	end
	


	iic_opr iic_opr_I
	(
		.clk      	(clk),
		.sendBytes	(8'd1),
		.tvalid		(tvalid),
		.tdata		(tdata),
		.tready(tready),
		.SCL   (),
		.SDA   () 
	);


reg[7:0] tmm1640_tdata = 8'd0;


always@(posedge clk)
begin
	if(tvalid == 1'b1)
	begin
		if(tmm1640_tdata < 255)
		begin
			tmm1640_tdata <= tmm1640_tdata + 1'b1;
		end
		
	end
	
	
end


// TM1640_driver TM1640_drive_i
// (
	// .clk(clk),
	// .tvalid(tvalid),
	// .sendBytes(8'd5),
	// .cmd1(8'h40),
	// .cmd2(8'hc0),
	// .tdata(tmm1640_tdata),
	// .cmd3(8'h8a),
	// .done(),
	// .SCL(),
	// .SDA()

// );





// TM1640_cfg TM1640_1_cfg
// (
// .clk(clk),
// .dispData(tdata2),
// .SCL(),
// .SDA()


// );

wire mdo;
// mdio_opr mdio_opr_I
// (
	// .clk(clk),
	// .tvalid(tvalid),
	// .op_code(2'b10),
	// .phy_addr(5'b00011),
	// .reg_addr(5'b00101),
	// .senddata(16'haaaa),
	// .recvdata(),
	// .mdc(),
	// .mdio(mdo),
	// .done()
	
// );

// mdio_cfg mdio_cfg_I
// (
    // .clk(clk),
    // .resetn(resetn),
    // .mdc(),
    // .mdio()

// );


// eth_frame eth_frame_I
// (
	// .clk(clk),
	// .mdio_done(resetn),
	// .txen(),
	// .txd()

// );

// MAC_Packet MAC_Packet_I
// (
    // .RSTn(resetn),
    // .clk(clk),
    // .TX_EN(),
    // .MAC_TX_EN(resetn),
    // .MAC_Data()
// );



// lvds_opr 
// #(
	 // .GROUP("group_0"),
	 // .IDELAY_OFFSET ( 2)

// )
// lvds_opr_i
// (
	// .clk(clk_500m)			,
	// .bit_align_en	(1'b1),
	// .idelayCtrl_rdy(resetn),
	// .data_in_p		(clk_500m),
	// .data_in_n		(~clk_500m),
	// . data_out		(),
	// . bit_align_done()

// );


wire dataout_p,dataout_n;
wire tx_clkdiv;
reg[9:0] tx_data;
reg flg = 1'b0;

reg[7:0] counts = 8'd0;


reg[9:0] random_data = 10'd0;
initial
begin
	#0 flg = 1'b0;
	#195 flg = 1'b1;
	
end

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