# UART Communication System Using Verilog HDL
## Overview
   This project implements a UART (Universal Asynchronous Receiver/Transmitter) communication system using Verilog HDL. The design includes a baud-rate              generator, UART transmitter, and a 16× oversampling receiver that detects the start bit, samples the incoming data bits, checks the parity bit, and validates     the stop bit. 
   The transmitter converts 8-bit parallel data into a serial UART frame with odd parity and one stop bit. The complete system is integrated and verified through    simulation using a TX-to-RX loopback configuration.

## Features
  - 9600 baud rate communication
  - 8-bit data transmission
  - Odd parity for error detection
  - 1 stop bit
  - 16× oversampling at the receiver
  - FSM-based UART transmitter and receiver
  - Verification through continuous 2-byte transmission, parity checking, and reset testing.

## Architecture





## Module Description
### 1.`baud_gen`
Description of Baud Rate Generator
The Baud Rate Generator generates baud_tick for transmission and tick_16x for receiver sampling, indicating when the transmitter should send each bit and when the receiver should sample the incoming data. 

tick_16x provides 16 sampling intervals within one bit period for accurate data reception.

### 2.`uart_tx`
Description of the transmitter.
The UART Transmitter takes 8-bit parallel data and converts it into a serial UART frame. 
It adds the start bit, odd parity bit, and one stop bit, and sends the frame bit-by-bit on the tx line using baud_tick. 
The tx_busy signal indicates that the transmitter is currently transmitting a frame.

### 3.`uart_rx_16x`
Description of the receiver.
The UART Receiver receives the incoming serial data on the rx line and uses tick_16x for 16× oversampling.
It detects the start bit, samples and stores the 8 data bits, receives and checks the odd parity bit, and verifies the stop bit.
After successful reception, the received data is provided through rx_data and rx_done indicates that a valid frame has been received.

### 4.`uart_top`
Description of the top-level module.
The top-level module connects the Baud Rate Generator, UART Transmitter, and UART Receiver to form the complete UART system. 
It provides the required clock, reset, data, and control signals between the modules.

### 5.Test Bench
The testbench verifies the complete UART system.
Continuous 2-byte transmission – verifies back-to-back transmission of two data bytes.
Parity verification – checks the odd parity generation and reception.
Reset during communication – verifies the behavior of the UART when reset is asserted between transmissions.
Receiver output verification – checks rx_data and rx_done after successful frame reception.

## Finite State Machine
The UART uses separate Finite State Machines (FSMs) for the transmitter and receiver to control stages of UART communication.

- ### Transmitter FSM
 IDLE: Waits for tx_start. When a new transmission is requested, the UART frame is loaded into the shift register and the transmitter moves to BUSY.
 BUSY: Transmits the frame one bit at a time on the tx line using baud_tick. After all bits are transmitted, it returns to IDLE and clears tx_busy.

- ### Receiver FSM
IDLE: Monitors the rx line and waits for the start bit (rx = 0).

START: Waits for the appropriate sampling point to confirm the start bit and then moves to DATA.

DATA: Samples and stores the 8 data bits using tick_16x. After all 8 bits are received, it moves to PARITY.

PARITY: Samples the parity bit and compares it with the calculated odd parity. If the parity matches, it moves to STOP; otherwise, it returns to IDLE.

STOP: Checks the stop bit. If it is valid (rx = 1), the received data is made available and rx_done is asserted before returning to IDLE.

## Simulation Results
Different test cases were performed to verify data transmission, parity checking, continuous byte transmission, and reset behavior.

### 1. Single-Byte Transmission
An 8-bit data value is provided to the transmitter through tx_data. The transmitter generates the UART frame and sends it serially through tx. The same signal is connected to the receiver, which reconstructs the data and provides it through rx_data.

### 2. Continuous 2-Byte Transmission
Two data bytes are transmitted consecutively to verify that the transmitter correctly completes one frame before starting the next transmission. The receiver successfully reconstructs the transmitted bytes.

### 3. Parity Verification
The transmitter generates an odd parity bit for each data byte. The receiver calculates the expected parity and compares it with the received parity bit to verify the integrity of the data.

### 4. Reset During Communication
Reset is asserted between two transmissions to verify that the transmitter and receiver return to their initial states. After reset is released, a new transmission is started and the UART resumes normal operation.

## Detailed Design
The complete **design specifications, transmitter and receiver FSM diagrams, and detailed test-case explanations** are provided in the project report.

[View the Complete Project Report](Report)

## Authors
  
  Bhavitha
  Joshnavi
  Tejasri 
  Electronics and communication engineering department
  MNNIT Allahabad
  
