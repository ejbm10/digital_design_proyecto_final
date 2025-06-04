.global _start

_start:
    LDR R9, =0x1000            @ Dirección del teclado simulado
	
    LDR R0, =0x2000            @ Dirección de "Matriz"
    MOV R1, #100               @ 100 celdas
    MOV R2, #0                 @ Valor cero (para inicializar)

    BL init_game

    B end

loop:
    CMP R11, R10
    BEQ end

    LDR R0, [R6, R11, LSL #2]   @ Leer tecla simulada (word array)
    STR R0, [R9]                @ Simular entrada de teclado en 0x1000

    LDR R4, [R9]                @ Leer valor desde teclado
    LDR R5, [R1]                @ Leer valor actual del contador

    CMP R4, R2                  @ Comparar con alguna tecla
    CMP R4, R3                  @ Otra comparación

init_game:
    @ Inicializar matriz a 0 (palabras de 32 bits)
    MOV R12, R1                 @ R12 = contador (100)
    LDR R0, =0x2000             @ R0 apunta a matriz
fill_loop:
    STR R2, [R0], #4            @ Escribir palabra (4 bytes) y avanzar
    SUBS R12, R12, #1
    BNE fill_loop

    @ Puntero a matriz
    LDR R0, =0x2000

    @ Valor 4: obstáculos
    MOV R3, #4
    STR R3, [R0, #(2*10 + 1)*4]
    STR R3, [R0, #(2*10 + 2)*4]
    STR R3, [R0, #(2*10 + 3)*4]
    STR R3, [R0, #(2*10 + 6)*4]
    STR R3, [R0, #(2*10 + 7)*4]

    STR R3, [R0, #(3*10 + 2)*4]
    STR R3, [R0, #(3*10 + 6)*4]
    STR R3, [R0, #(3*10 + 7)*4]
    STR R3, [R0, #(3*10 + 8)*4]

    STR R3, [R0, #(4*10 + 2)*4]
    STR R3, [R0, #(4*10 + 6)*4]
    STR R3, [R0, #(4*10 + 7)*4]
    STR R3, [R0, #(4*10 + 8)*4]

    STR R3, [R0, #(5*10 + 2)*4]
    STR R3, [R0, #(5*10 + 6)*4]
    STR R3, [R0, #(5*10 + 7)*4]

    @ Cabeza de la serpiente (valor 1)
    MOV R3, #1
    STR R3, [R0, #(4*10 + 5)*4]

    @ Cuerpo de la serpiente (valor 2)
    MOV R3, #2
    STR R3, [R0, #(5*10 + 5)*4]

    BX LR

end:
    B end                      @ Bucle infinito

.data

UP_ARROW:   .word 0xE048
DOWN_ARROW: .word 0xE050
LEFT_ARROW: .word 0xE04B
RIGHT_ARROW:.word 0xE04D

KEYS:                       @ Arreglo de teclas simuladas
    .word 0xE04D            @ Derecha
    .word 0xE048            @ Arriba
    .word 0xE04B            @ Izquierda
    .word 0xE050            @ Abajo
    .word 0x1234            @ Tecla inválida
