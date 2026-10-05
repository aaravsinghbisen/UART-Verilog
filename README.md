# UART Verilog RTL

A basic 8N1 UART transmitter and receiver implemented in Verilog RTL and verified through simulation using Icarus Verilog and GTKWave.

## Overview

This project implements a UART communication interface consisting of:
- UART Transmitter (TX)
- UART Receiver (RX)
- TX baud-rate generator
- RX baud-rate generator
- Start-bit detection and validation
- Stop-bit validation
- LSB-first data transmission
- Verilog testbenches
- VCD waveform generation
- GTKWave waveform verification

The design uses a single 100 MHz system clock and generates timing enables for approximately 115200 baud operation.


## UART Configuration

| Parameter    | Value        |
|--------------|--------------|
| System Clock | 100 MHz      |
| Baud Rate    | ~115200 baud |
| Data Bits    | 8            |
| Parity       | None         |
| Stop Bits    | 1            |
| Frame Format | 8N1          |
| Data Order   | LSB First    |

### What is 8N1?

8N1 means:

- **8** → 8 data bits
- **N** → No parity bit
- **1** → 1 stop bit

A UART frame is therefore:


Idle | Start | D0 D1 D2 D3 D4 D5 D6 D7 | Stop
  1     0       <---- 8 data bits ---->    1
