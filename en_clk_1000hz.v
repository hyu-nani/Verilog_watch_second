module	en_clk_1000hz	(
									clk,
									rst,
									en_100hz);
	input					clk,rst;
	output		[16:0]en_100hz;
	
	reg			[16:0]en_100hz;
	reg					cnt_en_clk;
									
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			cnt_en_clk	<= 0;
			en_100hz	<= 0;
		end
		else if(cnt_en_clk == 499999) begin
			cnt_en_clk	<= 0;
			en_100hz	<= 1;
		end
		else begin
			cnt_en_clk	<= cnt_en_clk + 1;
			en_100hz	<= 0;
		end
	end
	
endmodule
			