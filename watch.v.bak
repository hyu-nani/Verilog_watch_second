module	watch	(
						clk,
						rst,
						sec_1,
						sec_10,
						min_1,
						min_10,
						hour_1,
						hour_10 );
						
	input					clk, rst;
	output		[3:0] sec_1, min_1, hour_1;
	output		[2:0] sec_10, min_10;
	output		[1:0] hour_10;

	reg			[3:0] sec_1, min_1, hour_1;
	reg			[2:0] sec_10, min_10;
	reg			[1:0] hour_10;
	
	reg			en_sec_10, en_min_1, en_min_10, en_hour_1, en_hour_10;
										
										
	always @ ( posedge clk or negedge rst ) begin	// 초 일의 자리
		if(!rst) begin
			sec_1	<= 0;
			en_sec_10	<=	0;
		end
		
		else if ( sec_1 == 9 ) begin
			sec_1			<=	0;
			en_sec_10	<=	1;
		end
		
		else begin
			sec_1	<= sec_1 + 1;
			en_sec_10	<= 0; 
		end
	end
	
	always @ ( posedge en_sec_10 or negedge rst ) begin		// 초 십의 자리
		if(!rst) begin
			sec_10		<= 0;
			en_min_1		<= 0;
		end
				
		else if ( sec_10 == 5 ) begin
			sec_10		<= 0;
			en_min_1		<= 1;
		end

		else begin
			sec_10		<= sec_10 + 1;
			en_min_1		<= 0;
		end
	end		
	
	always @ (posedge en_min_1 or negedge rst) begin		// 분 일의 자리
		if(!rst) begin
			min_1			<= 0;
			en_min_10	<= 0;
		end
				
		else if ( min_1 == 9 ) begin
			min_1			<= 0;
			en_min_10	<= 1;
		end

		else begin
			min_1			<= min_1 + 1;
			en_min_10	<= 0;
		end
	end
	
	always @ (posedge en_min_10 or negedge rst) begin		// 분 십의 자리
		if(!rst) begin
			min_10		<= 0;
			en_hour_1	<= 0;
		end	
			
		else if ( min_10 == 5 ) begin
			min_10		<= 0;
			en_hour_1	<= 1;
		end

		else begin
			min_10		<= min_10 + 1;
			en_hour_1	<= 0;
		end
	end
			
	always @ (posedge en_hour_1 or negedge rst) begin		// 시 일의 자리
		if(!rst) begin
			hour_1		<= 0;
			en_hour_10	<= 0;
		end

		else if(hour_1 == 9) begin
			hour_1		<= 0;
			en_hour_10	<= 1;
		end

		else begin
			hour_1		<= hour_1 + 1;
			en_hour_10	<= 0;
		end
	end

	always @ (posedge en_hour_10 or negedge rst) begin		// 시 십의 자리
		if(!rst) begin
			hour_10		<= 0;
		end
		
		else if ( hour_10 == 3 ) begin
			hour_10		<= 0;
		end
		
		else
			hour_10		<= hour_10 + 1;
	end
	
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	