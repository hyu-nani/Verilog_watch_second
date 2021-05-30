module watch_date(
	clk,
	clk1sec,
	rst,
	set_time,
	bin_time,
	year,
	month,
	day,
	hour,
	minute,
	second);
	
	input						clk,rst;
	input						clk1sec;
	input						set_time;
	input		[47:0]		bin_time;
	
	output	[7:0]			year;
	output	[7:0]			month;
	output	[7:0]			day;
	output	[7:0]			hour;
	output	[7:0]			minute;
	output	[7:0]			second;
	
	wire						set_time;
	wire		[41:0]		bin_time;
	
	reg		[7:0]			year;
	reg		[7:0]			month;
	reg		[7:0]			day;
	reg		[7:0]			hour;
	reg		[7:0]			minute;
	reg		[7:0]			second;
	
	reg		[4:0]			max_date;
	
	always @(*)
		case(month)
				8'd1, 8'd3, 8'd5, 8'd7, 8'd8, 8'd10, 8'd12 :	
						max_date	<= 5'd31;
				8'd2 :	
						max_date	<= 5'd28;
				8'd4, 8'd6, 8'd9, 8'd11	:
						max_date <=	5'd30;
				default : max_date <= 0;
		endcase
	
		
	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			{year, month, day, hour, minute, second} <= 0;
		end
		else if (set_time)
			{year, month, day, hour, minute, second}	<= bin_time;
		else begin
			year 		<= year;
			month		<= month;
			day		<= day;
			hour		<= hour;
			minute	<=	minute;
			second	<=	second;
			
			if (clk1sec == 1) begin
				casez({year, month, day, hour, minute, second})
					{8'd255, 8'd12, max_date, 8'd23, 8'd59, 8'd59} : begin
						year		<= 1'd1;
						month 	<= 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{8'd?, 8'd12, max_date, 8'd23, 8'd59, 8'd59} : begin
						year		<= year + 1'd1;
						month 	<= 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{8'd?, 8'd?, max_date, 8'd23, 8'd59, 8'd59} : begin
						year		<= year;
						month 	<= month + 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{8'd?, 8'd?, 8'd?, 8'd23, 8'd59, 8'd59} : begin
						year		<= year; 
						month 	<= month;
						day		<= day + 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{8'd?, 8'd?, 8'd?, 8'd?, 8'd59, 8'd59} : begin
						year		<= year; 
						month 	<= month;
						day		<= day;
						hour		<=	hour + 1'd1;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{8'd?, 8'd?, 8'd?, 8'd?, 8'd?, 8'd59} : begin
						year		<= year; 
						month 	<= month;
						day		<= day;
						hour		<=	hour;
						minute	<=	minute + 1'd1;
						second	<=	1'd0;
					end
					
					default : begin
						year		<= year; 
						month 	<= month;
						day		<= day;
						hour		<=	hour;
						minute	<=	minute;
						second	<=	second + 1'd1;
					end
				endcase
			end
		end
	end
endmodule