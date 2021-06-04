module sw_mux(
		adress,
		in,
		out0,
		out1,
		out2,
		out3,
		out4);
		
		input	[3:0]	adress;
		input	[3:0]	in;
		
		output[3:0]	out0,out1,out2,out3,out4;

		wire	[3:0]	in;
		reg	[3:0]	out0,out1,out2,out3,out4;
		
		always @(adress or in)begin
			case(adress)
				4'b0001	:	out1	<=	in;
				4'b0010	:	out2	<=	in;
				4'b0100	:	out3	<=	in;
				4'b1000	:	out4	<=	in;
				default	:	out0	<=	in;
			endcase
		end
	endmodule
	