module bin2BCD(
	bin,
	tens,
	ones);
	
	input	[7:0] bin;
	output[3:0]	tens,ones;
	
	reg	[3:0]	tens,ones;
	wire	[7:0]	bin;
	
	integer	i;
	
	always @(bin) begin
		tens		=	4'd0;
		ones		=	4'd0;
		for (i=7;i>=0;i=i-1) begin
			if(tens >= 5)
				tens 		= tens + 4'b0011;
			if(ones >= 5)
				ones 		= ones + 4'b0011;
				
			tens			= tens	<< 1;
			tens[0] 		= ones[3];
			ones 			= ones << 1;
			ones[0] 		= bin[i];
		end
		tens		<=	tens;
		ones		<=	ones;
	end
	
endmodule
