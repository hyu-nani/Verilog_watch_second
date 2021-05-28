module	digital_clock	(
									clk,
									rst);
									
	
	wire			en_1hz;
	wire			[5:0] minute, second;
	wire			[4:0] hour;
	
	
	
	en_clk					U0 (
										.clk			(clk),
										.rst			(rst),
										.en_1hz		(en_1hz) );
										
	watch						TIME (
										.clk			(clk),
										.rst			(rst),
										.en_1hz		(en_1hz),
										.hour			(hour),
										.minute		(minute),
										.second		(second) );
										
										
	lcd_display_string	LDS (
										.clk			(clk)