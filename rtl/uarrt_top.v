module uart_top( 
    input  wire clk, 
    input  wire reset, 
    input  wire tx_start, 
    input  wire [7:0] tx_data, 
    output wire tx_busy, 
    input  wire rx,               
    output wire tx, 
    output wire [7:0] rx_data, 
    output wire rx_done 
); 
    wire parity_tx; 
    wire parity_rx; 
    wire baud_tick; 
    wire tick_16x;  
    reg [7:0] received_byte;    
    baud_gen bg ( 
        .clk(clk), 
        .reset(reset), 
        .baud_tick(baud_tick), 
        .tick_16(tick_16) 
    ); 
   uart_tx tx_inst ( 
        .clk(clk), 
        .reset(reset), 
        .baud_tick(baud_tick), 
        .tx_start(tx_start), 
        .tx_data(tx_data), 
        .tx(tx), 
        .tx_busy(tx_busy), 
        .parity_tx(parity_tx) 
    ); 
    uart_rx_16x rx_inst ( 
        .clk(clk), 
        .reset(reset), 
        .tick_16x(tick_16x), 
        .rx(rx), 
        .rx_data(rx_data), 
        .rx_done(rx_done), 
        .parity_rx(parity_rx) 
    ); 
 
endmodule
