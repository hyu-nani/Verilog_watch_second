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
					out,
					GMT);
					
	input				clk, rst;
	input				clk1sec;
	input		[4:0]	GMT;
	input		[3:0] sw_in;
	input		[11:0]year;
	input		[7:0]	month,day,hour,minute,second;
	input		[4:0]	index;
	
	output	[51:0]bin_time;
	output			en_time;
	output	[7:0]	out;
						
	reg				en_time;
	reg		[51:0]bin_time;
	reg		[11:0]year_set;
	reg		[7:0] month_set, day_set, hour_set, minute_set, second_set;
	
	wire		[4:0]	GMT;
	wire		[4:0]	index;
	wire		[11:0]year;
	wire		[7:0]	month,day,hour,minute,second;
	
	wire		[3:0] thoYear, hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	
	reg		[7:0]	out;
	reg				blink;
	reg		[2:0] cursor;
	reg		[4:0]	max_date;
	reg		[7:0]	gmt_hour,gmt_min,gmt_day;
	reg		[7:0]	cal_hour,cal_min,cal_day;
	wire				leap_year;
	
	assign leap_year = (((year_set % 4) == 0 && (year_set % 100) != 0) || (year_set % 400) == 0) ? 1'b1 : 1'b0;
	
	always @(posedge clk1sec) begin
		blink 	<= 1 - blink;
	end
										
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second_set),
										.rst			(rst),
										.hun			(),
										.ten			(tenSecond),
										.one			(oneSecond) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(cal_min),
										.rst			(rst),
										.hun			(),
										.ten			(tenMinute),
										.one			(oneMinute));									
	
	bin2bcd				CVT_hour ( 															// 시간
										.clk			(clk),
										.bin_bcd		(cal_hour),
										.rst			(rst),
										.hun			(),
										.ten			(tenHour),
										.one			(oneHour));
										
	bin2bcd				  CVT_day ( 															// 일
										.clk			(clk),
										.bin_bcd		(cal_day),
										.rst			(rst),
										.hun			(),
										.ten			(tenDay),
										.one			(oneDay));
										
	bin2bcd				CVT_month ( 															// 월
										.clk			(clk),
										.bin_bcd		(month_set),
										.rst			(rst),
										.hun			(),
										.ten			(tenMonth),
										.one			(oneMonth));

	bin3bcd				 CVT_year ( 															// 년도
										.clk			(clk),
										.bin_bcd		(year_set),
										.rst			(rst),
										.tho			(thoYear),
										.hun			(hunYear),
										.ten			(tenYear),
										.one			(oneYear));
										
										
	
	always @ ( posedge clk or negedge rst )begin
		if(!rst)begin
			out	 <=	8'h00;
			cursor <=	3'd0;
		end
		else begin
			case(month_set)
				8'd1, 8'd3, 8'd5, 8'd7, 8'd8, 8'd10, 8'd12 :	
						max_date	<= 8'd31;
				8'd2 :	
						max_date	<= 8'd28+leap_year;
				8'd4, 8'd6, 8'd9, 8'd11	:
						max_date <=	8'd30;
				default : max_date <= 0;
			endcase
			case(GMT)
				0	:	begin
							gmt_hour <= 8'd0;
							gmt_min	<=	8'd0;
						end
				1	:	begin
							gmt_hour <= 8'd1;
							gmt_min	<=	8'd0;
						end
				2	: 	begin
							gmt_hour <= 8'd2;
							gmt_min	<=	8'd0;
						end
				3	: 	begin
							gmt_hour <= 8'd3;
							gmt_min	<=	8'd0;
						end
				4	:	begin
							gmt_hour <= 8'd3;
							gmt_min	<=	8'd30;
						end
				5	:	begin
							gmt_hour <= 8'd4;
							gmt_min	<=	8'd0;
						end
				6	:	begin
							gmt_hour <= 8'd4;
							gmt_min	<=	8'd30;
						end
				7	:	begin
							gmt_hour <= 8'd5;
							gmt_min	<=	8'd0;
						end
				8	:	begin
							gmt_hour <= 8'd5;
							gmt_min	<=	8'd30;
						end
				9	:	begin
							gmt_hour <= 8'd6;
							gmt_min	<=	8'd0;
						end
				10	:	begin
							gmt_hour <= 8'd6;
							gmt_min	<=	8'd30;
						end
				11	:	begin
							gmt_hour <= 8'd7;
							gmt_min	<=	8'd0;
						end
				12	:	begin
							gmt_hour <= 8'd8;
							gmt_min	<=	8'd0;
						end
				13	:	begin
							gmt_hour <= 8'd9;
							gmt_min	<=	8'd0;
						end
				14	:	begin
							gmt_hour <= 8'd9;
							gmt_min	<=	8'd30;
						end
				15	:	begin
							gmt_hour <= 8'd10;
							gmt_min	<=	8'd0;
						end
				16	:	begin
							gmt_hour <= 8'd11;
							gmt_min	<=	8'd0;
						end
				17	:	begin
							gmt_hour <= 8'd12;
							gmt_min	<=	8'd0;
						end
				default: begin
						gmt_hour <= 8'd0;
						gmt_min	<=	8'd0;
						end
			endcase
			/////////////////////////////////////////////////// GMT hour calcultation
			cal_day	=	day_set + gmt_day;
			cal_hour	=	hour_set + gmt_hour;
			cal_min	=	minute_set + gmt_min;
			if(	  cal_day >= max_date && cal_hour >= 8'd23 && cal_min >= 8'd59)begin 	//111
				cal_day	<=	1'd1;
				cal_hour	<=	hour_set + gmt_hour - 8'd23;
				cal_min	<=	minute_set +gmt_min - 8'd60;
			end
			else if(cal_day >= max_date && cal_hour > 8'd23 && cal_min < 8'd59)begin						//110
				cal_day	<=	1'd1;
				cal_hour	<=	hour_set + gmt_hour - 8'd24;
				cal_min	<=	minute_set +gmt_min;
			end
			else if(cal_day >= max_date && cal_hour < 8'd23 && cal_min >= 8'd59)begin						//101
				//cal_day	<=	1'd1;
				cal_hour	<=	hour_set + gmt_hour + 1'd1;
				cal_min	<=	minute_set + gmt_min - 8'd60;
			end
			else if(cal_day > max_date && cal_hour < 8'd23 && cal_min < 8'd59)begin													//100
				//cal_day	<=	1'd1;
				cal_hour	<=	hour_set + gmt_hour;
				cal_min	<=	minute_set + gmt_min;
			end
			else if(cal_day < max_date && cal_hour >= 8'd23 && cal_min >= 8'd59)begin							//011
				cal_day	<=	day_set + gmt_day + 1'd1;
				cal_hour	<=	hour_set + gmt_hour - 8'd23;
				cal_min	<=	minute_set + gmt_min - 8'd60;
			end
			else if(cal_day < max_date && cal_hour > 8'd23 && cal_min < 8'd59)begin													//010
				cal_day	<=	day_set + gmt_day + 1'd1;
				cal_hour	<=	hour_set + gmt_hour - 8'd24;
				cal_min	<=	minute_set + gmt_min;
			end
			else if(cal_day < max_date && cal_hour < 8'd23 && cal_min >= 8'd59)begin														//001
				cal_day	<=	day_set + gmt_day;
				cal_hour	<=	hour_set + gmt_hour + 1'd1;
				cal_min	<=	minute_set + gmt_min - 8'd60;
			end
			else begin
				cal_day	<=	day_set + gmt_day;
				cal_hour	<=	hour_set + gmt_hour;
				cal_min	<=	minute_set + gmt_min;
			end
		
			/////////////////////////////////////////////////////
			case (index)
				00 : out <= 8'h53;//S
				01 : out	<=	8'h45;//E
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h20;
				04 : out	<=	8'h20; 
				05 : 	if(blink && cursor == 3'd0)out	<=	8'h20;
						else	out	<=	8'h30+thoYear;
				06 :	if(blink && cursor == 3'd0)out	<=	8'h20;
						else	out	<=	8'h30+hunYear;
				07 :	if(blink && cursor == 3'd0)out	<=	8'h20;
						else	out	<=	8'h30+tenYear;
				08 :	if(blink && cursor == 3'd0)out	<=	8'h20;
						else	out	<=	8'h30+oneYear;
				09 : out	<=	8'h59;//Y
				10 :	if(blink && cursor == 3'd1)out	<=	8'h20;
						else	out	<=	8'h30+tenMonth;
				11 :	if(blink && cursor == 3'd1)out	<=	8'h20;
						else	out	<=	8'h30+oneMonth;
				12 : out	<=	8'h4D;//M
				13 :	if(blink && cursor == 3'd2)out	<=	8'h20;
						else	out	<=	8'h30+tenDay;
				14 :	if(blink && cursor == 3'd2)out	<=	8'h20;
						else	out	<=	8'h30+oneDay;
				15 : out	<=	8'h44;//D
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;
				21 :	if(blink && cursor == 3'd3)out	<=	8'h20;
						else	out	<=	8'h30+tenHour;
				22 :	if(blink && cursor == 3'd3)out	<=	8'h20;
						else	out	<=	8'h30+oneHour;
				23 : out	<=	8'h48;//H
				24 :	if(blink && cursor == 3'd4)out	<=	8'h20;
						else	out	<=	8'h30+tenMinute;
				25 :	if(blink && cursor == 3'd4)out	<=	8'h20;
						else	out	<=	8'h30+oneMinute;
				26 : out	<=	8'h4D;//M
				27 :	if(blink && cursor == 3'd5)out	<=	8'h20;
						else	out	<=	8'h30+tenSecond;
				28 :	if(blink && cursor == 3'd5)out	<=	8'h20;
						else	out	<=	8'h30+oneSecond;
				29 : out	<=	8'h53;//S
				30 : out	<=	8'h20;
				31 : 	if(blink && cursor == 3'd6)out	<=	8'h20;
						else	out	<=	8'hAE;//->
			endcase
			//bin_time		<=	{year,month,day,hour,minute,second};
			en_time		<= 1'b0;
			if(sw_in == 4'b1000 && cursor < 3'd6)
				cursor	<=	cursor + 1;
			else if(sw_in == 4'b0100 && cursor > 3'd0)
				cursor	<=	cursor - 1;
			else if(sw_in == 4'b0010)begin
				if(cursor == 3'd0 && year_set < 12'd4095)
					year_set 	<= year_set + 1;
				else if(cursor == 3'd1 && month_set < 8'd12)
					month_set	<= month_set + 1;
				else if(cursor == 3'd2 && day_set < max_date)
					day_set		<=	day_set + 1;
				else if(cursor == 3'd3 && hour_set < 8'd23)
					hour_set		<=	hour_set + 1;
				else if(cursor == 3'd4 && minute_set < 8'd59)
					minute_set	<=	minute_set + 1;
				else if(cursor == 3'd5 && hour_set < 8'd59)
					second_set	<=	second_set + 1;
				else if(cursor == 3'd6)begin
					en_time		<= 1'b1;
				end
			end
			else if(sw_in == 4'b0001)begin
				if(cursor == 3'd0 && year_set > 1)
					year_set 	<= year_set - 1;
				else if(cursor == 3'd1 && month_set > 1)
					month_set	<= month_set - 1;
				else if(cursor == 3'd2 && day_set > 1)
					day_set		<=	day_set - 1;
				else if(cursor == 3'd3 && hour_set > 0)
					hour_set		<=	hour_set - 1;
				else if(cursor == 3'd4 && minute_set > 0)
					minute_set	<=	minute_set - 1;
				else if(cursor == 3'd5 && second_set > 0)
					second_set	<=	second_set - 1;
				else if(cursor == 3'd6)begin
					year_set		<= year;
					month_set	<=	month;
					day_set		<=	day;
					hour_set		<=	hour;
					minute_set	<=	minute;
					second_set	<=	second;
				end
			end
			bin_time		<=	{year_set,month_set,day_set,hour_set,minute_set,second_set};
		end
	end
endmodule
		
		
			
			