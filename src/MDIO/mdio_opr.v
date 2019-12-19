/*
模块名称：mdio_opr
功能�?
	MDIO 发�?�数据和读取数据的时序实�?
接口�?
	clk		: 输入驱动时钟，一般要等于2.5MHZ
	tvalid	:数据有效�?
	op_code	:OP编码
	phy_addr:芯片的物理地�?
	reg_addr:欲读写的寄存器地�?
	senddata:待写数据
	recvdata:接收到的数据
	mdc		:MDIO的时钟线
	mdo		:MDIO数据线（写时用）
	mdi		:MDIO的数据线（读数据时用�?
	done    :读写操作完成
	
设计原理�?
    1.当检测到tvalid的上升沿时开始一次操作�??
	2.利用计clk的二分频产生 MDIO的时�?,用计数器counts计数来实现，用clk的上升沿驱动�?
	
	写状态下�?
		a.根据counts计数，向mdi_reg装填�?要写的数据（preamble，start，op,phy_addr,reg_addr 等）。利用clk的下降沿驱动�?
		b.把linked�?1，向MDIO输出mdi_reg中的数据�?
	
	读状态下�?
		a.根据counts计数，先向mdi_reg装填�?要写的数据（preamble，start，op,phy_addr,reg_addr 等）。利用clk的下降沿驱动�?
		b.然后把lingked设置�?0.�?始接受mdi输入的数据，并把数据装填到recvdata_reg�?

	3.当完成一次操作后，done拉高，表示当前操作已完成
	
	4.为了MDIO的数据能在MDC的中间点采集（读时）或改变（写时），�?以对于mdc和mdi分别采用clk的上升沿和下降沿来驱�?
*/



module mdio_opr
(
	(*mark_debug = "true"*)input clk,
	(*mark_debug = "true"*)input tvalid,
	(*mark_debug = "true"*)input[1:0] op_code,
	(*mark_debug = "true"*)input[4:0] phy_addr,
	(*mark_debug = "true"*)input[4:0] reg_addr,
	(*mark_debug = "true"*)input[15:0] senddata,
	(*mark_debug = "true"*)output[15:0]recvdata,
	(*mark_debug = "true"*)output mdc,
	(*mark_debug = "true"*)inout  mdio,
	(*mark_debug = "true"*)output done
);

localparam READ = 2'b10,WRITE = 2'b01;
(*mark_debug = "true"*)wire clk_n;
(*mark_debug = "true"*)reg tvalid_dly;
(*mark_debug = "true"*)reg[15:0] senddata_dly = 16'd0;
(*mark_debug = "true"*)reg[15:0] recvdata_reg = 16'd0;
(*mark_debug = "true"*)reg mdc_reg = 1'b1;
(*mark_debug = "true"*)reg mdo_reg = 1'b0;
(*mark_debug = "true"*)wire mdi_dly ;
(*mark_debug = "true"*)reg linked  = 1'b0;
(*mark_debug = "true"*)reg done_reg = 1'b1;

(*mark_debug = "true"*)reg[7:0] counts = 8'hff;
(*mark_debug = "true"*)reg[7:0] mdc_counts = 8'd0;

