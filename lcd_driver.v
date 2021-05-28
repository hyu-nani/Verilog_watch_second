module lcd_driver(
  clk,
  rst,
  en_clk,
  data_char,
  index_char,
  lcd_rs,
  lcd_rw,
  lcd_e,
  lcd_data);
  
  input         clk,rst,en_clk;
  input   [7:0] data_char;
  output        lcd_rs,lcd_rw,lcd_e;
  output	 [4:0] index_char;
  output  [7:0] lcd_data;
  
  parameter     IDLE        = 4'h0;
  parameter     FUNC_SET    = 4'h1;
  parameter     DISP_OFF    = 4'h2;
  parameter     DISP_CLEAR  = 4'h3;
  parameter     DISP_ON     = 4'h4;
  parameter     MODE_SET    = 4'h5;
  parameter     PRINT_STRING= 4'h6;
  parameter     LINE2       = 4'h7;
  parameter     RETURN_HOME = 4'h8;
  
  parameter     T_PW        = 2499999;
  
  wire  [7:0] data_char;
  reg   [4:0] index_char;
  reg         lcd_rs,lcd_rw,lcd_e;
  wire  [7:0] lcd_data;
  reg   [3:0] state;
  reg	  [3:0] next_state;
  reg   [7:0] data_bus;
  reg   [21:0]cnt_init;
  reg         dly_en_clk;
  reg   [9:0] cnt_en_clk;
  
  assign  lcd_data  = (lcd_rw ? 8'b0000_0000 : data_bus);
  
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      cnt_init  <=  0;
    else  begin 
      if(cnt_init >=  T_PW)
        cnt_init  <=  T_PW;
      else
        cnt_init  <=  cnt_init + 1'b1;
    end
  end
  
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      state <=  IDLE;
    else if(en_clk)
      state <=  next_state;
    else  
      state <=  state;
  end
  
  always @ (*)begin
    case(state)
      IDLE        : if(cnt_init >= T_PW)
                      next_state  <=  FUNC_SET;
                    else
                      next_state  <=  IDLE;
      FUNC_SET    :   next_state  <=  DISP_OFF;
      DISP_OFF    :   next_state  <=  DISP_CLEAR;
      DISP_CLEAR  :   next_state  <=  DISP_ON;
      DISP_ON     :   next_state  <=  MODE_SET;
      MODE_SET    :   next_state  <=  PRINT_STRING;
      PRINT_STRING: if		(index_char == 15)
                      next_state  <=  LINE2;
                    else if(index_char == 31)
                      next_state  <=  RETURN_HOME;
                    else
                      next_state  <=  PRINT_STRING;
      LINE2       :   next_state  <=  PRINT_STRING;
      RETURN_HOME :   next_state  <=  PRINT_STRING;
      default     :   next_state  <=  IDLE;
    endcase
  end
  
  //lcd_e 신호의 펄스폭 제어를 위한 카운터
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      cnt_en_clk  <=  0;
    else if(en_clk)
      cnt_en_clk  <=  0;
    else if(&cnt_en_clk)
      cnt_en_clk  <=  cnt_en_clk;
    else
      cnt_en_clk  <=  cnt_en_clk + 1'b1;
  end
  
  //문자 위치지정
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      index_char <= 1'b0;
    else begin
      if(state == PRINT_STRING && en_clk == 1)begin
        if(index_char < 31)
          index_char  <=  index_char + 1'b1;
        else
          index_char  <=  0;
      end
      else
        index_char  <=  index_char;
    end
  end
  
  //en_clk 에 따라 state -> next_state 로 변화하는 상태와 동기를 위한 지연 카운터
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      dly_en_clk  <=  0;
    else
      dly_en_clk  <=  en_clk;
  end
  
  //명령/문자 데이터를 출력을 위한 enable 펄스 신호 생성
  always @ (posedge clk or negedge rst)begin
    if(!rst)
      lcd_e <=  0;
    else if(state == IDLE)
      lcd_e <=  0;
    else
      if(dly_en_clk)
        lcd_e <=  1;
      else if(&cnt_en_clk)
        lcd_e <=  0;
      else
        lcd_e <=  lcd_e;
  end
  
  always @ (posedge clk or negedge rst)begin
    if(!rst)begin
      lcd_rs  <=  1'b0;
      lcd_rw  <=  1'b0;
      data_bus<=  8'h00;
    end
    else begin
      case(state)
        IDLE      : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h01;
        end
        FUNC_SET  : begin 
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h38;
        end
        DISP_OFF  : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h08;
        end
        DISP_CLEAR: begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h01;
        end
        DISP_ON   : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h0C;
          //0C,0E
        end
        MODE_SET  : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h06;
        end
        PRINT_STRING: begin
          lcd_rs  <=  1'b1;
          lcd_rw  <=  1'b0;
          data_bus<=  data_char;
        end
        LINE2     : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'hC0;
        end
        RETURN_HOME:  begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h80;
        end
        default   : begin
          lcd_rs  <=  1'b0;
          lcd_rw  <=  1'b0;
          data_bus<=  8'h00;
        end
      endcase
    end
  end
  

  reg [18*8-1:0]  STATE;
  
  always @ (*)begin
    case(state)
      IDLE        : STATE <= "IDLE";
      FUNC_SET    : STATE <= "FUNC_SET";
      DISP_OFF    : STATE <= "DISP_OFF";
      DISP_CLEAR  : STATE <= "DISP_CLEAR";
      DISP_ON     : STATE <= "DISP_ON";
      MODE_SET    : STATE <= "MODE_SET";
      PRINT_STRING: STATE <= "PRINT_STRING";
      LINE2       : STATE <= "LINE2";
      RETURN_HOME : STATE <= "RETURN_HOME";
      default     : STATE <= "ERROR";
    endcase
  end

endmodule
