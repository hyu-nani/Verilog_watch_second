module data_demux(
		adress,
		in0,
		in1,
		in2,
		in3,
		in4,
		out);
		
		input	[3:0]	adress;
		input	[7:0]	in0,in1,in2,in3,in4;
		
		output[7:0]	out;
		
		wire	[7:0]	in0,in1,in2,in3,in4;
		reg	[7:0]	out;
		
		always @(adress or in0 or in1 or in2 or in3 or in4)begin
			case(adress)
				4'b0001	:	out	<=	in1;
				4'b0010	:	out	<=	in2;
				4'b0100	:	out	<=	in3;
				4'b1000	:	out	<=	in4;
				default	:	out	<=	in0;
			endcase
		end
		
endmodule
