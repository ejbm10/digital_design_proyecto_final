def convertir_instrucciones(path_entrada, path_salida):
    with open(path_entrada, "r") as entrada:
        lineas = entrada.readlines()

    salida = []
    for i, linea in enumerate(lineas):
        hexstr = linea.strip().lower()
        if len(hexstr) == 8 and all(c in "0123456789abcdef" for c in hexstr):
            salida.append(f"instruction_set[{i}] = 32'h{hexstr.upper()};")

    with open(path_salida, "w") as salida_txt:
        salida_txt.write("\n".join(salida))

    print(f"Archivo guardado como: {path_salida}")

convertir_instrucciones("memory_0.txt", "rom_format_output.txt")