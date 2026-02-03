module uart_rx_16x( 
    input  wire clk, 
    input  wire reset, 
    input  wire tick_16x, 
    input  wire rx, 
    output reg  [7:0] rx_data, 
    output reg  rx_done, 
    output reg parity_rx 
); 
    parameter IDLE=3'b000, START=3'b001, DATA=3'b010, 
              PARITY=3'b011, STOP=3'b100;  
    reg [2:0] state; 
    reg [3:0] sample_cnt; 
    reg [2:0] bit_index; 
    reg [7:0] data_reg; 
    reg rx_parity_bit; 
    always @(posedge clk or posedge reset) begin 
        if (reset) begin 
            state <= IDLE; 
            sample_cnt <= 0; 
            bit_index <= 0; 
             data_reg<= 0; 
            rx_data <= 0; 
            rx_done <= 0; 
            parity_rx <= 0; 
            rx_parity_bit <= 0; 
        end  
        else if (tick_16x) begin 
            rx_done <= 0; 
 
            case(state) 
 
            IDLE: begin 
                if (rx == 0) begin 
                    state <= START; 
                    sample_cnt <= 0; 
                end 
            end 
 
            START: begin 
                if (sample_cnt == 15) begin 
                    state <= DATA; 
                    bit_index <= 0; 
                    sample_cnt <= 0; 
                end else 
                    sample_cnt <= sample_cnt + 1; 
            end 
 
            DATA: begin 
                if (sample_cnt == 15) begin 
                    data_reg[bit_index] <= rx; 
                    sample_cnt <= 0; 
                    if (bit_index == 7) 
                        state <= PARITY; 
                    else 
                        bit_index <= bit_index + 1; 
                end else 
                    sample_cnt <= sample_cnt + 1; 
            end 
 
            PARITY: begin 
                if (sample_cnt == 15) begin 
                    rx_parity_bit <= rx; 
                    parity_rx <= ~(^data_reg); 
                    if (rx_parity_bit==parity_rx) 
                        state <= STOP; 
                    else 
                        state <= IDLE; 
                    sample_cnt <= 0; 
                end else 
                    sample_cnt <= sample_cnt + 1; 
            end 
 
            STOP: begin 
                if (sample_cnt == 15) begin 
                    if (rx == 1) begin 
                        rx_data <= data_reg; 
                        rx_done <= 1; 
                    end 
                    state <= IDLE; 
                    sample_cnt <= 0; 
                end else 
                    sample_cnt <= sample_cnt + 1; 
            end 
 
            endcase 
        end 
    end 
endmodule 
