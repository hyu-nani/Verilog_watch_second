module lcd_display_string(
  clk,
  rst,
  tenH,
  oneH,
  tenM,
  oneM,
  tenS,
  oneS,
  index,
  out);
  
  input         clk,rst;
  input	 [3:0] tenH,oneH,tenM,oneM,tenS,oneS;
  input   [4:0] index;
  output  [7:0] out;
  
  wire	 [3:0] tenH,oneH,tenM,oneM,tenS,oneS;
  wire    [4:0] index;
  reg     [7:0] out;
  
  always @(posedge clk or negedge rst)begin
    if(!rst)
      out <=  8'h00;
    else
      case(index)
        00      :   out   <=  8'h20;
        01      :   out   <=  8'h20;
        02      :   out   <=  8'h20;
        03      :   out   <=  8'h20;
        04      :   out   <=  8'h20;
        05      :   out   <=  8'h20;
        06      :   out   <=  8'h20;
        07      :   out   <=  8'h20;
        08      :   out   <=  8'h20;
        09      :   out   <=  8'h20;
        10      :   out   <=  8'h20;
        11      :   out   <=  8'h20;
        12      :   out   <=  8'h20;
        13      :   out   <=  8'h20;
        14      :   out   <=  8'h20;
        15      :   out   <=  8'h20;
        //  welcome to 
        16      :   out   <=  8'h30 + tenH;
        17      :   out   <=  8'h30 + oneH;
        18      :   out   <=  8'h3A;
        19      :   out   <=  8'h30	+ tenM;
        20      :   out   <=  8'h30 + oneM;
        21      :   out   <=  8'h3A;
        22      :   out   <=  8'h30 + tenS;
        23      :   out   <=  8'h30 + oneS;
        24      :   out   <=  8'h20;
        25      :   out   <=  8'h20;
        26      :   out   <=  8'h20;
        27      :   out   <=  8'h20;
        28      :   out   <=  8'h20;
        29      :   out   <=  8'h20;
        30      :   out   <=  8'h20;
        31      :   out   <=  8'h20;
        default :   out   <=  8'h00;
        // verilog world!
      endcase
  end

endmodule
