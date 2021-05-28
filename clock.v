module clock(
	clk,
	rst,
	year,
	month,
	day,
	hour,
	minute,
	second);
	
	input					clk,rst;
	output	[7:0]		year,month,day,hour,minute,second;
	
	reg		[7:0]		year,month,day,hour,minute,second;
	
	wire					clk_1Hz;
	
	clkone_gen				U0(
		.clk		(clk),
		.rst		(rst),
		.clk1		(clk_1Hz));
		
	always @(posedge clk or negedge rst) begin
		if(!rst)	begin
			year	<=	8'd0;
			month	<=	8'd0;
			day	<=	8'd0;
			hour	<=	8'd0;
			minute<=	8'd0;
			second<=	8'd0;
		end
		else begin
			if(second == 8'd59) begin
				second	<= 8'd0;
				minute	<=	minute + 1'd1;
			end
			if(minute == 8'd59) begin
				minute	<=	8'd0;
				hour		<=	hour + 1'd1;
			end
			if(hour == 8'd23) begin
				hour		<=	8'd0;
				day		<=	day + 1'd1;
			end
			if(day == 8'd30) begin
				day		<= 8'd1;
				month		<=	month + 1'd1;
			end
			if(month == 8'd11) begin
				month 	<= 8'd1;
				year		<=	year + 1'd1;
			end
			if(year == 8'd99) 
					year		<=	8'd0;
			if(clk_1Hz)
				second <= second + 1'd1;
			else begin
				year 	<= year;
				month	<= month;
				day	<= day;
				hour	<=	hour;
				minute<=	minute;
				second<=	second;
			end
		end
	end

endmodule
