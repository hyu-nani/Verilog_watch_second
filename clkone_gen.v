module clkone_gen (
	clk,
	rst,
	clk1);
	
	input clk,rst;
	output clk1;
	
	reg	[24:0]	cnt_clk1;
	reg 				clk1;
	
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			cnt_clk1 <= 0;
			clk1		<= 0;
		end
		else if(cnt_clk1 == 25'd24999999) begin
			cnt_clk1	<= 0;
			clk1		<= ~clk1;
		end
		else
			cnt_clk1	<= cnt_clk1 + 1'b1;
	end
	
endmodule