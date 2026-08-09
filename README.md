# UART Communication System Using Verilog HDL
## Overview
This project implements a UART (Universal Asynchronous Receiver/Transmitter) communication system using Verilog HDL. The design includes a baud-rate generator, UART transmitter, and a 16× oversampling receiver that detects the start bit, samples the incoming data bits, checks the parity bit, and validates the stop bit. The transmitter converts 8-bit parallel data into a serial UART frame with odd parity and one stop bit. The complete system is integrated and verified through simulation using a TX-to-RX loopback configuration.

## Features
9600 baud rate communication
8-bit data transmission
Odd parity for error detection
1 stop bit
16× oversampling at the receiver
FSM-based UART transmitter and receiver
Verification through continuous 2-byte transmission, parity checking, and reset testing

  AUTHOR
  Bhavitha
  Joshnavi
  Tejasri 
  Electronics and communication engineering department
  MNNIT Allahabad
  

                                                                 

