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
										//max_date,
										index,
										out,
										bin_alarm,
										week,
										gmt_out
								);
	
	input				clk;
	input				clk1sec;
	input				rst;
	input		[3:0]	sw_in;
	input		[11:0]year;
	input		[7:0] month,day,hour,minute,second;
	input		[4:0] index;
	//input		[4:0]	max_date;
	input		[51:0]bin_alarm;
	input		[2:0] week;
	output	[7:0] out;
	output	[4:0]	gmt_out;
	
	wire		[3:0]	sw;
	wire		[4:0] index;
	wire		[3:0] thoYear, hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	wire		[11:0]year;
	wire		[7:0] month,day,hour,minute,second;
	wire				leap_year;
	reg		[7:0]	cal_day,cal_hour,cal_min;
	reg		[2:0]	calweek;
	reg		[51:0]current_time;
	reg		[7:0] out;
	reg				blink;
	reg		[4:0]	gmt_out;
	reg		[7:0]	country0,country1,country2;
	reg		[7:0] gmt_day,gmt_hour,gmt_min;
	reg		[4:0] max_date;
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second),
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
										
	bin2bcd				  CVT_day ( 														// 일
										.clk			(clk),
										.bin_bcd		(cal_day),
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
	
	always @(*)
		case(month)
				8'd1, 8'd3, 8'd5, 8'd7, 8'd8, 8'd10, 8'd12 :	
						max_date	<= 8'd31;
				8'd2 :	
						max_date	<= 8'd28+leap_year;
				8'd4, 8'd6, 8'd9, 8'd11	:
						max_date <=	8'd30;
				default : max_date <= 0;
		endcase
	
	always @ ( posedge clk or negedge rst )begin
		if(!rst)
			out	<=	8'h00;
		else begin
			if(sw_in == 4'b1000)begin
				gmt_out <= gmt_out+1;
				if(gmt_out == 5'd17)
					gmt_out <= 0;
			end
			else if(sw_in == 4'b0100)begin
				gmt_out <= gmt_out-1;
				if(gmt_out == 0)
					gmt_out <= 5'd17;
			end	
			
			case(gmt_out)
				0	:	begin
							country0 <= 8'h4C;//L
							country1	<=	8'h4F;//O
							country2 <= 8'h4E;//N 
							gmt_hour <= 8'd0;
							gmt_min	<=	8'd0;
						end
				1	:	begin
							country0 <= 8'h50;//P
							country1	<=	8'h41;//A
							country2 <= 8'h52;//R 
							gmt_hour <= 8'd1;
							gmt_min	<=	8'd0;
						end
				2	: 	begin
							country0 <= 8'h43;//C
							country1	<=	8'h41;//A
							country2 <= 8'h49;//I 
							gmt_hour <= 8'd2;
							gmt_min	<=	8'd0;
						end
				3	: 	begin
							country0 <= 8'h4A;//J
							country1	<=	8'h45;//E
							country2 <= 8'h44;//D 
							gmt_hour <= 8'd3;
							gmt_min	<=	8'd0;
						end
				4	:	begin
							country0 <= 8'h54;//T
							country1	<=	8'h48;//H
							country2 <= 8'h52;//R 
							gmt_hour <= 8'd3;
							gmt_min	<=	8'd30;
						end
				5	:	begin
							country0 <= 8'h44;//D
							country1	<=	8'h58;//X
							country2 <= 8'h42;//B 
							gmt_hour <= 8'd4;
							gmt_min	<=	8'd0;
						end
				6	:	begin
							country0 <= 8'h4B;//K
							country1	<=	8'h42;//B
							country2 <= 8'h4C;//L 
							gmt_hour <= 8'd4;
							gmt_min	<=	8'd30;
						end
				7	:	begin
							country0 <= 8'h4B;//K
							country1	<=	8'h48;//H
							country2 <= 8'h49;//I 
							gmt_hour <= 8'd5;
							gmt_min	<=	8'd0;
						end
				8	:	begin
							country0 <= 8'h44;//D
							country1	<=	8'h45;//E
							country2 <= 8'h4C;//L 
							gmt_hour <= 8'd5;
							gmt_min	<=	8'd30;
						end
				9	:	begin
							country0 <= 8'h44;//D
							country1	<=	8'h41;//A
							country2 <= 8'h43;//C 
							gmt_hour <= 8'd6;
							gmt_min	<=	8'd0;
						end
				10	:	begin
							country0 <= 8'h52;//R
							country1	<=	8'h47;//G
							country2 <= 8'h4E;//N 
							gmt_hour <= 8'd6;
							gmt_min	<=	8'd30;
						end
				11	:	begin
							country0 <= 8'h42;//B
							country1	<=	8'h4B;//K
							country2 <= 8'h4B;//K 
							gmt_hour <= 8'd7;
							gmt_min	<=	8'd0;
						end
				12	:	begin
							country0 <= 8'h48;//H
							country1	<=	8'h4B;//K
							country2 <= 8'h47;//G 
							gmt_hour <= 8'd8;
							gmt_min	<=	8'd0;
						end
				13	:	begin
							country0 <= 8'h53;//S
							country1	<=	8'h45;//E
							country2 <= 8'h4C;//L 
							gmt_hour <= 8'd9;
							gmt_min	<=	8'd0;
						end
				14	:	begin
							country0 <= 8'h41;//A
							country1	<=	8'h44;//D
							country2 <= 8'h4C;//L 
							gmt_hour <= 8'd9;
							gmt_min	<=	8'd30;
						end
				15	:	begin
							country0 <= 8'h53;//S
							country1	<=	8'h59;//Y
							country2 <= 8'h44;//D 
							gmt_hour <= 8'd10;
							gmt_min	<=	8'd0;
						end
				16	:	begin
							country0 <= 8'h4E;//N
							country1	<=	8'h4F;//O
							country2 <= 8'h55;//U 
							gmt_hour <= 8'd11;
							gmt_min	<=	8'd0;
						end
				17	:	begin
							country0 <= 8'h57;//W
							country1	<=	8'h4C;//L
							country2 <= 8'h47;//G 
							gmt_hour <= 8'd12;
							gmt_min	<=	8'd0;
						end
				default: begin
						country0 <= 8'h20;//
						country1	<=	8'h20;//
						country2 <= 8'h20;//
						gmt_hour <= 8'd0;
						gmt_min	<=	8'd0;
						end
			endcase
			/////////////////////////////////////////////////// GMT hour calcultation
			calweek	=	week;
			cal_day	=	day + gmt_day;
			cal_hour	=	hour + gmt_hour;
			cal_min	=	minute + gmt_min;
			
			
			if(cal_hour	>= 8'd24)begin
				cal_hour= hour + gmt_hour - 8'd24;
				cal_day = day + gmt_day + 8'd1;
				calweek = week + 3'd1;
			end
			if(cal_min	>= 8'd59)begin
				cal_min = minute + gmt_min - 8'd60;
				cal_hour= hour + gmt_hour + 8'd1;
				if(cal_hour	>= 8'd24)begin
					cal_hour= hour + gmt_hour - 8'd23;
					cal_day = day + gmt_day + 8'd1;
					calweek = week + 3'd1;
				end
			end
			if(cal_day > max_date)begin
				cal_day = 8'd1;
			end
			
			
			/*
			if(	  cal_day >= max_date && cal_hour >= 8'd23 && cal_min >= 8'd59)begin 	//111
				calweek	<=	week + 3'd1;
				cal_day	<=	8'd1;
				cal_hour	<=	hour + gmt_hour - 8'd23;
				cal_min	<=	minute +gmt_min - 8'd60;
			end
			else if(cal_day >= max_date && cal_hour > 8'd23 && cal_min < 8'd59)begin						//110
				calweek	<=	week + 3'd1;
				cal_day	<=	8'd1;
				cal_hour	<=	hour + gmt_hour - 8'd24;
				cal_min	<=	minute +gmt_min;
			end
			else if(cal_day >= max_date && cal_hour < 8'd23 && cal_min >= 8'd59)begin						//101
				//cal_day	<=	1'd1;
				cal_hour	<=	hour + gmt_hour + 8'd1;
				cal_min	<=	minute + gmt_min - 8'd60;
			end
			else if(cal_day > max_date && cal_hour < 8'd23 && cal_min < 8'd59)begin													//100
				//cal_day	<=	1'd1;
				cal_hour	<=	hour + gmt_hour;
				cal_min	<=	minute + gmt_min;
			end
			else if(cal_day < max_date && cal_hour >= 8'd23 && cal_min >= 8'd59)begin			//011
				calweek	<=	week + 3'd1;
				cal_day	<=	day + gmt_day + 8'd1;
				cal_hour	<=	hour + gmt_hour - 8'd23;
				cal_min	<=	minute + gmt_min - 8'd60;
			end
			else if(cal_day < max_date && cal_hour > 8'd23 && cal_min < 8'd59)begin				//010
				calweek	<=	week + 3'd1;
				cal_day	<=	day + gmt_day + 8'd1;
				cal_hour	<=	hour + gmt_hour - 8'd24;
				cal_min	<=	minute + gmt_min;
			end
			else if(cal_day < max_date && cal_hour < 8'd23 && cal_min >= 8'd59)begin														//001
				cal_day	<=	day + gmt_day;
				cal_hour	<=	hour + gmt_hour;
				cal_min	<=	minute + gmt_min - 8'd60;
			end
			else begin
				calweek	<=	week;
				cal_day	<=	day + gmt_day;
				cal_hour	<=	hour + gmt_hour;
				cal_min	<=	minute + gmt_min;
			end
		*/
			/////////////////////////////////////////////////////
			case (index)
				00 : out <= 8'h30+thoYear;
				01 : out	<=	8'h30+hunYear;
				02 : out	<=	8'h30+tenYear;
				03 : out	<=	8'h30+oneYear;
				04 : out	<=	8'h2F;/// 
				05 : out	<=	8'h30+tenMonth;
				06 : out	<=	8'h30+oneMonth;
				07 : out	<=	8'h2F;///
				08 : out	<=	8'h30+tenDay;
				09 : out	<=	8'h30+oneDay;
				10 : out	<=	8'h20;
				11 : if(bin_alarm > 0) out	<=	8'h41;//A
						else	out	<=	8'h20;
				12 : out	<=	8'h20;
				13 : if(calweek == 3'd0) 	 out <= 8'h53;	//S
					  else if(calweek==3'd1) out <= 8'h4D;	//M
					  else if(calweek==3'd2) out <= 8'h54;	//T
					  else if(calweek==3'd3) out <= 8'h57;	//W
					  else if(calweek==3'd4) out <= 8'h54;	//T
					  else if(calweek==3'd5) out <= 8'h46;	//F
					  else if(calweek==3'd6) out <= 8'h53;	//S
					  else out <= 8'h20;
				14 : if(calweek == 3'd0) 	 out <= 8'h55;	//U
					  else if(calweek==3'd1) out <= 8'h4F;	//O
					  else if(calweek==3'd2) out <= 8'h55;	//U
					  else if(calweek==3'd3) out <= 8'h45;	//E
					  else if(calweek==3'd4) out <= 8'h48;	//H
					  else if(calweek==3'd5) out <= 8'h52;	//R
					  else if(calweek==3'd6) out <= 8'h41;	//A
					  else out <= 8'h20;
				15 : if(calweek == 3'd0) 	 out <= 8'h4E;	//N
					  else if(calweek==3'd1) out <= 8'h4E;	//N
					  else if(calweek==3'd2) out <= 8'h45;	//E
					  else if(calweek==3'd3) out <= 8'h44;	//D
					  else if(calweek==3'd4) out <= 8'h55;	//U
					  else if(calweek==3'd5) out <= 8'h49;	//I
					  else if(calweek==3'd6) out <= 8'h54;	//T
					  else out <= 8'h20;
				
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
				29 : out	<=	country0;
				30 : out	<=	country1;
				31 : out	<=	country2;
			endcase
			current_time	<=	{year,month,day,hour,minute,second};
			if(bin_alarm > 0)
				if(current_time > bin_alarm)
					if(blink==1)
						out 	<= 8'h20;				
		end
	end
endmodule
				
				
				