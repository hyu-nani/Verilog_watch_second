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
	
	wire			[11:0]year;
	wire			[3:0]	month;
	wire			[4:0]	day;
	wire			[3:0] sec_1, min_1, hour_1;
	wire			[2:0] sec_10, min_10;
	wire			[1:0] hour_10;
	wire			[4:0] index_char;
	wire			[7:0] data_char;
	wire					en_clk;
	wire			[3:0]	sw_in;
	
	assign		rstn = ~rst;
	
	en_clk					U0		(
										.clk			(clk),
										.rst			(rstn),
										.en_1hz		(en_1hz) );
										
	watch						TIME0 (
										.clk			(en_1hz),
										.rst			(rstn),
										.sec_1		(sec_1),
										.sec_10		(sec_10),
										.min_1		(min_1),
										.min_10		(min_10),
										.hour_1		(hour_1),
										.hour_10		(hour_10),
										.en_day		(en_day) );
	
	watch_date				TIME1	(
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.set_time	(1'b0),
										.bin_time	(),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(),
										.minute		(),
										.second		());
										
	en_clk_lcd				LCLK	( 
										.clk			(clk),
										.rst			(rstn),
										.en_clk		(en_clk) );
										
	lcd_display_list		STL	( 
										.clk			(clk), 
										.rst			(rstn), 
										.sw_in		(sw_in), 
										.sec_1		(sec_1),
										.sec_10		(sec_10),
										.min_1		(min_1),
										.min_10		(min_10),
										.hour_1		(hour_1),
										.hour_10		(hour_10),
										.index		(index_char),
										.out			(data_char)	);
										
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