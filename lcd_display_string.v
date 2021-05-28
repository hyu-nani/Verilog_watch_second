module	lcd_display_string( 
	clk, 
	rst, 
	
	index, 
	data_cnt,
	out);
	
	input				clk;
	input				rst;
	input		[16:0] bin_watch;
	input		[4:0] hour;
	output	[7:0] out;
	
	wire		[4:0] index;
	reg		[7:0] out;
	
	always @ ( posedge clk or negedge rst )
		if(!rst)
			out	<=	8'h00;
		else
			case (index)
				00 : out	<=	8'h20;
				01 : out	<=	8'h20;
				02 : out	<=	8'h20;
				03 : out	<=	8'h20;
				04 : out	<=	8'h20;
				05 : out	<=	8'h20;
				06 : out	<=	8'h20;
				07 : out	<=	8'h20;
				08 : out	<=	8'h20;
				09 : out	<=	8'h20;
				10 : out	<=	8'h20;
				11 : out	<=	8'h20;
				12 : out	<=	8'h20;
				13 : out	<=	8'h20;
				14 : out	<=	8'h20;
				15 : out	<=	8'h20;
				
				// line2
				16 : case (bin_watch[)
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
				17 : case (data_cnt[7:4])
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
				19 : case (data_cnt[11:8])
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
				20 : case (data_cnt[15:12])
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
				22 : case (data_cnt[19:16])
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
				23 : case (data_cnt[23:20])
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
				
				
				