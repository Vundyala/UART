`timescale 1ns / 1ps 
module tb_uart_top; 
 
    reg clk; 
    reg reset; 
    reg tx_start; 
    reg [7:0] tx_data; 
    wire tx; 
    wire rx; 
    wire [7:0] rx_data; 
    wire rx_done; 
    uart_top dut ( 
        .clk(clk), 
        .reset(reset), 
        .tx_start(tx_start), 
        .tx_data(tx_data), 
        .rx(rx), 
        .tx(tx), 
        .rx_data(rx_data), 
        .rx_done(rx_done) 
    ); 
    always #10 clk = ~clk;   
    assign rx = tx;           
    initial begin 
        clk = 0; 
        reset = 1; 
        tx_start = 0; 
        #100 reset = 0; 
        #20; 
        tx_data = 8'b11110000; 
        tx_start = 1; 
        wait(dut.tx_inst.tx_busy == 1); 
        tx_start=0; 
        #20 
        reset=0;       
        tx_data = 8'b11011101; 
        tx_start = 1;        
        #40000000; 
        $stop; 
    end 
endmodule