assign clk_n = ~clk;
assign mdc = mdc_reg;
assign mdio = (linked == 1'b1)?mdo_reg:1'bz;
assign mdi_dly = mdio;

assign done = done_reg;
assign recvdata = recvdata_reg;

always@(posedge clk)
begin
	tvalid_dly <= tvalid;
end

always@(*)
begin
	mdc_reg <= 	counts[0];
end


always@(posedge clk)
begin
	if(~tvalid_dly & tvalid)
	begin
		counts <= 8'd0;
		senddata_dly <= senddata;
	end
	else
	begin
		if(counts < 8'd129)
		begin
			counts <= counts +1'b1;
		end
	end
	
end


always@(posedge clk_n)
begin
	case(counts)
	
		//preamble
		8'd0:
		begin
			linked  <= 1'b1;
			//done_reg <= 1'b0;
			mdo_reg <= 1'b1;	
		end
		
		//start
		8'd64:
		begin
			mdo_reg <= 1'b0;
		end
		8'd66:
		begin
			mdo_reg <= 1'b1;
		end
		
		//OP
		8'd68: 
		begin
			mdo_reg <= op_code[1];
		end
		8'd70: 
		begin
			mdo_reg <= op_code[0];
		end
		
		//phy_addr
		8'd72:
		begin
			mdo_reg <= phy_addr[4];
		end
		8'd74:
		begin
			mdo_reg <= phy_addr[3];
		end
		8'd76:
		begin
			mdo_reg <= phy_addr[2];
		end
		8'd78:
		begin
			mdo_reg <= phy_addr[1];
		end
		8'd80:
		begin
			mdo_reg <= phy_addr[0];
		end	
		
		//reg_addr
		8'd82:
		begin
			mdo_reg <= reg_addr[4];
		end
		8'd84:
		begin
			mdo_reg <= reg_addr[3];
		end				
		8'd86:
		begin
			mdo_reg <= reg_addr[02];
		end		
		8'd88:
		begin
			mdo_reg <= reg_addr[1];
		end
		8'd90:
		begin
			mdo_reg <= reg_addr[0];
		end		
		
		//TA
		8'd92://TA bit1
		begin
			if(op_code == WRITE)
			begin
				mdo_reg <= 1'b1;
			end
			else
			begin
				mdo_reg <= 1'bz;
				linked <= 1'b0;
			end
				
		end
		8'd94://TA bit0
		begin
			
			mdo_reg <= 1'b0;
		
		end
		
		//senddata
		8'd96:
		begin
			mdo_reg <= senddata_dly[15];
		end
			
		8'd98:
		begin
			mdo_reg <= senddata_dly[14];
		end
		8'd100:
		begin
			mdo_reg <= senddata_dly[13];
		end
		8'd102:
		begin
			mdo_reg <= senddata_dly[12];
		end
		8'd104:
		begin
			mdo_reg <= senddata_dly[11];
		end
		8'd106:
		begin
			mdo_reg <= senddata_dly[10];
		end
		8'd108:
		begin
			mdo_reg <= senddata_dly[9];
		end
		8'd110:
		begin
			mdo_reg <= senddata_dly[8];
		end
		8'd112:
		begin
			mdo_reg <= senddata_dly[7];
		end
		8'd114:
		begin
			mdo_reg <= senddata_dly[6];
		end
		8'd116:
		begin
			mdo_reg <= senddata_dly[5];
		end
		8'd118:
		begin
			mdo_reg <= senddata_dly[4];
		end
		8'd120:
		begin
			mdo_reg <= senddata_dly[3];
		end
		8'd122:
		begin
			mdo_reg <= senddata_dly[2];
		end
		8'd124:
		begin
			mdo_reg <= senddata_dly[1];
		end
		8'd126:
		begin
			mdo_reg <= senddata_dly[0];
		end
		
		8'd128://z
		begin
			linked <= 1'b0;
			//done_reg <= 1'b1;
			mdo_reg <= 1'b1;
		end
		
	endcase
end


always@(*)
begin
    if(counts < 8'd128)
    begin
        done_reg <= 1'b0;
    end
    else
    begin
        done_reg <= 1'b1;
    end
end



always@(posedge clk)
begin
	case(counts)
		8'd96:
		begin
			recvdata_reg[15] <= mdi_dly;	
		end
		8'd98:
		begin
			recvdata_reg[14] <= mdi_dly;	
		end	
		8'd100:
		begin
			recvdata_reg[13] <= mdi_dly;	
		end		
		8'd102:
		begin
			recvdata_reg[12] <= mdi_dly;	
		end
		8'd104:
		begin
			recvdata_reg[11] <= mdi_dly;	
		end		
		8'd106:
		begin
			recvdata_reg[10] <= mdi_dly;	
		end
		8'd108:
		begin
			recvdata_reg[9] <= mdi_dly;	
		end		
		8'd110:
		begin
			recvdata_reg[8] <= mdi_dly;	
		end
		8'd112:
		begin
			recvdata_reg[7] <= mdi_dly;	
		end		
		8'd114:
		begin
			recvdata_reg[6] <= mdi_dly;	
		end
		8'd116:
		begin
			recvdata_reg[5] <= mdi_dly;	
		end		
		8'd118:
		begin
			recvdata_reg[4] <= mdi_dly;	
		end
		8'd120:
		begin
			recvdata_reg[3] <= mdi_dly;	
		end		
		8'd122:
		begin
			recvdata_reg[2] <= mdi_dly;	
		end
		8'd124:
		begin
			recvdata_reg[1] <= mdi_dly;	
		end		
		8'd126:
		begin
			recvdata_reg[0] <= mdi_dly;	
		end
		
		default:
		begin
			recvdata_reg <= recvdata_reg;	
		end
		
	endcase

end


endmodule