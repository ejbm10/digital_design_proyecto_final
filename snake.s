.global _start

@ R7 = tamaño actual de la serpiente 
@ R8 = nivel actual 

_start:
    LDR R9, =0x1000            @ Dirección base del teclado simulado 
    LDR R10, =0x2000           @ Dirección base de la matriz
    MOV R8, #1                 @ Nivel inicial = 1
    BL init_game_level1        @ Inicializa el tablero y obstáculos del nivel 1
    MOV R7, #2                 @ Tamaño inicial de la serpiente (cabeza + cuerpo)
    B main_game_loop           @ Bucle principal del juego

main_game_loop:
    @ --- Comprobación de tamaño para pasar de nivel ---
	
	BL fake_grow_snake         @ Simula que la serpiente crece DESPUÉS del chequeo

    CMP R8, #1                 @ validacion Nivel 1
    BEQ check_level1
    CMP R8, #2                 @ validacion Nivel 2
    BEQ check_level2
    CMP R8, #3                 @ validacion Nivel 3
    BEQ check_level3

    
    B main_game_loop           @ sigue en el bucle principal

check_level1:
    CMP R7, #11                @ validacion de tamaño 11
    BLT main_game_loop         
    MOV R8, #2                 @ Pasa a nivel 2
    BL init_game_level2        @ Inicializa el tablero para nivel 2
    MOV R7, #2                 @ Reinicia tamaño de la serpiente
    B main_game_loop

check_level2:
    CMP R7, #18                @ validación tamaño 18
    BLT main_game_loop
    MOV R8, #3                 @ Pasa a nivel 3
    BL init_game_level3        @ Inicializa el tablero para nivel 3
    MOV R7, #2                 @ Reinicia tamaño de la serpiente
    B main_game_loop

check_level3:
    CMP R7, #25                @ validacion tamaño 25
    BLT main_game_loop
    BL win_game                @ gano
    B end

@ ---------- Inicialización de cada nivel----------

@ NIVEL 1
init_game_level1:
    MOV R12, #100
    LDR R0, =0x2000
    MOV R2, #0
