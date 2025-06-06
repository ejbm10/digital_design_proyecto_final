import math

def leer_valores_desde_txt(nombre_archivo):
    valores = []

    with open(nombre_archivo, 'r') as archivo:
        lineas = archivo.readlines()

        if len(lineas) % 4 != 0:
            raise ValueError("El archivo no contiene un número de bytes múltiplo de 4")

        for i in range(0, len(lineas), 4):
            grupo = lineas[i:i+4]
            bytes_hex = [int(b.strip(), 16) for b in grupo]
            valor = (
                (bytes_hex[3] << 24) |
                (bytes_hex[2] << 16) |
                (bytes_hex[1] << 8) |
                bytes_hex[0]
            )
            valores.append(valor)

    n = int(math.sqrt(len(valores)))

    if n * n == len(valores):
        # Crear la matriz n x n
        matriz = [valores[i:i + n] for i in range(0, len(valores), n)]
        return matriz
    else:
        print(":c")
        return None


matriz = leer_valores_desde_txt('memory_2000.txt')
if matriz:
    for fila in matriz:
        print(fila)
