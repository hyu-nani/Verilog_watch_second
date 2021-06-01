module mode_alarm	(
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
					index,
					out,
					bin_alarm);
					
	input					clk,rst;
	input					clk1sec;
	input		[3:0] 	sw_in;
	input		[7:0]		year,month,day,hour,minute,second;
	input		[4:0]		index;
	
	output	[7:0]		out;
	output	[47:0]	bin_alarm;
	
	wire		[4:0]		index;
	wire		[3:0] 	hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]		tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	
	reg		[7:0]		out;
	reg		[7:0]		year_alarm,month_alarm,day_alarm,hour_alarm,minute_alarm,second_alarm;
	reg					blink;
	reg		[2:0] 	cursor;
	reg		[47:0]	bin_alarm;
	reg					set_alarm;
	reg		[4:0]		max_date;
	
	wire					leap_year;
	
	assign leap_year = (((year % 4) == 0 && (year % 100) != 0) || (year % 400) == 0) ? 1'b1 : 1'b0;
	
	always @(posedge clk1sec) begin
		blink 	<= 1 - blink;
	end
										
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second_alarm),
										.rst			(rst),
										.hun			(),
										.ten			(tenSecond),
										.one			(oneSecond) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(minute_alarm),
										.rst			(rst),
										.hun			(),
										.ten			(tenMinute),
										.one			(oneMinute));									
	
	bin2bcd				CVT_hour ( 															// 시간
										.clk			(clk),
										.bin_bcd		(hour_alarm),
										.rst			(rst),
										.hun			(),
										.ten			(tenHour),
										.one			(oneHour));
										
	bin2bcd				  CVT_day ( 															// 일
										.clk			(clk),
										.bin_bcd		(day_alarm),
										.rst			(rst),
										.hun			(),
										.ten			(tenDay),
										.one			(oneDay));
										
	bin2bcd				CVT_month ( 															// 월
										.clk			(clk),
										.bin_bcd		(month_alarm),
										.rst			(rst),
										.hun			(),
										.ten			(tenMonth),
										.one			(oneMonth));

	bin2bcd				 CVT_year ( 															// 년도
										.clk			(clk),
										.bin_bcd		(year_alarm),
										.rst			(rst),
										.hun			(hunYear),
										.ten			(tenYear),
										.one			(oneYear));
					
	always @(posedge clk or negedge rst)begin
		if(!rst)begin
			out	 <=	8'h00;
			cursor <=	3'd0;
		end
		else begin
			case(month_alarm)
				8'd1, 8'd3, 8'd5, 8'd7, 8'd8, 8'd10, 8'd12 :	
						max_date	<= 8'd31;
				8'd2 :	
						max_date	<= 8'd28+leap_year;
				8'd4, 8'd6, 8'd9, 8'd11	:
						max_date <=	8'd30;
				default : max_date <= 0;
			endcase
			case (index)
				00 : out <= 8'h41;//A
				01 : out	<=	8'h4C;//L
				02 : out	<=	8'h41;//A
				03 : out	<=	8'h52;//R
				04 : out	<=	8'h4D;//M
				05 : 	if(blink && cursor == 3'd0)out	<=	8'h20;
						else	out	<=	8'h32;
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
				16 : out <= 8'h53;//S
				17 : out	<=	8'h45;//E
				18 : out	<=	8'h54;//T
				19 : out	<=	8'h20;//
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
						else	out	<=	8'h52;//R
			endcase
			if(bin_alarm == 0)
				set_alarm <= 1'b0;
			if(sw_in == 4'b1000 && cursor < 3'd6)
				cursor	<=	cursor + 1;
			else if(sw_in == 4'b0100 && cursor > 3'd0)
				cursor	<=	cursor - 1;
			else if(sw_in == 4'b0010)begin
				if(cursor == 3'd0 && year_alarm < 8'd255)
					year_alarm 	<= year_alarm + 1;
				else if(cursor == 3'd1 && month_alarm < 8'd12)
					month_alarm	<= month_alarm + 1;
				else if(cursor == 3'd2 && day_alarm < max_date)
					day_alarm		<=	day_alarm + 1;
				else if(cursor == 3'd3 && hour_alarm < 8'd23)
					hour_alarm		<=	hour_alarm + 1;
				else if(cursor == 3'd4 && minute_alarm < 8'd59)
					minute_alarm	<=	minute_alarm + 1;
				else if(cursor == 3'd5 && hour_alarm < 8'd59)
					second_alarm	<=	second_alarm + 1;
				else begin
					year_alarm	<=	8'd0;
					month_alarm	<=	8'd0;
					day_alarm	<=	8'd0;
					hour_alarm	<=	8'd0;
					minute_alarm<=	8'd0;
					second_alarm<=	8'd0;
				end
			end
			else if(sw_in == 4'b0001)begin
				if(cursor == 3'd0 && year_alarm > 1)
					year_alarm 	<= year_alarm - 1;
				else if(cursor == 3'd1 && month_alarm > 1)
					month_alarm	<= month_alarm - 1;
				else if(cursor == 3'd2 && day_alarm > 1)
					day_alarm		<=	day_alarm - 1;
				else if(cursor == 3'd3 && hour_alarm > 0)
					hour_alarm		<=	hour_alarm - 1;
				else if(cursor == 3'd4 && minute_alarm > 0)
					minute_alarm	<=	minute_alarm - 1;
				else if(cursor == 3'd5 && second_alarm > 0)
					second_alarm	<=	second_alarm - 1;
				else begin
					year_alarm	<=	year;
					month_alarm	<=	month;
					day_alarm	<=	day;
					hour_alarm	<=	hour;
					minute_alarm<=	minute;
					second_alarm<=	second;
				end
			end
			bin_alarm		<=	{year_alarm,month_alarm,day_alarm,hour_alarm,minute_alarm,second_alarm};
		end
	end
	
endmodule

	