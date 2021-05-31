module	mode_watch_set ( 
					clk,
					clk1sec,
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
	input				clk1sec;
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
	reg				blink;
	
	always @(posedge clk1sec) begin
		blink <= 1 - blink;
	end
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
				03 : out	<=	8'h20;
				04 : out	<=	8'h20; 
				05 : 	if(blink)out	<=	8'h32;
						else		out	<=	8'h20;
				06 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				07 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				08 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				09 : out	<=	8'h59;//Y
				10 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				11 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				12 : out	<=	8'h4D;//M
				13 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				14 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				15 : out	<=	8'h44;//D
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;
				21 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				22 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				23 : out	<=	8'h48;//H
				24 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				25 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				26 : out	<=	8'h4D;//M
				27 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				28 :	if(blink)out	<=	8'h30;
						else		out	<=	8'h20;
				29 : out	<=	8'h53;//S
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase
endmodule
		
		
			
			