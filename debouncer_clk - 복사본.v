
module	debouncer_clk	(
	clk,	//clock
	rst,	//reset
	in,	//push switch input
	out);	//debouncer single pulse output
	
	input			clk;
	input			rst;
	input			in;
	output		out;
	
	wire			myclk;		//10Hz clk
	wire			q,		q3,	qb2,	qb4;
	wire			out2;
	
	clk_div					U0	(
	/*input					*/	.clk				(clk),
	/*input					*/	.rst				(rst),
	/*output					*/	.myclk			(myclk));	//10Hz clk
	
	d_ff						U1	(
	/*input					*/	.clk				(myclk),
	/*input					*/	.rst				(rst),
	/*input					*/	.set				(1'b1),
	/*input					*/	.d					(in),
	/*output					*/	.q					(q));
	
	d_ff						U2	(
	/*input					*/	.clk				(myclk),
	/*input					*/	.rst				(rst),
	/*input					*/	.set				(1'b1),
	/*input					*/	.d					(q),
	/*output					*/	.qb				(qb2));
	
	d_ff						U3	(
	/*input					*/	.clk				(clk),
	/*input					*/	.rst				(rst),
	/*input					*/	.set				(1'b1),
	/*input					*/	.d					(out2),
	/*output					*/	.q					(q3));
	
	d_ff						U4	(
	/*input					*/	.clk				(clk),
	/*input					*/	.rst				(rst),
	/*input					*/	.set				(1'b1),
	/*input					*/	.d					(q3),
	/*output					*/	.qb				(qb4));
	
	assign	out2	=	q	&	qb2;
	assign	out	=	q3	&	qb4;
	
endmodule
	
	
	
	
	
	
	
	
	