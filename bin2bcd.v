module	bin2bcd	( 
							clk,
							bin_bcd,
							rst,
							en_time,
							hun,
							ten,
							one);
							
	input			[7:0]	bin_bcd;
	input					clk,rst;
	input					en_time;
	output		[3:0] hun, ten, one;
							
	wire			[7:0]	bin_bcd;
	reg			[3:0] hun, ten, one;
	
	integer 				i;
							
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			hun	<= 4'd0;
			ten	<= 4'd0;
			one	<= 4'd0;
		end
		
		else if(en_time==1) begin							// 시간설정
			hun	= 4'd0;
			ten	= 4'd0;
			one	= 4'd0;
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
			hun <= hun;
			ten <= ten;
			one <= one;			
		end
		
		else begin
			hun	= 4'd0;
			ten	= 4'd0;
			one	= 4'd0;
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
			hun <= hun;
			ten <= ten;
			one <= one;
		end
	end

endmodule				
				
				
		