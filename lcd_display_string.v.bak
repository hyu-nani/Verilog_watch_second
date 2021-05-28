module lcd_display_string(
  clk,
  rst,
  index,
  out);
  
  input         clk,rst;
  input   [4:0] index;
  output  [7:0] out;
  
  wire    [4:0] index;
  reg     [7:0] out;
  
  always @(posedge clk or negedge rst)begin
    if(!rst)
      out <=  8'h00;
    else
      case(index)
        00      :   out   <=  8'h32;
        01      :   out   <=  8'h30;
        02      :   out   <=  8'h31;
        03      :   out   <=  8'h37;
        04      :   out   <=  8'h33;
        05      :   out   <=  8'h32;
        06      :   out   <=  8'h39;
        07      :   out   <=  8'h31;
        08      :   out   <=  8'h20;
        09      :   out   <=  8'h20;
        10      :   out   <=  8'h20;
        11      :   out   <=  8'h20;
        12      :   out   <=  8'h20;
        13      :   out   <=  8'h20;
        14      :   out   <=  8'h20;
        15      :   out   <=  8'h20;
        //  welcome to 
        16      :   out   <=  8'h42;
        17      :   out   <=  8'h61;
        18      :   out   <=  8'h65;
        19      :   out   <=  8'h20;
        20      :   out   <=  8'h48;
        21      :   out   <=  8'h79;
        22      :   out   <=  8'h65;
        23      :   out   <=  8'h6F;
        24      :   out   <=  8'h6E;
        25      :   out   <=  8'h20;
        26      :   out   <=  8'h48;
        27      :   out   <=  8'h61;
        28      :   out   <=  8'h6E;
        29      :   out   <=  8'h20;
        30      :   out   <=  8'h20;
        31      :   out   <=  8'h20;
        default :   out   <=  8'h00;
        // verilog world!
      endcase
  end

endmodule
