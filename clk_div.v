module clk_div(
	clk,
	rst,
	myclk);
	
	input clk,rst;
	output	myclk;
	
	reg	[21:0]	cnt_myclk;
	reg				myclk;
	
	always @(posedge clk or negedge rst) begin
		if(!rst)begin
			cnt_myclk	<=	0;
			myclk			<=	0;
			end
		else if(cnt_myclk == 22'd2499999)begin
			cnt_myclk	<=	0;
			myclk			<=	~myclk;
			end
		else
			cnt_myclk	<=	cnt_myclk + 1'b1;
	end
	
endmodule

			