module	watch_set ( 
					active,	
					clk,
					rst,
					sw_in,
					year,
					month,
					day,
					hour,
					minute,
					second,
					bin_time,
					en_time,
					cursor);
					
	input				active;
	input				clk, rst;
	input		[3:0] sw_in;
	input		[7:0]	year,month,day,hour,minute,second;
	
	output	[47:0]bin_time;
	output			en_time;
	output	[4:0]	cursor;
						
	reg				en_time;
	reg		[47:0]bin_time;
	reg		[4:0] cursor;
	wire		[7:0]	year,month,day,hour,minute,second;
	wire		[7:0] year_set, month_set, day_set, hour_set, minute_set, sec_set;
	
	
	always @ (posedge clk or negedge rst) begin
		if(!rst) begin
			en_time		<= 0;
		end
		else if(active == 0)begin
			bin_time[7:0] 		<=	second;
			bin_time[15:8] 	<=	minute;
			bin_time[23:16] 	<=	hour;
			bin_time[31:24]	<=	day;
			bin_time[39:32] 	<=	month;
			bin_time[47:40] 	<=	year;
		end	
		else begin
			
		end
		/*
		else if(dip_sw[0] == 1) 
			en_time		<= 1;
		else
			en_time		<= 0;
		*/
	end
	/*
	always @ (en_time) begin
		if(!rst)
			cursor		<= 0;
		else begin
			if(sw_in[1]==1)
				if(cursor == 5'd31)
					cursor	<= 0;
				else
					cursor	<= cursor + 5'd1;
			else if(sw_in[0]==1)
				if(cursor == 5'd0)
					cursor	<= 5'd31;
				else
					cursor	<= cursor - 5'd1;
		end
	end
	*/
endmodule
		
		
			
		
	
/*	always @ (posedge clk or negedge rst) begin
		if(!rst)
			state	<= WATCH;
		else
			state	<= next;
	end
	
	always @ (state or dip_sw) begin
		case(state)
			WATCH : begin
				if (dip_sw[4] == 1)
					next		<= SET_WATCH;
				else
					next		<= WATCH;
			end
			
			SET_WATCH : begin
				if (dip_sw[3] == 1)
					next		<= SET_DATE;
				else
					next		<= WATCH;
			end
	endcase
	
	always @ */ 
			