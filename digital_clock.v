module	digital_clock	(
							clk,
							rst,
							dip_sw,
							sw_in,
							lcd_rs,
							lcd_rw,
							lcd_e,
							lcd_data,
							led);
									
	input					clk, rst;
	input			[3:0] dip_sw;
	input			[3:0]	sw_in;
	output				lcd_rs;
	output				lcd_rw;
	output				lcd_e;
	output		[7:0] lcd_data;
	output		[7:0]	led;
	
	wire			[11:0] year;
	wire			[7:0]	month;
	wire			[7:0]	day, hour, minute, second;
	wire			[4:0] index_char;
	wire					en_1hz;
	wire					en_clk;
	wire					en_time,set_alarm;
	reg			[51:0]bin_time,bin_alarm;
	wire			[3:0]	sw_in;
	reg			[3:0]	sw_out;
	wire			[3:0] dip_sw;
	wire			[4:0] cursor;
	wire			[2:0] week;
	wire			[4:0]	gmt;
	wire					en_100hz;
	wire			[7:0] data_mode0,data_mode1,data_mode2,data_mode3;
	reg			[7:0]	data_char;
	wire			[3:0]	data_sw0,data_sw1,data_sw2,data_sw3;
	reg			[7:0]	led;
	assign		rstn = ~rst;
	
	sw_mux						M0	(
										.adress		(dip_sw),
										.in			(sw_out),
										.out0			(data_sw0),
										.out1			(data_sw1),
										.out2			(data_sw2),
										.out3			(data_sw3));
										
	data_demux					M1	(
										.adress		(dip_sw),
										.in0			(data_mode0),
										.in1			(data_mode1),
										.in2			(data_mode2),
										.in3			(data_mode3),
										.out			(data_char));
	
	debouncer_clk				sw0	(
										.clk			(clk),
										.rst			(rstn),
										.in			(sw_in[0]),
										.out			(sw_out[0]));
	debouncer_clk				sw1	(
										.clk			(clk),
										.rst			(rstn),
										.in			(sw_in[1]),
										.out			(sw_out[1]));
	debouncer_clk				sw2	(
										.clk			(clk),
										.rst			(rstn),
										.in			(sw_in[2]),
										.out			(sw_out[2]));
	debouncer_clk				sw3	(
										.clk			(clk),
										.rst			(rstn),
										.in			(sw_in[3]),
										.out			(sw_out[3]));
	
	
	en_clk					U0		(
										.clk			(clk),
										.rst			(rstn),
										.en_1hz		(en_1hz) );
								
	
	watch_time				TIME	(
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
										.second		(second),
										.week			(week),
										.max_date	(max_d));
										
	mode_watch				MODE0	( 	
										.clk			(clk), 
										.clk1sec		(en_1hz),
										.rst			(rstn), 
										.sw_in		(data_sw0),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
										//.max_date	(max_d),
										.index		(index_char),
										.out			(data_mode0),
										.bin_alarm	(bin_alarm),
										.week			(week),
										.gmt_out		(gmt),
										.alarmLED	(led),
										.rst_alarm	(rst_alarm));
										
	mode_watch_set			MODE1 (
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.sw_in		(data_sw1),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
										.bin_time	(bin_time),
										.en_time		(en_time),
										.index		(index_char),
										.out			(data_mode1),
										.GMT			(gmt));
										
	mode_alarm				MODE2	(
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.sw_in		(data_sw2),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
										.index		(index_char),
										.out			(data_mode2),
										.bin_alarm	(bin_alarm),
										.rst_alarm	(rst_alarm));

	mode_stopwatch			MODE3	(
										.clk			(clk),
										.rst			(rstn),
										.sw_in		(data_sw3),
										.index		(index_char),
										.out			(data_mode3));
								
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