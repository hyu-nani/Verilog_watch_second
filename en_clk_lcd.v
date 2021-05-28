module en_clk_lcd(
  clk,
  rst,
  en_clk);
  
  input       clk,rst;
  output      en_clk;
  
  reg   [16:0]  cnt_en;
  reg           en_clk;
  
  always @(posedge clk or negedge rst)begin
    if(!rst)begin
      cnt_en  <=  0;
      en_clk  <=  0;
      end
    else begin  
      if(cnt_en == 99999)begin //20ns * 100000 = 2msec
        cnt_en  <=  0;
        en_clk  <=  1'b1;
        end
      else begin
        cnt_en  <=  cnt_en + 1'b1;
        en_clk  <=  0;
        end
    end
  end

endmodule
