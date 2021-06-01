module	digital_clock	(
							clk,
							rst,
							dip_sw,
							sw_in,
							lcd_rs,
							lcd_rw,
							lcd_e,
							lcd_data);
									
	input					clk, rst;
	input			[1:0] dip_sw;
	input			[3:0]	sw_in;
	output				lcd_rs;
	output				lcd_rw;
	output				lcd_e;
	output		[7:0] lcd_data;
	
	wire			[7:0] year;
	wire			[7:0]	month;
	wire			[7:0]	day, hour, minute, second;
	wire			[4:0] index_char;
	wire			[7:0] data_char;
	wire					en_1hz;
	wire					en_clk;
	wire					en_time;
	wire			[47:0]bin_time;
	wire			[3:0]	sw_in;
	wire			[1:0] dip_sw;
	wire			[3:0] ten1, one1, ten2, one2, ten3, one3, ten4, one4, ten5, one5, hun6, ten6, one6;
	wire			[3:0] ten1_set, one1_set, ten2_set, one2_set, ten3_set, one3_set;
	wire			[3:0] ten4_set, one4_set, ten5_set, one5_set, hun6_set, ten6_set, one6_set;
	wire			[4:0] cursor;
	
	assign		rstn = ~rst;
	
	en_clk					U0		(
										.clk			(clk),
										.rst			(rstn),
										.en_1hz		(en_1hz) );
										
	/* watch						TIME0 (
										.clk			(en_1hz),
										.rst			(rstn),
										.sec_1		(sec_1),
										.sec_10		(sec_10),
										.min_1		(min_1),
										.min_10		(min_10),
										.hour_1		(hour_1),
										.hour_10		(hour_10),
										.en_day		(en_day) );*/
	
	watch_date				TIME	(
										.active		(dip_sw[0]),
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.set_time	(en_time),
										.bin_time	(bin_time),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second));
										
	watch_set				TIME_SET(
										.active		(dip_sw[1]),
										.clk			(clk),
										.rst			(rstn),
										.sw_in		(sw_in),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
			/*       	[47:0] */.bin_time	(bin_time),
										.en_time		(en_time),
										.cursor		(cursor));
										
	
	bin2bcd		CVT_second_set ( 															// 초
										.clk			(clk),
										.bin_bcd		(bin_time[7:0]),
										.rst			(rstn),
										.hun			(),
										.ten			(ten1_set),
										.one			(one1_set) );
										
	bin2bcd		CVT_minute_set ( 															// 분
										.clk			(clk),
										.bin_bcd		(bin_time[15:8]),
										.rst			(rstn),
										.hun			(),
										.ten			(ten2_set),
										.one			(one2_set));									
	
	bin2bcd			CVT_hour_set ( 															// 시간
										.clk			(clk),
										.bin_bcd		(bin_time[23:16]),
										.rst			(rstn),
										.hun			(),
										.ten			(ten3_set),
										.one			(one3_set));
										
	bin2bcd			 CVT_day_set ( 															// 일
										.clk			(clk),
										.bin_bcd		(bin_time[31:21]),
										.rst			(rstn),
										.hun			(),
										.ten			(ten4_set),
										.one			(one4_set));
										
	bin2bcd			CVT_month_set ( 															// 월
										.clk			(clk),
										.bin_bcd		(bin_time[39:32]),
										.rst			(rstn),
										.hun			(),
										.ten			(ten5_set),
										.one			(one5_set));

	bin2bcd			CVT_year_set ( 															// 년도
										.clk			(clk),
										.bin_bcd		(bin_time[47:40]),
										.rst			(rstn),
										.hun			(hun6_set),
										.ten			(ten6_set),
										.one			(one6_set));
	
	
										
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second),
										.rst			(rstn),
										.hun			(),
										.ten			(ten1),
										.one			(one1) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(minute),
										.rst			(rstn),
										.hun			(),
										.ten			(ten2),
										.one			(one2));									
	
	bin2bcd				CVT_hour ( 															// 시간
										.clk			(clk),
										.bin_bcd		(hour),
										.rst			(rstn),
										.hun			(),
										.ten			(ten3),
										.one			(one3));
										
	bin2bcd				  CVT_day ( 															// 일
										.clk			(clk),
										.bin_bcd		(day),
										.rst			(rstn),
										.hun			(),
										.ten			(ten4),
										.one			(one4));
										
	bin2bcd				CVT_month ( 															// 월
										.clk			(clk),
										.bin_bcd		(month),
										.rst			(rstn),
										.hun			(),
										.ten			(ten5),
										.one			(one5));

	bin2bcd				 CVT_year ( 															// 년도
										.clk			(clk),
										.bin_bcd		(year),
										.rst			(rstn),
										.hun			(hun6),
										.ten			(ten6),
										.one			(one6));
										
										
	lcd_display_list		STL	( 
										.clk			(clk), 
										.rst			(rstn), 
										.sw_in		(sw_in),
										.hunYear_set		(hun6),
										.tenYear_set		(ten6),
										.oneYear_set		(one6),
										.tenMonth_set	(ten5),
										.oneMonth_set	(one5),
										.tenDay_set		(ten4),
										.oneDay_set		(one4),
										.tenHour_set		(ten3),
										.oneHour_set		(one3),
										.tenMinute_set	(ten2),
										.oneMinute_set	(one2),
										.tenSecond_set	(ten1),
										.oneSecond_set	(one1),
										.hunYear_set		(hun6),
										.tenYear_set		(ten6),
										.oneYear_set		(one6),
										.tenMonth_set	(ten5),
										.oneMonth_set	(one5),
										.tenDay_set		(ten4),
										.oneDay		(one4),
										.tenHour		(ten3),
										.oneHour		(one3),
										.tenMinute	(ten2),
										.oneMinute	(one2),
										.tenSecond	(ten1),
										.oneSecond	(one1),
										.index		(index_char),
										.out			(data_char)	);
										
	
	en_clk_lcd				LCLK	( 
										.clk			(clk),
										.rst			(rstn),
										.en_clk		(en_clk) );
										
										
	lcd_driver				DRV	(	
										.clk			(clk),
										.rst			(rstn),
										.en_clk		(en_clk),
										.data_char	(data_char),
										.index_char	(index_char),
										.lcd_rs		(lcd_rs),
										.lcd_rw		(lcd_rw),
										.lcd_e		(lcd_e),
										.lcd_data	(lcd_data) );
										
endmodule