.global _start

_start:
    LDR R9, =0x1000        @ Dirección del teclado simulado
	
    LDR R0, =0x2000        @ Dirección de "Matriz"
	MOV R1, #100           @ Celdas (10x10)
	MOV R2, #0             @ Valor cero
	
	BL init_game
	
	B end

	

loop:
    CMP R11, R10             @ Revisa si ya se realizaron todas las iteraciones
    BEQ end                @ Si sí, terminar

    LDR R0, [R6, R11, LSL #2]   @ Leer tecla simulada
    STR R0, [R9]               @ Simular que "teclado" puso la tecla en 0x1000

    LDR R4, [R9]               @ Leer valor de la tecla desde 0x1000
    LDR R5, [R1]               @ Leer valor actual del contador

    CMP R4, R2                 @ ¿Flecha arriba?

    CMP R4, R3                 @ ¿Flecha abajo?


    B next                     @ Si es otra tecla, no hacer nada

init_game:
    STRB R2, [R0], #1
    SUBS R1, R1, #1
	BNE init_game

	LDR R0, =0x2000        @ Dirección de "Matriz"

    @ --- Valores 4 ---
    MOV R3, #4
    @ Fila 2: [2][1], [2][2], [2][3], [2][6], [2][7]
    STRB R3, [R0, #(2*10 + 1)]
    STRB R3, [R0, #(2*10 + 2)]
    STRB R3, [R0, #(2*10 + 3)]
    STRB R3, [R0, #(2*10 + 6)]
    STRB R3, [R0, #(2*10 + 7)]
    @ Fila 3: [3][2], [3][6], [3][7], [3][8]
    STRB R3, [R0, #(3*10 + 2)]
    STRB R3, [R0, #(3*10 + 6)]
    STRB R3, [R0, #(3*10 + 7)]
    STRB R3, [R0, #(3*10 + 8)]
    @ Fila 4: [4][2], [4][6], [4][7], [4][8]
    STRB R3, [R0, #(4*10 + 2)]
    STRB R3, [R0, #(4*10 + 6)]
    STRB R3, [R0, #(4*10 + 7)]
    STRB R3, [R0, #(4*10 + 8)]
    @ Fila 5: [5][2], [5][6], [5][7]
    STRB R3, [R0, #(5*10 + 2)]
    STRB R3, [R0, #(5*10 + 6)]
    STRB R3, [R0, #(5*10 + 7)]

    @ --- Cabeza de la serpiente (valor 1) ---
    MOV R3, #1
    STRB R3, [R0, #(4*10 + 5)]   @ matriz[4][5] = 1

    @ --- Cuerpo de la serpiente (valor 2) ---
    MOV R3, #2
    STRB R3, [R0, #(5*10 + 5)]   @ matriz[5][5] = 2

    BX LR

end:
    B end                      @ Fin: bucle infinito donde se queda y no hace nada

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