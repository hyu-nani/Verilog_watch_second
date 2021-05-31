module	mode_watch_set ( 
					clk,
					rst,
					sw_in,
					year,
					month,
					day,
					hour,
					minute,
					second,
					bin_time,
					en_time,
					index,
					out);
					
	input				clk, rst;
	input		[3:0] sw_in;
	input		[7:0]	year,month,day,hour,minute,second;
	input		[4:0]	index;
	
	output	[47:0]bin_time;
	output			en_time;
	output	[7:0]	out;
						
	reg				en_time;
	reg		[47:0]bin_time;
	reg		[4:0] cursor;
	wire		[4:0]	index;
	wire		[7:0]	year,month,day,hour,minute,second;
	wire		[7:0] year_set, month_set, day_set, hour_set, minute_set, sec_set;
	reg		[7:0]	out;
	
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			en_time		<= 0;
		end
		else begin
			bin_time[7:0] 		<=	second;
			bin_time[15:8] 	<=	minute;
			bin_time[23:16] 	<=	hour;
			bin_time[31:24]	<=	day;
			bin_time[39:32] 	<=	month;
			bin_time[47:40] 	<=	year;
		end	
		/*
		else if(dip_sw[0] == 1) 
			en_time		<= 1;
		else
			en_time		<= 0;
		*/
	end
	
	always @ ( posedge clk or negedge rst )
		if(!rst)
			out	<=	8'h00;
		else 
			case (index)
				00 : out <= 8'h53;//S
				01 : out	<=	8'h45;//E
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h20;//
				04 : out	<=	8'h20;// 
				05 : out	<=	8'h32;//2
				06 : out	<=	8'h30;
				07 : out	<=	8'h30;
				08 : out	<=	8'h30;
				09 : out	<=	8'h2F;///
				10 : out	<=	8'h30;
				11 : out	<=	8'h30;
				12 : out	<=	8'h2F;///
				13 : out	<=	8'h30;
				14 : out	<=	8'h30;
				15 : out	<=	8'h20;
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;//
				21 : out	<=	8'h30;
				22 : out	<=	8'h30;
				23 : out	<=	8'h3A;//:
				24 : out	<=	8'h30;
				25 : out	<=	8'h30;
				26 : out	<=	8'h3A;//:
				27 : out	<=	8'h30;
				28 : out	<=	8'h30;
				29 : out	<=	8'h20;
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase
endmodule
		
		
			
			