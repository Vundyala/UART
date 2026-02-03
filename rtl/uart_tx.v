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
    reg [11:0] shift_reg; 
    always @(posedge clk or posedge reset) begin 
        if (reset) begin 
            tx <= 1'b1; 
            tx_busy <= 0; 
            bit_index <= 0; 
            shift_reg <= 12'b11111111111; 
            parity_tx <= 0; 
        end else begin 
            if (tx_start && !tx_busy) begin 
                parity_tx <=~(^tx_data); 
                shift_reg <= {2'b11, ~(^tx_data), tx_data, 1'b0}; 
                tx_busy <= 1; 
                bit_index <= 0; 
                tx<=1'b0; 
            end 
            else if (baud_tick && tx_busy) begin 
                tx <= shift_reg[0]; 
                shift_reg <= {2'b11, shift_reg[10:1]}; 
                bit_index <= bit_index + 1; 
 
                if (bit_index == 11) begin 
                    tx_busy <= 0; 
                end 
            end 
        end 
    end 
endmodule 
