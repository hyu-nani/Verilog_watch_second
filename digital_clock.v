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
	input			[3:0] dip_sw;
	input			[3:0]	sw_in;
	output				lcd_rs;
	output				lcd_rw;
	output				lcd_e;
	output		[7:0] lcd_data;
	
	wire			[7:0] year;
	wire			[7:0]	month;
	wire			[7:0]	day, hour, minute, second;
	wire			[4:0] index_char;
	wire					en_1hz;
	wire					en_clk;
	wire					en_time;
	reg			[47:0]bin_time;
	wire			[3:0]	sw_in;
	wire			[3:0] dip_sw;
	wire			[4:0] cursor;
	
	wire			[7:0] data_mode0,data_mode1,data_mode2,data_mode3;
	reg			[7:0]	data_char;
	
	assign		rstn = ~rst;
	
	always @(*) begin
		case(dip_sw)
			4'b0001		:	data_char	<=	data_mode1;
			4'b0010		:	data_char	<=	data_mode2;
			4'b0100		:	data_char	<=	data_mode3;
			default		:	data_char	<=	data_mode0;
		endcase
	end
	
	
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
										.second		(second));
										
	mode_watch				MODE0	( 	
										.clk			(clk), 
										.rst			(rstn), 
										.sw_in		(sw_in),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
										.index		(index_char),
										.out			(data_mode0));
										
	mode_watch_set			MODE1(
										.clk			(clk),
										.clk1sec		(en_1hz),
										.rst			(rstn),
										.sw_in		(sw_in),
										.year			(year),
										.month		(month),
										.day			(day),
										.hour			(hour),
										.minute		(minute),
										.second		(second),
										.bin_time	(bin_time),
										.en_time		(en_time),
										.index		(index_char),
										.out			(data_mode1));
										
	stopwatch				MODE3 (
										.clk			(clk),
										.rst			(rstn),
										.sw_in		(sw_in),
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