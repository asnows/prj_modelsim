`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/03 11:23:09
// Design Name: 
// Module Name: mdio_cfg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mdio_cfg
(
    input clk,
    input resetn,
    output mdc,
    inout  mdio,
	output[15:0] revdata,
	output mdio_done

);

localparam SEND_BYTES = 8'd5, READ_TIMES = 8'd4;
localparam  OP_WRITE = 2'b01,OP_READ = 2'b10;
reg tvalid = 1'b0,tvalid_reg = 1'b0;
reg[7:0] bytes_count = 8'd0;
reg[7:0] rev_count = 8'd0;
reg[4:0] reg_addr = 8'd0;
reg[15:0]reg_data = 16'd0;
reg[1:0] op_code  = 2'd0;
reg done_dly = 1'b0;
reg cfg_done = 1'b0;

reg[15:0] rest_dly = 16'd0;
reg phy_start = 1'b0;




(* preserve *) reg[15:0] rev_mem[1:0];

reg[15:0]rev_buff1=16'd0,rev_buff2=16'd0;

wire done;
(* keep *) wire[15:0] recvdata;





assign mdio_done = cfg_done;
assign revdata = rev_buff2;

always@(posedge clk)
begin
	
	if(~resetn)
	begin
		rest_dly <= 16'd0;
	end
	else
	begin
		rest_dly <= rest_dly + 1'b1;
	end
	
	
end


always@(posedge clk)
begin
	if(~resetn)
	begin
		phy_start <= 1'b0;
	end
	else
	begin
	
		if(rest_dly == 16'hffff)//16'hffff
		begin
				phy_start <= 1'b1;
		end
	end
end








always@(posedge clk)
begin
    if(~phy_start)
    begin
        done_dly <= 1'b0;
        
    end
    else
    begin
        done_dly <=  done;       
    end  
end



always@(posedge clk)
begin
    if(~phy_start)
    begin
       bytes_count <= 8'd0;
       tvalid_reg <= 1'b0; 
       tvalid <= 1'b0; 
    end
    else
    begin
        if((~done_dly & done) && (bytes_count < SEND_BYTES))
        begin
            bytes_count <= bytes_count + 1'b1;
            tvalid_reg <= 1'b1;            
        end
        else
        begin
            tvalid_reg <= 1'b0; 
        end
        
        tvalid <= tvalid_reg;            
    end
  
end




always@(posedge clk)
begin
	if(~phy_start)
	begin
		cfg_done <= 1'b0;
	end
	else
	begin
		if((bytes_count == SEND_BYTES) && (~done_dly & done))
		begin
			cfg_done <= 1'b1;
		end
		
	end
end



always@(posedge clk)
begin
    if(~phy_start)
    begin
        rev_count <= 8'd0;
    end
    else
    begin
    
        if((~done_dly & done) && (op_code == OP_READ))
        begin
				
				if(rev_count < READ_TIMES)
				begin
					rev_count <= rev_count + 1'b1;
				   rev_buff1 <= recvdata;
				   rev_buff2 <= rev_buff1;	
				
				end
				
        end
    end
end




always@(posedge clk)
begin
    case(bytes_count)
        8'd1:
        begin
            reg_addr <= 8'd2; 
            //reg_data <= 16'h6100;
            op_code  <= OP_READ; 
        end
        8'd2:
        begin
            reg_addr <= 8'd0; 
            reg_data <= 16'h3100;// 6100=本地循环
            op_code  <= OP_READ; 
        end
        8'd3:
        begin
            reg_addr <= 8'h1f; 
				reg_data <= 16'h0004;
            op_code  <= OP_READ;    //OP_READ                                              
        end
        8'd4:
        begin
              reg_addr <= 8'd0; 
				  reg_data <= 16'h0004;
              op_code  <= OP_READ; //OP_READ
        end
        
        8'd5:
        begin
				  reg_addr <= 8'h1f; 
              op_code  <= OP_READ; 
        end
        
        
    endcase
end

mdio_opr mdio_opr_I
(
    .clk(clk),
    .tvalid(tvalid),
    .op_code(op_code),
    .phy_addr(5'b00000),
    .reg_addr(reg_addr),
    .senddata(reg_data),
    .recvdata(recvdata),
    .mdc(mdc),
    .mdio(mdio),
    .done(done)
);







endmodule
