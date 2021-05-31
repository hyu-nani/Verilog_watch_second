module	digital_clock	(
							clk,
							rst,
							sw_in,
							lcd_rs,
							lcd_rw,
							lcd_e,
							lcd_data);
									
	input					clk, rst;
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
	wire			[3:0]	sw_in;
	wire			[3:0] ten1, one1, ten2, one2, ten3, one3, ten4, one4, ten5, one5, hun6, ten6, one6;
	
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
	
	watch_date				TIME1	(
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.set_time	(1'b0),
										.bin_time	(),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second));
										
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
										.hunYear		(hun6),
										.tenYear		(ten6),
										.oneYear		(one6),
										.tenMonth	(ten5),
										.oneMonth	(one5),
										.tenDay		(ten4),
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