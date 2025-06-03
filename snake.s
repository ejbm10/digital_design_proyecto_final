.global _start          @ Punto de entrada del programa (como main en C)

_start:
    BL init_game        @ Llama a función que inicializa posición de cabeza y dirección

    LDR R6, =KEYS       @ R6 apunta al arreglo de teclas simuladas
    MOV R7, #0          @ R7 será el índice dentro del arreglo
    MOV R8, #5          @ R8 es la cantidad total de teclas a simular

loop:
    CMP R7, R8          @ ¿Ya se procesaron todas las teclas?
    BEQ end             @ Si sí, terminar el programa

    LDR R0, [R6, R7, LSL #2]  @ Lee la tecla simulada desde KEYS[R7]
    LDR R9, =0x1000           @ Dirección del puerto simulado de teclado
    STR R0, [R9]              @ Simula entrada: escribe tecla en 0x1000

    BL read_keyboard     @ Procesa tecla: actualiza dirección de movimiento
    BL move_head         @ Mueve la cabeza una celda según dirección actual

    ADD R7, R7, #1       @ Avanza al siguiente código de tecla
    B loop               @ Repite el bucle principal

end:
    B end                @ Fin del programa (bucle infinito)


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ INICIALIZACIÓN
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
init_game:
    LDR R0, =0x4010      @ Dirección donde se guarda la posición de la cabeza
    LDR R1, =START_POS   @ Dirección del valor de inicio
    LDR R2, [R1]         @ Carga la posición inicial (fila 2, col 3 = 0x00020003)
    STR R2, [R0]         @ Guarda esa posición en RAM

    LDR R0, =0x3000      @ Dirección para guardar dirección de movimiento
    MOV R1, #3           @ Dirección = 3 (derecha)
    STR R1, [R0]         @ Guarda dirección inicial

    BX LR                @ Retorna a quien llamó (gracias a BL)

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ CAMBIO DE DIRECCIÓN SEGÚN TECLA
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
read_keyboard:
    PUSH {R4, R5, R6}    @ Guarda los registros que se van a usar
    LDR R9, =0x1000      @ Dirección del puerto simulado del teclado
    LDR R0, [R9]         @ R0 = tecla actual (simulada)
	
    LDR R1, =UP_ARROW    @ Cargar dirección de constante UP
    LDR R1, [R1]         @ R1 = valor de flecha arriba (0xE048)
    LDR R2, =DOWN_ARROW
    LDR R2, [R2]         @ R2 = flecha abajo
    LDR R3, =LEFT_ARROW
    LDR R3, [R3]         @ R3 = flecha izquierda
    LDR R4, =RIGHT_ARROW
    LDR R4, [R4]         @ R4 = flecha derecha

    CMP R0, R1
    BEQ set_up           @ Si coincide con UP
    CMP R0, R2
    BEQ set_down         @ DOWN
    CMP R0, R3
    BEQ set_left         @ LEFT
    CMP R0, R4
    BEQ set_right        @ RIGHT
	
    B end_read           @ Si no coincide con ninguna, salir


set_up:
    LDR R5, =0x3000
    MOV R6, #0           @ Dirección 0 = arriba
    STR R6, [R5]
    B end_read

set_down:
    LDR R5, =0x3000
    MOV R6, #1           @ Dirección 1 = abajo
    STR R6, [R5]
    B end_read


set_left:
    LDR R5, =0x3000
    MOV R6, #2           @ Dirección 2 = izquierda
    STR R6, [R5]
    B end_read


set_right:
    LDR R5, =0x3000
    MOV R6, #3           @ Dirección 3 = derecha
    STR R6, [R5]

end_read:
    POP {R4, R5, R6}     @ Restaura registros a su valor anterior
    BX LR                @ Retorna al que llamó

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ MOVER LA CABEZA SEGÚN DIRECCIÓN
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
move_head:
    PUSH {R4, R5, R10, R11}   @ Guarda registros que se usarán

    LDR R0, =0x3000
    LDR R1, [R0]              @ R1 = dirección actual de movimiento

    LDR R2, =0x4010
    LDR R3, [R2]              @ R3 = posición actual (fila:columna)

    LSR R4, R3, #16           @ Fila = bits altos (fila = R3 >> 16)
    LDR R11, =0xFFFF
    AND R5, R3, R11           @ Columna = bits bajos (columna = R3 & 0xFFFF)


    CMP R1, #0
    BEQ mv_up
    CMP R1, #1
    BEQ mv_down
    CMP R1, #2
    BEQ mv_left
    CMP R1, #3
    BEQ mv_right
    B mv_store

mv_up:    SUB R4, R4, #1      @ Fila -= 1 (arriba)
          B mv_store
mv_down:  ADD R4, R4, #1      @ Fila += 1 (abajo)
          B mv_store
mv_left:  SUB R5, R5, #1      @ Col -= 1 (izquierda)
          B mv_store
mv_right: ADD R5, R5, #1      @ Col += 1 (derecha)


mv_store:
    LSL R4, R4, #16           @ Fila << 16 (mover a bits altos)
    ORR R3, R4, R5            @ Combinar con columna (bits bajos)
    STR R3, [R2]              @ Guardar nueva posición en 0x4010

    POP {R4, R5, R10, R11}    @ Restaura registros
    BX LR                     @ Retorna al caller


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ DATOS INICIALES
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.data

UP_ARROW:   .word 0xE048     @ Código de flecha arriba (scancode PS/2)
DOWN_ARROW: .word 0xE050     @ Flecha abajo
LEFT_ARROW: .word 0xE04B     @ Flecha izquierda
RIGHT_ARROW:.word 0xE04D     @ Flecha derecha


KEYS:                       @ Arreglo de teclas simuladas
    .word 0xE04D            @ Derecha
    .word 0xE048            @ Arriba
    .word 0xE04B            @ Izquierda
    .word 0xE050            @ Abajo
    .word 0x1234            @ Tecla inválida


START_POS: .word 0x00020003 @ Posición inicial (fila 2, columna 3)

