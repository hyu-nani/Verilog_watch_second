 module	lcd_display_list	(			
										clk, 
										rst,
										sw_in,
										en_time,
										hunYear_set, tenYear_set , oneYear_set, tenMonth_set, oneMonth_set, tenDay_set, oneDay_set,
										tenHour_set, oneHour_set, tenMinute_set, oneMinute_set, tenSecond_set, oneSecond_set,
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
	input				en_time;
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
	
/*	debouncer_clk			SW0	(
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
										.out			(sw[3])); */
	
	
	always @ ( posedge clk or negedge rst )
		if(!rst)
			out	<=	8'h00;
			
		else if(en_time==1)
			case (index)
				00 : out <= 8'h44;//D
				01 : out	<=	8'h41;//A
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h45;//E
				04 : out	<=	8'h20;// 
				05 : out	<=	8'h32;//2
				06 : out	<=	8'h30+hunYear_set;
				07 : out	<=	8'h30+tenYear_set;
				08 : out	<=	8'h30+oneYear_set;
				09 : out	<=	8'h2F;///
				10 : out	<=	8'h30+tenMonth_set;
				11 : out	<=	8'h30+oneMonth_set;
				12 : out	<=	8'h2F;///
				13 : out	<=	8'h30+tenDay_set;
				14 : out	<=	8'h30+oneDay_set;
				15 : out	<=	8'h20;
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;//
				21 : out	<=	8'h30+tenHour_set;
				22 : out	<=	8'h30+oneHour_set;
				23 : out	<=	8'h3A;//:
				24 : out	<=	8'h30+tenMinute_set;
				25 : out	<=	8'h30+oneMinute_set;
				26 : out	<=	8'h3A;//:
				27 : out	<=	8'h30+tenSecond_set;
				28 : out	<=	8'h30+oneSecond_set;
				29 : out	<=	8'h20;
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase
				
		else
			case (index)
				00 : out <= 8'h44;//D
				01 : out	<=	8'h41;//A
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h45;//E
				04 : out	<=	8'h20;// 
				05 : out	<=	8'h32;//2
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
				31 : out	<=	8'h20;
			endcase
		
endmodule
				
				
				