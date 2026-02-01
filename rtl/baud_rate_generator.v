`timescale 1ns / 1ps 
module baud_gen #( 
    parameter CLK_FREQ  = 50000000,    
    parameter BAUD_RATE = 9600 
)( 
    input  wire clk, 
    input  wire reset, 
    output reg  baud_tick,      
    output reg  tick_16     
); 
    localparam integer clk_cycles_tx= CLK_FREQ / BAUD_RATE; 
    localparam integer clk_cycles_rx = CLK_FREQ / (BAUD_RATE * 16); 
 
    reg [$clog2(clk_cycles_tx)-1:0] tx_cnt; 
    reg [$clog2(clk_cycles_rx)-1:0] sample_cnt; 
 
    always @(posedge clk or posedge reset) begin 
        if (reset) begin 
            tx_cnt <= 0; 
            sample_cnt <= 0; 
            baud_tick <= 0; 
            tick_16 <= 0; 
        end else begin 
            baud_tick   <= 0; 
            tick_16 <= 0; 
 
            
            if (tx_cnt == clk_cycles_tx-1) begin 
                tx_cnt    <= 0; 
                baud_tick <= 1;    
            end else begin 
                tx_cnt <= tx_cnt + 1; 
            end 
 
            if (sample_cnt ==clk_cycles_rx-1) begin 
                sample_cnt      <= 0; 
                tick_16 <= 1;  
            end else begin 
                sample_cnt <= sample_cnt + 1; 
            end 
        end 
    end 
endmodule