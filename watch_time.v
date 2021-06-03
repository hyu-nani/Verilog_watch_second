module watch_time(
	clk,
	clk1sec,
	rst,
	bin_time,
	set_time,
	year,
	month,
	day,
	hour,
	minute,
	second,
	week,
	max_date);
	
	input						clk,rst;
	input						clk1sec;
	input						set_time;
	input		[51:0]		bin_time;
	
	output	[11:0]			year;
	output	[7:0]			month;
	output	[7:0]			day;
	output	[7:0]			hour;
	output	[7:0]			minute;
	output	[7:0]			second;
	output	[2:0]			week;
	output	[4:0]			max_date;
	
	wire						set_time;
	wire		[51:0]		bin_time;
	
	reg		[11:0]			year;
	reg		[7:0]			month;
	reg		[7:0]			day;
	reg		[7:0]			hour;
	reg		[7:0]			minute;
	reg		[7:0]			second;
	
	reg		[7:0]			max_date;
	reg		[2:0]			week;
	
	wire 						leap_year;
	
	
	assign leap_year = (((year % 4) == 0 && (year % 100) != 0) || (year % 400) == 0) ? 1'b1 : 1'b0;
	
	always @ (*) begin
		if(month <= 2) 
			week <= ((21*(year/100))/4 + 5*((year%100)-1)/4 + 26*(month+1)/10 + day-1) % 7;
		else
			week <= ((21*(year/100))/4 + 5*(year%100)/4 + 26*(month+1)/10 + day-1) % 7;
	end
	
	always @(*)
		case(month)
				8'd1, 8'd3, 8'd5, 8'd7, 8'd8, 8'd10, 8'd12 :	
						max_date	<= 8'd31;
				8'd2 :	
						max_date	<= 8'd28+leap_year;
				8'd4, 8'd6, 8'd9, 8'd11	:
						max_date <=	8'd30;
				default : max_date <= 0;
		endcase

		
	always @ (posedge clk or negedge rst) begin
		if (!rst) begin
			year		<=	12'd2021;
			month		<=	8'd5;
			day		<=	8'd30;
			hour		<=	8'd0;
			minute	<=	8'd0;
			second	<=	8'd0;
		end
		else if(set_time==1) begin
			year 		<= year;
			month		<= month;
			day		<= day;
			hour		<= hour;
			minute	<=	minute;
			second	<=	second;
			{year, month, day, hour, minute, second} <= bin_time;
		end
		else begin
			year 		<= year;
			month		<= month;
			day		<= day;
			hour		<= hour;
			minute	<=	minute;
			second	<=	second; 
			if (clk1sec == 1) begin
				casez({year, month, day, hour, minute, second})
					{12'd4095, 8'd12, max_date, 8'd23, 8'd59, 8'd59} : begin
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
