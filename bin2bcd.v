module	bin2bcd	( 
							clk,
							bin_bcd,
							rst,
							ten,
							one);
							
	input			[7:0]	bin_bcd;
	input					clk,rst;
	output		[3:0] ten, one;
							
	wire			[7:0]	bin_bcd;
	reg			[3:0] ten, one;
	
	integer 				i;
							
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			ten	<= 4'd0;
			one	<= 4'd0;
		end
		
		else begin
			ten	= 4'd0;
			one	= 4'd0;
			for(i=7; i>=0; i=i-1) begin
				if(ten >= 5)
					ten = ten + 3;
				if(one >= 5)
					one = one + 3;
				
				ten = ten << 1;
				ten[0] = one[3];
				one = one << 1;
				one[0] = bin_bcd[i];
			end
			ten <= ten;
			one <= one;
		end
	end

endmodule				
				
				
		