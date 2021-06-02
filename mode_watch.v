 	module mode_watch	(			
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
	
	input				clk;
	input				clk1sec;
	input				rst;
	input		[3:0]	sw_in;
	input		[11:0]year;
	input		[7:0] month,day,hour,minute,second;
	input		[4:0] index;
	input		[51:0]bin_alarm;
	output	[7:0] out;
	
	wire		[3:0]	sw;
	wire		[4:0] index;
	wire		[3:0] thoYear, hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	reg		[7:0] out;
	reg				blink;
	
	wire		[11:0]year;
	wire		[7:0] month,day,hour,minute,second;
	reg		[51:0]current_time;
	integer			i;
	
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second),
										.rst			(rst),
										.hun			(),
										.ten			(tenSecond),
										.one			(oneSecond) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(minute),
										.rst			(rst),
										.hun			(),
										.ten			(tenMinute),
										.one			(oneMinute));									
	
	bin2bcd				CVT_hour ( 															// 시간
										.clk			(clk),
										.bin_bcd		(hour),
										.rst			(rst),
										.hun			(),
										.ten			(tenHour),
										.one			(oneHour));
										
	bin2bcd				  CVT_day ( 														// 일
										.clk			(clk),
										.bin_bcd		(day),
										.rst			(rst),
										.hun			(),
										.ten			(tenDay),
										.one			(oneDay));
										
	bin2bcd				CVT_month ( 														// 월
										.clk			(clk),
										.bin_bcd		(month),
										.rst			(rst),
										.hun			(),
										.ten			(tenMonth),
										.one			(oneMonth));

	bin3bcd				 CVT_year ( 														// 년도
										.clk			(clk),
										.bin_bcd		(year),
										.rst			(rst),
										.tho			(thoYear),
										.hun			(hunYear),
										.ten			(tenYear),
										.one			(oneYear));
	always @(posedge clk1sec) begin
		blink 	<= 1 - blink;
	end
	
	always @ ( posedge clk or negedge rst )
		if(!rst)
			out	<=	8'h00;
		else begin
			case (index)
				00 : out <= 8'h44;//D
				01 : out	<=	8'h41;//A
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h45;//E
				04 : out	<=	8'h20;// 
				05 : out	<=	8'h30+thoYear;
				06 : out	<=	8'h30+hunYear;
				07 : out	<=	8'h30+tenYear;
				08 : out	<=	8'h30+oneYear;
				09 : out	<=	8'h2F;///
				10 : out	<=	8'h30+tenMonth;
				11 : out	<=	8'h30+oneMonth;
				12 : out	<=	8'h2F;///
				13 : out	<=	8'h30+tenDay;
				14 : out	<=	8'h30+oneDay;
				15 : out	<=	8'h20;
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;//
				21 : out	<=	8'h30+tenHour;
				22 : out	<=	8'h30+oneHour;
				23 : out	<=	8'h3A;//:
				24 : out	<=	8'h30+tenMinute;
				25 : out	<=	8'h30+oneMinute;
				26 : out	<=	8'h3A;//:
				27 : out	<=	8'h30+tenSecond;
				28 : out	<=	8'h30+oneSecond;
				29 : out	<=	8'h20;
				30 : out	<=	8'h20;
				31 : 	if(bin_alarm > 0) out	<=	8'h41;//A
						else	out	<=	8'h20;
			endcase
			current_time	<=	{year,month,day,hour,minute,second};
			if(bin_alarm > 0)
				if(current_time > bin_alarm)
					if(blink==1)
						out 	<= 8'h20;
		end
endmodule
				
				
				