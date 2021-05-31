module	lcd_display_list( 
										clk, 
										rst,
										sw_in,
										hunYear,
										tenYear,
										oneYear,
										tenMonth,
										oneMonth,
										tenDay,
										oneDay,
										tenHour,
										oneHour,
										tenMinute,
										oneMinute,
										tenSecond,
										oneSecond,
										index,
										out);
	
	input				clk;
	input				rst;
	input		[3:0]	sw_in;
	input		[3:0] hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	input		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	input		[4:0] index;

	output	[7:0] out;
	
	wire		[3:0]	sw;
	wire		[4:0] index;
	wire		[3:0] hunYear, tenYear , oneYear, tenMonth, oneMonth, tenDay, oneDay;
	wire		[3:0]	tenHour, oneHour, tenMinute, oneMinute, tenSecond, oneSecond;
	reg		[7:0] out;
	
	integer			i;
	integer 			mode;
	
	debouncer_clk			SW0	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[0]),
										.out			(sw[0]));
										
	debouncer_clk			SW1	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[1]),
										.out			(sw[1]));
	
	debouncer_clk			SW2	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[2]),
										.out			(sw[2]));
										
	debouncer_clk			SW3	(
										.clk			(clk),
										.rst			(rst),
										.in			(sw_in[3]),
										.out			(sw[3]));
	
	
	always @ ( posedge clk or negedge rst )
		if(!rst)
			out	<=	8'h00;
		else
			case (index)
				00 : out <= 8'h32;
				01 : out	<=	8'h30+hunYear;
				02 : out	<=	8'h30+tenYear;
				03 : out	<=	8'h30+oneYear;
				04 : out	<=	8'h2F;
				05 : out	<=	8'h30+tenMonth;
				06 : out	<=	8'h30+oneMonth;
				07 : out	<=	8'h2F;
				08 : out	<=	8'h30+tenDay;
				09 : out	<=	8'h30+oneDay;
				10 : out	<=	8'h20;
				11 : out	<=	8'h20;
				12 : out	<=	8'h20;
				13 : out	<=	8'h20;
				14 : out	<=	8'h20;
				15 : out	<=	8'h20;
				
				// line2
				16 : out	<=	8'h30+tenHour;
				17 : out	<=	8'h30+oneHour;
				18 : out	<=	8'h3A;
				19 : out	<=	8'h30+tenMinute;
				20 : out	<=	8'h30+oneMinute;
				21 : out	<=	8'h3A;
				22 : out	<=	8'h30+tenSecond;
				23 : out	<=	8'h30+oneSecond;
				24 : out	<=	8'h20;
				25 : out	<=	8'h20;
				26 : out	<=	8'h20;
				27 : out	<=	8'h20;
				28 : out	<=	8'h20;
				29 : out	<=	8'h20;
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase
		
endmodule
				
				
				