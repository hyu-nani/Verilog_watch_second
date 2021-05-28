module Verilog_watch_second(
    clk,
    rst,
    lcd_rs,
    lcd_rw,
    lcd_e,
    lcd_data);
    
    input         clk,rst;
    output        lcd_rs,lcd_rw,lcd_e;
    output  [7:0] lcd_data;
    
    wire    [4:0] index_char;
    wire    [7:0] data_char;
    wire          en_clk;
    
	clock						TIME(
		.clk			(clk),
		.rst			(rst),
		.year			(year),
		.month		(month),
		.day			(day),
		.hour			(hour),
		.minute		(minute),
		.second		(second));
	
	bin2BCD					CON0(
		.bin			(hour),
		.tens			(tenH),
		.ones			(oneH));
		
	bin2BCD					CON1(
		.bin			(minute),
		.tens			(tenM),
		.ones			(oneM));
	
	bin2BCD					CON2(
		.bin			(second),
		.tens			(tenS),
		.ones			(oneS));
		
   en_clk_lcd        	LCLK(
      .clk    		(clk),
      .rst    		(rst),
      .en_clk 		(en_clk));
      
   lcd_display_string 	STR(
      .clk    		(clk),
      .rst    		(rst),
		.tenH			(tenH),
		.oneH			(oneH),
		.tenM			(tenM),
		.oneM			(oneM),
		.tenS			(tenS),
		.oneS			(oneS),
      .index  		(index_char),
      .out    		(data_char));
      
   lcd_driver         	DRV(
      .clk        (clk),
      .rst        (rst),
      .en_clk     (en_clk),
      .data_char  (data_char),
      .index_char (index_char),
      .lcd_rs     (lcd_rs),
      .lcd_rw     (lcd_rw),
      .lcd_e      (lcd_e),
      .lcd_data   (lcd_data));
      
      
endmodule
  
