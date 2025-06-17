from machine import UART, Pin
import sys

# UART hacia la FPGA
uart1 = UART(1, baudrate=9600, tx=Pin(4), rx=Pin(5))  # TX=GP4, RX=GP5
led = Pin(25, Pin.OUT)
print("Pico listo para recibir desde laptop y enviar a FPGA")

while True:
    try:
        key = sys.stdin.read(1)  # Bloquea hasta que se presiona una tecla
        if key:
            print("Recibido:", key)
            uart1.write(key.encode())  # Enviar a la FPGA
    except KeyboardInterrupt:
        break
