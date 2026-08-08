`timescale 1ns / 1ps 
module baud_gen #( 
    parameter CLK_FREQ  = 5,00,00,000,    
    parameter BAUD_RATE = 9600 )
    ( 
    input  wire clk, 
    input  wire reset, 
    output reg  baud_tick,      
    output reg  tick_16x  );
        
    localparam integer clk_cycles_tx= CLK_FREQ / BAUD_RATE; 
    localparam integer clk_cycles_rx = CLK_FREQ / (BAUD_RATE * 16); 
    reg [$clog2(clk_cycles_tx)-1:0] tx_cnt;                             //Count of clock cycles        
    reg [$clog2(clk_cycles_rx)-1:0] sample_cnt;                         //Count of samples
    always @(posedge clk or posedge reset) 
        begin 
        if (reset) 
            begin 
            tx_cnt <= 0; 
            sample_cnt <= 0; 
            baud_tick <= 0; 
            tick_16x <= 0; 
            end
        else
            begin                                                         
            baud_tick   <= 0; 
            tick_16x <= 0;           
            if (tx_cnt == clk_cycles_tx-1)
                begin 
                tx_cnt    <= 0; 
                baud_tick <= 1;                                           //Indicates the time to process the next UART bit   
                end 
            else
                begin
                tx_cnt <= tx_cnt + 1; 
                    if (sample_cnt ==clk_cycles_rx-1) 
                        begin 
                        sample_cnt <= 0;                                     
                        tick_16x <= 1;                                       //Indicates the time to sample UART bit
                        end 
                    else
                        sample_cnt <= sample_cnt + 1;
                end 
            end
        end
endmodule
