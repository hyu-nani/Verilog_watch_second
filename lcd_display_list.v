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
				01 : case (hunYear)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				02 : case (tenYear)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				03 : case (oneYear)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				04 : out	<=	8'h2F;
				05 : case (tenMonth)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				06 : case (oneMonth)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				07 : out	<=	8'h2F;
				08 : case (tenDay)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				09 : case (oneDay)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				10 : out	<=	8'h20;
				11 : out	<=	8'h20;
				12 : out	<=	8'h20;
				13 : out	<=	8'h20;
				14 : out	<=	8'h20;
				15 : out	<=	8'h20;
				
				// line2
				16 : case (tenHour)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				17 : case (oneHour)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				18 : out	<=	8'h3A;
				19 : case (tenMinute)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				20 : case (oneMinute)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				21 : out	<=	8'h3A;
				22 : case (tenSecond)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
				23 : case (oneSecond)
						0 : out	<=	8'h30;
						1 : out	<= 8'h31;
						2 : out	<= 8'h32;
						3 : out	<= 8'h33;
						4 : out	<= 8'h34;
						5 : out	<= 8'h35;
						6 : out	<= 8'h36;
						7 : out	<= 8'h37;
						8 : out	<= 8'h38;
						9 : out	<= 8'h39;
					endcase
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
				
				
				