fill_loop1:
    STR R2, [R0], #4
    SUBS R12, R12, #1
    BNE fill_loop1
    LDR R0, =0x2000
    MOV R3, #4

    @ Valor 4: obstaculos
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

    @ Cabeza 1 y cuerpo 2
    MOV R3, #1
    STR R3, [R0, #(1*10 + 1)*4]   
    MOV R3, #2
    STR R3, [R0, #(1*10 + 2)*4]   
    BX LR
	
@ NIVEL 2
init_game_level2:
    MOV R12, #100
    LDR R0, =0x2000
    MOV R2, #0
fill_loop2:
    STR R2, [R0], #4
    SUBS R12, R12, #1
    BNE fill_loop2
    LDR R0, =0x2000
    MOV R3, #4

     @ Valor 4: obstaculos
    STR R3, [R0, #(0*10 + 0)*4]
    STR R3, [R0, #(0*10 + 3)*4]
    STR R3, [R0, #(0*10 + 6)*4]
    STR R3, [R0, #(0*10 + 9)*4]
    STR R3, [R0, #(3*10 + 0)*4]
    STR R3, [R0, #(3*10 + 3)*4]
    STR R3, [R0, #(3*10 + 6)*4]
    STR R3, [R0, #(3*10 + 9)*4]
    STR R3, [R0, #(6*10 + 0)*4]
    STR R3, [R0, #(6*10 + 3)*4]
    STR R3, [R0, #(6*10 + 6)*4]
    STR R3, [R0, #(6*10 + 9)*4]
    STR R3, [R0, #(9*10 + 0)*4]
    STR R3, [R0, #(9*10 + 3)*4]
    STR R3, [R0, #(9*10 + 6)*4]
    STR R3, [R0, #(9*10 + 9)*4]

    STR R3, [R0, #(2*10 + 2)*4]
    STR R3, [R0, #(2*10 + 7)*4]
    STR R3, [R0, #(7*10 + 2)*4]
    STR R3, [R0, #(7*10 + 7)*4]

    @ Cabeza 1 y cuerpo 2
    MOV R3, #1
    STR R3, [R0, #(1*10 + 1)*4]   
    MOV R3, #2
    STR R3, [R0, #(1*10 + 2)*4]   
    BX LR

@ NIVEL 3
init_game_level3:
    MOV R12, #100
    LDR R1, =0x2000
    MOV R2, #0
fill_loop3:
    STR R2, [R1], #4
    SUBS R12, R12, #1
    BNE fill_loop3
    LDR R1, =0x2000
    MOV R3, #4

     @ Valor 4: obstaculos
    STR R3, [R1, #(0*10 + 0)*4]
    STR R3, [R1, #(0*10 + 2)*4]
    STR R3, [R1, #(0*10 + 4)*4]
    STR R3, [R1, #(0*10 + 6)*4]
    STR R3, [R1, #(0*10 + 8)*4]
    STR R3, [R1, #(1*10 + 0)*4]
    STR R3, [R1, #(1*10 + 4)*4]
    STR R3, [R1, #(1*10 + 8)*4]
    STR R3, [R1, #(2*10 + 0)*4]
    STR R3, [R1, #(2*10 + 2)*4]
    STR R3, [R1, #(2*10 + 4)*4]
    STR R3, [R1, #(2*10 + 6)*4]
    STR R3, [R1, #(2*10 + 8)*4]
    STR R3, [R1, #(3*10 + 0)*4]
    STR R3, [R1, #(3*10 + 6)*4]
    STR R3, [R1, #(3*10 + 9)*4]
    STR R3, [R1, #(4*10 + 2)*4]
    STR R3, [R1, #(4*10 + 4)*4]
    STR R3, [R1, #(4*10 + 6)*4]
    STR R3, [R1, #(5*10 + 3)*4]
    STR R3, [R1, #(5*10 + 5)*4]
    STR R3, [R1, #(6*10 + 0)*4]
    STR R3, [R1, #(6*10 + 2)*4]
    STR R3, [R1, #(6*10 + 4)*4]
    STR R3, [R1, #(6*10 + 6)*4]
    STR R3, [R1, #(6*10 + 8)*4]
    STR R3, [R1, #(7*10 + 0)*4]
    STR R3, [R1, #(7*10 + 4)*4]
    STR R3, [R1, #(7*10 + 8)*4]
    STR R3, [R1, #(8*10 + 0)*4]
    STR R3, [R1, #(8*10 + 2)*4]
    STR R3, [R1, #(8*10 + 4)*4]
    STR R3, [R1, #(8*10 + 6)*4]
    STR R3, [R1, #(8*10 + 8)*4]
    STR R3, [R1, #(9*10 + 0)*4]
    STR R3, [R1, #(9*10 + 2)*4]
    STR R3, [R1, #(9*10 + 4)*4]
    STR R3, [R1, #(9*10 + 6)*4]
    STR R3, [R1, #(9*10 + 8)*4]

    @ Cabeza 1 y cuerpo 2
    MOV R3, #1
    STR R3, [R1, #(1*10 + 1)*4]   
    MOV R3, #2
    STR R3, [R1, #(1*10 + 2)*4]   
    BX LR

@ --- Simulación de crecimiento de la serpiente ---
fake_grow_snake:
    ADD R7, R7, #1             @ Aumenta el tamaño de la serpiente en 1 segmento
    BX LR

@ --- Gane ---
win_game:
    B end                      @ Termina el juego

end:
    B end

.data

UP_ARROW:   .word 0xE048
DOWN_ARROW: .word 0xE050
LEFT_ARROW: .word 0xE04B
RIGHT_ARROW:.word 0xE04D

KEYS:                           @ Arreglo de teclas simuladas
    .word 0xE04D                @ Derecha
    .word 0xE048                @ Arriba
    .word 0xE04B                @ Izquierda
    .word 0xE050                @ Abajo
    .word 0x1234                @ Tecla inválida
