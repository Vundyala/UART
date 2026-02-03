#UART
UART Serial data transmission

PROJECT OVERVIEW
The project implements UART(universal transmitter  and receiver) .it enables serail communication.It includes baud generator ,transmitter ,receiver and topmodule to integrate these 3 modules.3 test cses are used to verify correct data transfer such as parity,2byte transmission and reset application in between.

FEATURES
8 bit data transmission
stop bits(2 bits)
odd parity
reset application in between

STRUCTURE
UART_Project/
│
├── rtl/
│   ├── baud_gen.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_top.v
├── tb/
│   └── uart_tb.v
├── waveforms/
│   └── uart_waveform.png
├── report/
   └── UART_Report.pdf
   
UART FRAME FORMAT
1 startbit,8 data bits , 1 parity bit, 2 stopbits

DESIGN
Design includes 3 main modules,their functions are explained below
1.BAUD RATE GENERATOR
It provides timing signal .Divides the system clock to generate a tick based on selected baud rate.It conrols the timing of data transmission and reception.usually 9600 baudrate and 50MHZ frequency is used for fast and stable transmission.
2.UART TRANSMITTER
It converts parallel data to serial.
when transmit signal and transmitter is not busy ,transmission starts.
It sends start bit(0),data(0-8bits),parity(1/0),stop bit(1).on each baud tick ,a bit is transmitted.
3.UART RECEIVER
It is at idle start at first.When it detects start bit ,starts recieving data and does oversampling(16 samples) for accurate bit.
After recieving data,calculates the parity(odd) and compare with the recieved parity bit,if they are equal it moves to stop state ,if not,moves to idle state because error is detected.

TESTBENCH
It is used to verify the correct operation of UART and results are displayed in waveforms
1.Testbench for 2 byte transmission and reception 
  Provides clock and reset.
  provides 2nd data when 1st data is received by signal rx_done
2.Reset in between
  Applied reset in between 2 byte transmission
  receiver receives data(00H) because of reset
  
  APPLICATIONS
  serial communication between microcontroller and pC
  display modules often use for received commands

  AUTHOR
  Bhavitha
  Joshnavi
  Tejasri 
  Electronics and communication engineering department
  MNNIT Allahabad
  

                                                                 

