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
	reg		[7:0] year_set, month_set, day_set, hour_set, minute_set, second_set;
	
	wire		[4:0]	index;
	wire		[7:0]	year,month,day,hour,minute,second;
	
	wire		[3:0] hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	
	reg		[7:0]	out;
	reg				blink;
	reg		[2:0] cursor;
	reg		[3:0]	sw_out;
	
	always @(posedge clk1sec) begin
		blink 	<= 1 - blink;
	end
	

	debouncer_clk				sw0	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[0]),
										.out			(sw_out[0]));
	debouncer_clk				sw1	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[1]),
										.out			(sw_out[1]));
	debouncer_clk				sw2	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[2]),
										.out			(sw_out[2]));
	debouncer_clk				sw3	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[3]),
										.out			(sw_out[3]));
	
										
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second_set),
										.rst			(rst),
										.hun			(),
										.ten			(tenSecond),
										.one			(oneSecond) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(minute_set),
										.rst			(rst),
										.hun			(),
										.ten			(tenMinute),
										.one			(oneMinute));									
	
	bin2bcd				CVT_hour ( 															// 시간
										.clk			(clk),
										.bin_bcd		(hour_set),
										.rst			(rst),
										.hun			(),
										.ten			(tenHour),
										.one			(oneHour));
										
	bin2bcd				  CVT_day ( 															// 일
										.clk			(clk),
										.bin_bcd		(day_set),
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

	bin2bcd				 CVT_year ( 															// 년도
										.clk			(clk),
										.bin_bcd		(year_set),
										.rst			(rst),
										.hun			(hunYear),
										.ten			(tenYear),
										.one			(oneYear));
	
	always @ ( posedge clk or negedge rst )begin
		if(!rst)begin
			out	 <=	8'h00;
			cursor <=	3'd0;
		end
		else begin
			case (index)
				00 : out <= 8'h53;//S
				01 : out	<=	8'h45;//E
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h20;
				04 : out	<=	8'h20; 
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
			if(sw_out == 4'b1000 && cursor < 3'd6)
				cursor	<=	cursor + 1;
			else if(sw_out == 4'b0100 && cursor > 3'd0)
				cursor	<=	cursor - 1;
			else if(sw_out == 4'b0010)begin
				if(cursor == 3'd0)
					year_set 	<= year_set + 1;
				else if(cursor == 3'd1)
					month_set	<= month_set + 1;
				else if(cursor == 3'd2)
					day_set		<=	day_set + 1;
				else if(cursor == 3'd3)
					hour_set		<=	hour_set + 1;
				else if(cursor == 3'd4)
					minute_set	<=	minute_set + 1;
				else if(cursor == 3'd5)
					second_set	<=	second_set + 1;
				else begin
					en_time		<= 1'b1;
				end
			end
			else if(sw_out == 4'b0001)begin
				if(cursor == 3'd0)
					year_set 	<= year_set - 1;
				else if(cursor == 3'd1)
					month_set	<= month_set - 1;
				else if(cursor == 3'd2)
					day_set		<=	day_set - 1;
				else if(cursor == 3'd3)
					hour_set		<=	hour_set - 1;
				else if(cursor == 3'd4)
					minute_set	<=	minute_set - 1;
				else 
					second_set	<=	second_set - 1;
			end
			bin_time		<=	{year_set,month_set,day_set,hour_set,minute_set,second_set};
		end
	end
endmodule
		
		
			
			