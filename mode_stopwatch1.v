module	mode_stopwatch1 ( 
						clk,
						en_100hz,
						rst,
						sw0,
						sw1,
						sw2,
						sw3,
						index,
						out);
					
	input				clk, rst;
	input				en_100hz;
	input				sw0,sw1,sw2,sw3;
	input		[4:0]	index;
	
	output	[7:0]	out;
	
	reg		[7:0]	minute,second,millis;

	wire		[3:0]	tenMillis, oneMillis, tenMinute, oneMinute, tenSecond, oneSecond;

	reg		[7:0]	out;
										
	bin2bcd			 CVT_second ( 															// 초
										.clk			(clk),
										.bin_bcd		(second),
										.rst			(rst),
										.hun			(),
										.ten			(tenSecond),
										.one			(oneSecond) );
										
	bin2bcd			 CVT_minute ( 															// 분
										.clk			(clk),
										.bin_bcd		(minute),
										.rst			(rst),
										.hun			(),
										.ten			(tenMinute),
										.one			(oneMinute));									
	
	bin2bcd			 CVT_millis ( 															// 시간
										.clk			(clk),
										.bin_bcd		(millis),
										.rst			(rst),
										.hun			(),
										.ten			(tenMillis),
										.one			(oneMillis));
										
	
	always @ ( posedge clk or negedge rst )begin
		if(!rst)begin
			out	 	<=	8'h0;
			minute	<=	8'd0;
			second	<=	8'd0;
			millis	<=	8'd0;
		end
		else begin
			case (index)
				00 : out <= 8'h53;//S
				01 : out	<=	8'h45;//E
				02 : out	<=	8'h54;//T
				03 : out	<=	8'h20;
				04 : out	<=	8'h20; 
				05 : out	<=	8'h20; 
				06 : out	<=	8'h20; 
				07 : out	<=	8'h20; 
				08 : out	<=	8'h20; 
				09 : out	<=	8'h20; 
				10 : out	<=	8'h20; 
				11 : out	<=	8'h20; 
				12 :	if(sw0==1) out	<=	8'h54;
						else	out	<=	8'h21;
				13 : 	if(sw1==1) out	<=	8'h54;
						else	out	<=	8'h21;
				14 : 	if(sw2==1) out	<=	8'h54;
						else	out	<=	8'h21;
				15 : 	if(sw3==1) out	<=	8'h54;
						else	out	<=	8'h21;
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;
				21 : out	<=	8'h20;
				22 : out	<=	8'h20; 
				23 : out	<=	8'h20; 
				24 : out	<=	8'h20; 
				25 : out	<=	8'h20; 
				26 : out	<=	8'h20; 
				27 : out	<=	8'h20; 
				28 : out	<=	8'h20;  
				29 : out	<=	8'h20; 
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase
		end
	end
endmodule
		
		
			
			