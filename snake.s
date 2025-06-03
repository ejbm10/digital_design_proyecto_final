.global _start

_start:
    LDR R9, =0x1000        @ Dirección del teclado simulado
    LDR R1, =0x3000        @ Dirección de la dirección de movimiento

    LDR R2, =UP_ARROW      @ Constante flecha arriba
    LDR R2, [R2]
    LDR R3, =DOWN_ARROW    @ Constante flecha abajo
    LDR R3, [R3]
    LDR R4, =LEFT_ARROW
    LDR R4, [R4]
    LDR R5, =RIGHT_ARROW
    LDR R5, [R5]

    LDR R6, =KEYS          @ Arreglo de teclas simuladas
    MOV R7, #0             @ Índice
    MOV R8, #5             @ Total de teclas

loop:
    CMP R7, R8
    BEQ end

    LDR R0, [R6, R7, LSL #2]   @ Leer tecla simulada
    STR R0, [R9]               @ Simular entrada
    LDR R0, [R9]               @ Leer desde "teclado"

    CMP R0, R2                 @ ¿UP?
    BEQ set_up
    CMP R0, R3                 @ ¿DOWN?
    BEQ set_down
    CMP R0, R4                 @ ¿LEFT?
    BEQ set_left
    CMP R0, R5                 @ ¿RIGHT?
    BEQ set_right

    B next

set_up:
    MOV R10, #0
    STR R10, [R1]
    B next

set_down:
    MOV R10, #1
    STR R10, [R1]
    B next

set_left:
    MOV R10, #2
    STR R10, [R1]
    B next

set_right:
    MOV R10, #3
    STR R10, [R1]
    B next

next:
    ADD R7, R7, #1
    B loop

end:
    B end

.data
UP_ARROW:   .word 0xE048
DOWN_ARROW: .word 0xE050
LEFT_ARROW: .word 0xE04B
RIGHT_ARROW:.word 0xE04D

KEYS:       .word 0xE048   @ UP
            .word 0xE050   @ DOWN
            .word 0xE04B   @ LEFT
            .word 0xE04D   @ RIGHT
            .word 0x1234   @ inválida