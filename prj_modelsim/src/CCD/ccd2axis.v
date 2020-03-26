`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


    module ccd2axis 
    #(
        parameter DATA_WIDTH = 8,
		parameter EFFECT_COLS = 12'd2048,//每行有效像素
		parameter PRE_DUMMY_COLS = 8'd32,//每行前面无效像素
		parameter POST_DUMMY_COLS = 8'd8//每行后面无效像素
    )
    (

        input   pixel_clk     ,
        input   tvalid  	  ,
        input[DATA_WIDTH-1 : 0] tdata,
		input[10:0] rows, // 行数
        output[DATA_WIDTH - 1 : 0 ] m_axis_tdata ,
        output           m_axis_tlast ,
        output           m_axis_tuser ,
        output           m_axis_tvalid,
        input            m_axis_tready   
    );
		localparam STATE_IDEL = 2'd0,STATE_PRE_DUMMY = 2'd1,STATE_EFFECT = 2'd2,STATE_POST_DUMMMY = 2'd3;
		(*mark_debug="true"*)reg[1:0]   state = STATE_IDEL;
		
        (*mark_debug="true"*)reg[11:0]     rows_count = 12'd0;
		(*mark_debug="true"*)reg[12:0]     cols_count = 13'd0;
		reg sh_dly;
		(*mark_debug="true"*)reg tvalid_dly;
		reg tuser_reg;
		reg tlast_reg;
		reg tvalid_reg;
		reg[DATA_WIDTH-1 : 0] tdata_reg,tdata_reg1;
		
        assign m_axis_tdata = tdata_reg; 
        assign m_axis_tlast = tlast_reg; 
        assign m_axis_tuser = tuser_reg; 
        assign m_axis_tvalid = tvalid_reg;   
        
		always@(posedge pixel_clk)
		begin
			tvalid_dly <= tvalid;
			tdata_reg1  <= tdata;
			tdata_reg <= tdata_reg1;
		end


		always@(posedge pixel_clk)
		begin
			case(state)
				STATE_IDEL:
				begin
					cols_count <= 13'd0;
					if(~tvalid_dly & tvalid)
					begin
						state <= STATE_PRE_DUMMY;
						
						if(rows_count > rows - 1'b1)
						begin
							rows_count <= 1'b1;
						end
						else
						begin
							rows_count <= rows_count + 1'b1;
						end
						
					end
					
				end
				STATE_PRE_DUMMY:
				begin
					if(cols_count < PRE_DUMMY_COLS - 1'b1)
					begin
						cols_count <= cols_count + 1'b1;
					end
					else
					begin
						state <= STATE_EFFECT;
						cols_count <= 13'd0;
					end
					
					
				end
				STATE_EFFECT:
				begin
				
					if(cols_count < EFFECT_COLS - 1'b1)
					begin
						cols_count <= cols_count + 1'b1;
					end
					else
					begin
						state <= STATE_POST_DUMMMY;
						cols_count <= 13'd0;
					end
					
				end
				STATE_POST_DUMMMY:
				begin
					if(cols_count < POST_DUMMY_COLS - 1'b1)
					begin
						cols_count <= cols_count + 1'b1;
					end
					else
					begin
						state <= STATE_IDEL;
						cols_count <= 13'd0;
					end
				end
				
				default:
				begin
					state <= STATE_IDEL;
				end									
			endcase
		end
		
		
		
		//tvalid 
		always@(posedge pixel_clk)
		begin
			case(state)
				STATE_EFFECT :
				begin
					tvalid_reg <= 1'b1;
				end

				default:
				begin
					tvalid_reg <= 1'b0;
				end								
			endcase
		end
		
		//tuser
		always@(posedge pixel_clk)
		begin
			case(state)
				STATE_EFFECT :
				begin
					if((rows_count == 12'd1) && (cols_count == 13'd0))
					begin
						tuser_reg <= 1'b1;
					end
					else
					begin
						tuser_reg <= 1'b0;
					end
				end

				default:
				begin
					tuser_reg <= 1'b0;
				end								
			endcase
		end
		
		
		//tlast
		always@(posedge pixel_clk)
		begin
			case(state)
				STATE_EFFECT :
				begin
					//if((rows_count == rows) && (cols_count == (EFFECT_COLS - 1)))
					if(cols_count == (EFFECT_COLS - 1))
					begin
						tlast_reg <= 1'b1;
					end
					else
					begin
						tlast_reg <= 1'b0;
					end
				end

				default:
				begin
					tlast_reg <= 1'b0;
				end								
			endcase
		end
	
				
					  
endmodule
