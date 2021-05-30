module watch_date(
	clk,
	en_1hz,
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
	input						en_1hz;
	input						set_time;
	input		[20:0]		bin_time;
	
	output	[11:0]		year;
	output	[3:0]			month;
	output	[4:0]			day;
	output	[4:0]			hour;
	output	[5:0]			minute;
	output	[5:0]			second;
	
	wire						set_time;
	wire		[37:0]		bin_time;
	
	reg		[11:0]		year;
	reg		[3:0]			month;
	reg		[4:0]			day;
	reg		[4:0]			hour;
	reg		[5:0]			minute;
	reg		[5:0]			second;
	
	reg		[4:0]			max_date;
	
	always @(*)
		case(month)
				4'd1, 4'd3, 4'd5, 4'd7, 4'd8, 4'd10, 4'd12 :	
						max_date	<= 5'd31;
				4'd2 :	
						max_date	<= 5'd28;
				4'd4, 4'd6, 4'd9, 4'd11	:
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
			
			if (clk_1hz) begin
				casez({year, month, day, hour, minute, second})
					{12'd4095, 4'd12, max_date, 5'd23, 6'd59, 6'd59} : begin
						year		<= 1'd1;
						month 	<= 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{12'd?, 4'd12, max_date, 5'd23, 6'd59, 6'd59} : begin
						year		<= year + 1'd1;
						month 	<= 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{12'd?, 4'd?, max_date, 5'd23, 6'd59, 6'd59} : begin
						year		<= year;
						month 	<= month + 1'd1;
						day		<= 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{12'd?, 4'd?, 5'd?, 5'd23, 6'd59, 6'd59} : begin
						year		<= year; 
						month 	<= month;
						day		<= day + 1'd1;
						hour		<=	1'd0;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{12'd?, 4'd?, 5'd?, 5'd?, 6'd59, 6'd59} : begin
						year		<= year; 
						month 	<= month;
						day		<= day;
						hour		<=	hour + 1'd1;
						minute	<=	1'd0;
						second	<=	1'd0;
					end
					
					{12'd?, 4'd?, 5'd?, 5'd?, 6'd?, 6'd59} : begin
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