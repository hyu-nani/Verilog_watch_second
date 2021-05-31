module	fsm ( 
					clk,
					rst,
					dip_sw,
					en_state,
					cursor);
					
	input				clk, rst;
	input		[4:0]	dip_sw;
	output			en_state;
	output			cursor;
	
	parameter		WATCH		 = 2'd0;
						SET_WATCH = 2'd0;
						
	reg		[1:0] state, next;
	
	always @ (posedge clk or negedge rst) begin
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
	
	always @ 
			