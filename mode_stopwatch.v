module mode_stopwatch(
							clk,
							rst,
							sw_in,
							index,
							out);
							
	input					clk, rst;
	input			[3:0]	sw_in;
	input			[4:0] index;
	
	output		[7:0] out;
	
	wire					en_100hz;
	wire			[3:0]	sw_in;	
	wire			[4:0] index;	
	wire			[3:0] tenMilSecond, oneMilSecond, tenSec_stop, oneSec_stop, tenMin_stop, oneMin_stop;
	reg			[7:0]	milsec, sec_stop, min_stop;
	reg			[7:0] out;
	reg					run,sw_out;
	/*
	debouncer_clk				U0	(
										.clk			(clk),
										.rst			(rst),
										.in			(),
										.out			(sw_out));
	
	always @(posedge sw_in)begin
		run <= 1- run;
	end
	*/
	en_clk_100hz		STOPCLK (
									.clk			(clk),
									.rst			(rst),
									.en_100hz	(en_100hz));
									
	bin2bcd			 CVT_milsecond ( 															// 밀리초
										.clk			(clk),
										.bin_bcd		(milsec),
										.rst			(rst),
										.hun			(),
										.ten			(tenMilSecond),
										.one			(oneMilSecond) );
	bin2bcd			 CVT_second 	( 															// second
										.clk			(clk),
										.bin_bcd		(sec_stop),
										.rst			(rst),
										.hun			(),
										.ten			(tenSec_stop),
										.one			(oneSec_stop) );
	bin2bcd			 CVT_min		 ( 															// minute
										.clk			(clk),
										.bin_bcd		(min_stop),
										.rst			(rst),
										.hun			(),
										.ten			(tenMin_stop),
										.one			(oneMin_stop) );
											
	
	always @ ( posedge clk or negedge rst )
		if(!rst) begin
			out			<=	8'h00;
			min_stop		<= 8'd00;
			sec_stop		<= 8'd00;
			milsec		<= 8'd00;
		end
		else begin
			case (index)
				00 : out <= 8'h53;//S
				01 : out	<=	8'h74;//t
				02 : out	<=	8'h6F;//o
				03 : out	<=	8'h70;//p
				04 : out	<=	8'h20;//
				05 : out	<=	8'h57;//W
				06 : out	<=	8'h61;//a
				07 : out	<=	8'h74;//t
				08 : out	<=	8'h63;//c
				09 : out	<=	8'h68;//h
				10 : out	<=	8'h20;
				11 : out	<=	8'h20;
				12 : 	if(sw_in[0]) 	out	<=	8'h22;
						else		out	<=	8'h21;
				13 :	if(sw_in[1]) 	out	<=	8'h22;
						else		out	<=	8'h21;
				14 :	if(sw_in[2]) 	out	<=	8'h22;
						else		out	<=	8'h21;
				15 :	if(sw_in[3]) 	out	<=	8'h22;
						else		out	<=	8'h21;
				
				// line2
				16 : out	<=	8'h54;//T
				17 : out	<=	8'h49;//I
				18 : out	<=	8'h4D;//M
				19 : out	<=	8'h45;//E
				20 : out	<=	8'h20;//
				21 : out	<=	8'h30+tenMin_stop;
				22 : out	<=	8'h30+oneMin_stop;
				23 : out	<=	8'h3A;//:
				24 : out	<=	8'h30+tenSec_stop;
				25 : out	<=	8'h30+oneSec_stop;
				26 : out	<=	8'h3A;//:
				27 : out	<=	8'h30+tenMilSecond;
				28 : out	<=	8'h30+oneMilSecond;
				29 : out	<=	8'h20;
				30 : out	<=	8'h20;
				31 : out	<=	8'h20;
			endcase	
			if(run) begin
				if(en_100hz) 
					casez({min_stop, sec_stop, milsec})
						{8'd59, 8'd59, 8'd99} : begin
												min_stop		<= 0;
												sec_stop		<= 0;
												milsec		<= 0;
						end
						{8'd?, 8'd59, 8'd99} : begin
													min_stop		<= min_stop + 1;
													sec_stop		<= 0;
													milsec		<= 0;
						end
						{8'd?, 8'd?, 8'd99} : begin
													min_stop		<= min_stop;
													sec_stop		<= sec_stop + 1;
													milsec		<= 0;
						end
						default				 : begin
													min_stop		<= min_stop;
													sec_stop		<= sec_stop;
													milsec		<= milsec + 1;
						end
					endcase
				else begin
					min_stop		<= min_stop;
					sec_stop		<= sec_stop;
					milsec		<= milsec;
				end		
			end
			if(sw_in==4'b1000)begin
				min_stop		<= 0;
				sec_stop		<= 0;
				milsec		<= 0;
			end
			else if(sw_in==4'b0001)begin
				run <= 1- run;
			end
		end
endmodule	
	
	
	
	
	
	