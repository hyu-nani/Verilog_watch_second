module	digital_clock	(
									clk,
									rst,
									lcd_rs,
									lcd_rw,
									lcd_e,
									lcd_data);
									
	input					clk, rst;
	output				lcd_rs;
	output				lcd_rw;
	output				lcd_e;
	output		[7:0] lcd_data;
	
	wire			[3:0] sec_1, min_1, hour_1;
	wire			[2:0] sec_10, min_10;
	wire			[1:0] hour_10;
	wire			[4:0] index_char;
	wire			[7:0] data_char;
	wire					en_clk;
	
	assign		rstn = ~rst;
	
		en_clk					U0		(
										.clk			(clk),
										.rst			(rstn),
										.en_1hz		(en_1hz) );
	
										
	watch						TIME (
										.clk			(en_1hz),
										.rst			(rstn),
										.sec_1		(sec_1),
										.sec_10		(sec_10),
										.min_1		(min_1),
										.min_10		(min_10),
										.hour_1		(hour_1),
										.hour_10		(hour_10) );
										
	en_clk_lcd				LCLK	( 
										.clk			(clk),
										.rst			(rstn),
										.en_clk		(en_clk) );
										
										
	lcd_display_string	STR	( 
										.clk			(clk), 
										.rst			(rstn), 
										.index		(index_char), 
										.sec_1		(sec_1),
										.sec_10		(sec_10),
										.min_1		(min_1),
										.min_10		(min_10),
										.hour_1		(hour_1),
										.hour_10		(hour_10),
										.out			(data_char) );
										
	lcd_driver(
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