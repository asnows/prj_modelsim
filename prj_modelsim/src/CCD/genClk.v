module genClk
(
input sys_clk,
output f2 ,
output rs ,
output cp ,
output shp,
output shd,
output dataclk

);

reg[2:0] clk_div = 3'd0;
reg f2_reg ;
reg rs_reg ;
reg cp_reg ;
reg shp_reg;
reg shd_reg;

assign f2   = f2_reg ;
assign rs   = rs_reg ;
assign cp   = cp_reg ;
assign shp  = shp_reg;
assign shd  = shd_reg;

BUFG BUFG_inst
(
.O(dataclk),//1-bitoutput:Clockoutput
.I(f2_reg)//1-bitinput:Clockinput
);


always@(posedge sys_clk)
begin
	if(clk_div <3'd4)
	begin
		clk_div <= clk_div + 1'b1;
	end
	else
	begin
		clk_div <= 3'd0;
	end
end


always@(posedge sys_clk)
begin
	case(clk_div)
		3'd0:
		begin
			f2_reg  <= 1'b1;
			rs_reg  <= 1'b1;
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
			shd_reg <= 1'b1;
				
		end
		3'd1:
		begin
			f2_reg  <= 1'b1;
			rs_reg  <= 1'b0;
			cp_reg  <= 1'b1;
			shp_reg <= 1'b0;
			shd_reg <= 1'b1;
		
		end
		3'd2:
		begin
			f2_reg  <= 1'b1;
			rs_reg  <= 1'b0;
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
			shd_reg <= 1'b1;

		end
		3'd3:
		begin
			f2_reg  <= 1'b0;
			rs_reg  <= 1'b0;
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
			shd_reg <= 1'b0;	
		
		end
		3'd4:
		begin
			f2_reg  <= 1'b0;
			rs_reg  <= 1'b0;
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
			shd_reg <= 1'b1;					
		end	
		
		default:
		begin
			f2_reg  <= 1'b0;
			rs_reg  <= 1'b0;
			cp_reg  <= 1'b0;
			shp_reg <= 1'b1;
			shd_reg <= 1'b1;			
		end
	endcase
end















endmodule