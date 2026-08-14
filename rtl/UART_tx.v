//--------------DESCRIPTION-----------------
// Loads the data and parity into the shift register.
// Sends one bit on every baud_tick.
// stops when the complete frame is transmitted.
// -----------------------------------
module uart_tx( 
    input  wire clk, 
    input  wire reset, 
    input  wire baud_tick, 
    input  wire tx_start, 
    input  wire [7:0] tx_data, 
    output reg  tx, 
    output reg  tx_busy, 
    output reg  parity_tx 
); 
    reg [3:0] bit_index; 
    reg [10:0] shift_reg; 
    always @(posedge clk or posedge reset)
          begin 
          if (reset) 
              begin 
              tx <= 1'b1; 
              tx_busy <= 0; 
              bit_index <= 0; 
              shift_reg <= 11'b11111111111;                                   //Frame shift register
              parity_tx <= 0; 
              end 
           else
               begin 
               if (tx_start && !tx_busy) 
                   begin 
                   parity_tx <=~(^tx_data);                                   //odd parity 
                   shift_reg <= {1'b1, ~(^tx_data), tx_data, 1'b0}; 
                   tx_busy <= 1; 
                   bit_index <= 0; 
                   end 
               else 
                   begin
                   if (baud_tick && tx_busy) 
                       begin 
                       tx <= shift_reg[0]; 
                       shift_reg <= {1'b1, shift_reg[10:1]};              //Load UART frame into shift register
                       bit_index <= bit_index + 1;                        //count of bits transmitted
                       if (bit_index == 10)
                           tx_busy <= 0; 
                       end 
                  end
               end
          end
endmodule 
