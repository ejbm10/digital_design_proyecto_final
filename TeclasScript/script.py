import serial
from pynput import keyboard


ser = serial.Serial('COM11', 9600)

def on_press(key):
    try:
        if key == keyboard.Key.up:
            print("Flecha arriba presionada — Enviando 'U'")
            ser.write(b'U')
        elif key == keyboard.Key.down:
            print("Flecha abajo presionada — Enviando 'D'")
            ser.write(b'D')
        elif key == keyboard.Key.left:
            print("Flecha izquierda presionada — Enviando 'L'")
            ser.write(b'L')
        elif key == keyboard.Key.right:
            print("➡️  Flecha derecha presionada — Enviando 'R'")
            ser.write(b'R')
        else:
            print(f"Otra tecla presionada: {key}")
    except Exception as e:
        print(f"Error al enviar: {e}")

with keyboard.Listener(on_press=on_press) as listener:
    print("Escuchando teclas de flechas... (presiona ESC para salir)")
    listener.join()
