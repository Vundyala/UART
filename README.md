# UART
This project implements a Universal Asynchronous Receiver Transmitter (UART) using Verilog HDL.
It includes a UART transmitter, UART receiver with 16× oversampling, and a baud rate generator.
It supports 8-bit data transmission with odd parity and 2 stop bits.
>> Main features of the project are:
1.Asynchronous serial communication between transmitter and receiver
2.8-bit data frame
3.Odd parity generation and error detection
4.Two stop bits for better synchronization
5.16× oversampling in receiver for better sampling
>> Design Approach of the projrct:
1.Baud rate generator produces baud tick and 16× oversampling tick
2.UART transmitter produces two stop bits after parity bit
3.UART receiver samples each bit at the center using 16× oversampling
4.Parity is verified using odd parity logic
5.Data is accepted by the receiver only if both stop bits are logic high
