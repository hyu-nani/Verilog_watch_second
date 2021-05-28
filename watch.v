module	watch	(
						clk,
						rst,
						en_1hz,
						bin_watch,
						hour,
						minute,
						second);
						
	input				clk, rst;
	input				en_1hz;
	
	output			[5:0] minute, second;
	output			[4:0] hour;

	reg				[5:0] minute, second;
	reg				[4:0] hour;
	wire				[16:0] bin_watch;
	wire						set_watch;
	
	
	always @ ( posedge clk or negedge rst ) begin	// 초 일의 자리
		if(!rst) begin
			sec_1	<= 0;
			en_sec_10	<=	0;
		end
		
		else if ( en_1hz == 1)	 begin
			sec_1	<=	sec_1 + 1;
		end
		
		else if ( sec_1 == 9 ) begin
			sec_1	<=	0;
			en_sec_10	<=	1;
		end
		
		else
			sec_1	<= sec_1;
	end
	
	always @ ( posedge clk or negedge rst ) begin		// 초 십의 자리
		if(!rst) begin
			sec_10		<= 0;
			en_min_1		<= 0;
		end
		
		else if ( en_sec_10 == 1 ) begin
			sec_10		<= sec_10 + 1;;
		end
		
		else if ( sec_10 == 5 ) begin
			sec_10		<= 0;
			en_min_1		<= 1;
		end
		
		else
			sec_10		<= sec_10;
	end		
	
	always @ (posedge clk or negedge rst) begin		// 분 일의 자리
		if(!rst) begin
			min_1			<= 0;
			en_min_10	<= 0;
		end
		
		else if ( en_min_1 == 1 ) begin
			min_1			<= min_1 + 1;
		end
		
		else if ( min_1 == 9 ) begin
			min_1			<= 0;
			en_min_10	<= 1;
		end
		
		else
			min_1			<= min_1;
	end
	
	always @ (posedge clk or negedge rst) begin		// 분 십의 자리
		if(!rst) begin
			min_10		<= 0;
			en_hour_1	<= 0;
		end
		
		else if ( en_min_10 == 1) begin
			min_10		<= min_10 + 1;
		end
		
		else if ( min_10 == 5 ) begin
			min_10		<= 0;
			en_hour_1	<= 1;
		end
		
		else
			min_10		<= min_10;
			
	always @ (posedge clk or negedge rst) begin		// 시 일의 자리
		if(!rst) begin
			hour_1		<= 0;
			en_hour_10	<= 0;
		end
		
		else if(en_hour_1 == 1) begin
			hour_1		<= hour_1 + 1;
		end
		
		else if(hour_1 == 9) begin
			hour_1		<= 0;
			en_hour_10	<= 1;
		end
		
		else
			hour_1		<= hour_1;
	end

	always @ (posedge clk or negedge rst) begin
		if(!rst)
			hour_10		<= 0;
			em_ampm		<= 0;
	
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	