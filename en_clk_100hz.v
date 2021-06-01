module	en_clk_100hz	(
							clk,
							rst,
							en_100hz);
							
	input				clk, rst;
	output			en_100hz;
		
	reg	[25:0]	cnt_en_100hz;
	reg				en_100hz;
							
			
	always @ ( posedge clk or negedge rst ) begin
		if (!rst) begin
			cnt_en_100hz	<= 0;
			en_100hz		<= 0;
		end
		else if (cnt_en_100hz == 26'd499999) begin
			cnt_en_100hz	<= 0;
			en_100hz		<= 1;
		end
		else begin
			cnt_en_100hz	<= cnt_en_100hz + 1'b1;
			en_100hz	<= 0;
		end
	end

endmodule