module clock(
	clk,
	rst,
	year,
	month,
	day,
	hour,
	mintue,
	second);
	
	input					clk,rst;
	output	[7:0]		year,month,day,hour,minute,second;
	
	
	clkone_gen				U0(
		.clk		(clk),
		.rst		(rst),
		.clk1		(clk1));
		
	always @(posedge 