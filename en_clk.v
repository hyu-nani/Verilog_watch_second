module	en_clk	(
							clk,
							rst,
							en_1hz);
							
	input				clk, rst;
	output			en_1hz;
		
	reg	[25:0]	cnt_en_1hz;
	reg				en_1hz;
							
			
	always @ ( posedge clk or negedge rst ) begin
		if (!rst) begin
			cnt_en_1hz	<= 0;
			en_1hz		<= 0;
		end
		else if (cnt_en_1hz == 26'd4999) begin
			cnt_en_1hz	<= 0;
			en_1hz		<= 1;
		end
		else begin
			cnt_en_1hz	<= cnt_en_1hz + 1'b1;
			en_1hz	<= 0;
		end
	end

endmodule