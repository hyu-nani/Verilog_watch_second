module	bin2bcd	( 
							clk,
							bin_bcd,
							rst,
							hun,
							ten,
							one);
							
	input			[7:0]	bin_bcd;
	input					clk,rst;
	output		[3:0] hun, ten, one;
							
	reg			[3:0] hun, ten, one;
	
	integer 				i;
							
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			hun		= 0;
			ten		= 0;
			one		= 0;
		end
		
		else
			for(i=7; i>=0; i=i-1) begin
				if(hun >= 5)
					hun = hun + 3;
				if(ten >= 5)
					ten = ten + 3;
				if(one >= 5)
					one = one + 3;
				
				hun = hun << 1;
				hun[0] = ten[3];
				ten = ten << 1;
				ten[0] = one[3];
				one = one << 1;
				one[0] = bin_bcd[i];
			end
	end

endmodule				
				
				
		