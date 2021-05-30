module watch_date(
	clk,
	rst,
	en_day,
	set_date,
	bin_date,
	year,
	month,
	day);
	
	input						clk,rst;
	input						en_day;
	input						set_date;
	input		[20:0]		bin_date;
	
	output	[11:0]		year;
	output	[3:0]			month;
	output	[4:0]			day;
	
	wire						en_day;
	wire						set_date;
	wire		[20:0]		bin_date;
	
	reg		[11:0]		year;
	reg		[3:0]			month;
	reg		[4:0]			day;
	reg		[4:0]			max_date;
	
	always @(*)
		case(month)
				4'd1, 4'd3, 4'd5, 4'd7, 4'd8, 4'd10, 4'd12 :	
						max_date	<= 5'd31;
				4'd2 :	
						max_date	<= 5'd28;
				4'd4, 4'd6, 4'd9, 4'd11	:	
						max_date	<=	5'd30;까지
				default : max_date <= 0;
		endcase
		
	always @(posedge clk or negedge rst) begin
		if (!rst) begin
			{year, month, day} <= 0;
		end
		else if (set_date)
			{year, month, day}	<= bin_date;
		else begin
			year 	<= year;
			month	<= month;
			day		<= day;
			
			if (en_day) begin
				casez({year, month, day})
					{12'd4095, 4'd12, max_date} : begin
						year	<= 1'd1;
						month 	<= 1'd1;
						day		<= 1'd1;
					end
					
					{12'd?, 4'd12, max_date} : begin
						year	<= year + 1'd1;
						month	<= 1'd1;
						day		<= 1'd1;
					end
					
					{12'd?, 4'd?, max_date} : begin
						year	<= year;
						month	<= month + 1'd1;
						day		<= 1'd1;
					end
					
					default : begin
						year	<= year;
						month	<= month;
						day		<= day + 1'd1;
					end
				endcase
			end
		end
	end
endmodule