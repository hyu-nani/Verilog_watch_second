module d_ff(
	clk,
	rst,
	set,
	d,
	q,
	qb);
	
	input 			clk, rst, set;
	input 			d;
	output 			q, qb;
	
	reg				q;
	
	assign			qb	=	~q;
	
	always @ (posedge clk or negedge rst or negedge set) begin
		if(!rst)
			q <= 0;
		else if(!set)
			q <= 1;
		else
			q <= d;
	end
	
endmodule