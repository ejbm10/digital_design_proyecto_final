
	.global _start

@ R7 = tamaño actual de la serpiente 
@ R8 = nivel actual 
@ R9 = Dirección base del teclado simulado: 0x1000
@ Dirección hacia donde se mueve: 0x1004
@ Dirección base de la matriz: 0x2000
@ Dirección base de la posición de la serpiente: 0x3000
@ Para la posición de la serpiente se utiliza: (r*10 + c)*4 donde r es la fila y c la columna

_start:
    MOV R8, #1                 @ Nivel inicial = 1
    MOV R7, #3                 @ Tamaño inicial de la serpiente (cabeza + cuerpo)
    LDR R9, =0x1000            @ Dirección del teclado simulado
    MOV R12, #0                @ Índice del arreglo simulación teclado
    BL init_game_level1        @ Inicializa el tablero y obstáculos del nivel 1
	BL update_matrix_snake
    BL rand_apple              @ Coloca una manzana inicial aleatoria
    B main_game_loop           @ Bucle principal del juego

main_game_loop:    
    BL move
	BL update_matrix_snake
    
    @BL fake_grow_snake
    CMP R8, #1                 @ validacion Nivel 1
    BEQ check_level1
    CMP R8, #2                 @ validacion Nivel 2
    BEQ check_level2
    CMP R8, #3                 @ validacion Nivel 3
    BEQ check_level3

    B main_game_loop           @ sigue en el bucle principal

check_level1:
    CMP R7, #10                @ validacion de tamaño 10
    BLT main_game_loop         
    MOV R8, #2                 @ Pasa a nivel 2
    BL init_game_level2        @ Inicializa el tablero para nivel 2
    BL rand_apple              @ Nueva manzana para el nuevo nivel
    MOV R7, #2                 @ Reinicia tamaño de la serpiente
    B main_game_loop

check_level2:
    CMP R7, #10                @ validación tamaño 10
    BLT main_game_loop
    MOV R8, #3                 @ Pasa a nivel 3
    BL init_game_level3        @ Inicializa el tablero para nivel 3
    BL rand_apple              @ Nueva manzana para el nuevo nivel
    MOV R7, #2                 @ Reinicia tamaño de la serpiente
    B main_game_loop

check_level3:
    CMP R7, #10                @ validacion tamaño 10
    BLT main_game_loop
    BL win_game                @ gano
    B end

@ ---------- Inicialización de cada nivel----------

@ NIVEL 1
init_game_level1:
    PUSH {R12}
    MOV R12, #100
    LDR R0, =0x2000
    MOV R2, #0
fill_loop1:
    STR R2, [R0], #4
    SUBS R12, R12, #1
    BNE fill_loop1
    POP {R12}
@ ===== Nivel1 ===== Obstáculos
    LDR R0, =0x2000
    MOV R3, #4

    STR R3, [R0, #( 3*10 + 1 )*4]
    STR R3, [R0, #( 3*10 + 2 )*4]
    STR R3, [R0, #( 3*10 + 3 )*4]
    STR R3, [R0, #( 3*10 + 6 )*4]
    STR R3, [R0, #( 3*10 + 7 )*4]
    STR R3, [R0, #( 4*10 + 2 )*4]
    STR R3, [R0, #( 4*10 + 6 )*4]
    STR R3, [R0, #( 4*10 + 7 )*4]
    STR R3, [R0, #( 4*10 + 8 )*4]
    STR R3, [R0, #( 5*10 + 2 )*4]
    STR R3, [R0, #( 5*10 + 6 )*4]
    STR R3, [R0, #( 5*10 + 7 )*4]
    STR R3, [R0, #( 5*10 + 8 )*4]
    STR R3, [R0, #( 6*10 + 2 )*4]
    STR R3, [R0, #( 6*10 + 6 )*4]
    STR R3, [R0, #( 6*10 + 7 )*4]
	
	MOV R3, #5
	STR R3, [R0, #( 0*10 + 6 )*4]

    @ Cabeza 1 y cuerpo 2
    LDR R0, =0x3000      @ Dirección de cabeza de serpiente
    MOV R3, #(0*10 + 2)*4
    STR R3, [R0]  
    MOV R3, #(0*10 + 1)*4
    STR R3, [R0, #4]  
	MOV R3, #(0*10 + 0)*4
	STR R3, [R0, #8]
	MOV R3, #666
	STR R3, [R0, #12]
    BX LR

@ NIVEL 2
init_game_level2:
    PUSH {R12}
    MOV R12, #100
    LDR R0, =0x2000
    MOV R2, #0
fill_loop2:
    STR R2, [R0], #4
    SUBS R12, R12, #1
    BNE fill_loop2
    POP {R12}
@ ===== Nivel2 =====
    LDR R0, =0x2000
    MOV R3, #4

    STR R3, [R0, #( 0*10 + 0 )*4]
    STR R3, [R0, #( 0*10 + 3 )*4]
    STR R3, [R0, #( 0*10 + 6 )*4]
    STR R3, [R0, #( 0*10 + 9 )*4]
    STR R3, [R0, #( 2*10 + 2 )*4]
    STR R3, [R0, #( 2*10 + 7 )*4]
    STR R3, [R0, #( 3*10 + 0 )*4]
    STR R3, [R0, #( 3*10 + 3 )*4]
    STR R3, [R0, #( 3*10 + 6 )*4]
    STR R3, [R0, #( 3*10 + 9 )*4]
    STR R3, [R0, #( 6*10 + 0 )*4]
    STR R3, [R0, #( 6*10 + 3 )*4]
    STR R3, [R0, #( 6*10 + 6 )*4]
    STR R3, [R0, #( 6*10 + 9 )*4]
    STR R3, [R0, #( 7*10 + 2 )*4]
    STR R3, [R0, #( 7*10 + 7 )*4]
    STR R3, [R0, #( 9*10 + 0 )*4]
    STR R3, [R0, #( 9*10 + 3 )*4]
    STR R3, [R0, #( 9*10 + 6 )*4]
    STR R3, [R0, #( 9*10 + 9 )*4]

    @ Cabeza 1 y cuerpo 2
    MOV R3, #1
    STR R3, [R0, #(1*10 + 1)*4]   
    MOV R3, #2
    STR R3, [R0, #(1*10 + 2)*4]   
    BX LR

@ NIVEL 3
init_game_level3:
    PUSH {R12}
    MOV R12, #100
    LDR R1, =0x2000
    MOV R2, #0
fill_loop3:
    STR R2, [R1], #4
    SUBS R12, R12, #1
    BNE fill_loop3
    POP {R12}
@ ===== Nivel3 =====
    LDR R0, =0x2000
    MOV R3, #4

    STR R3, [R0, #( 0*10 + 0 )*4]
    STR R3, [R0, #( 0*10 + 1 )*4]
    STR R3, [R0, #( 0*10 + 8 )*4]
    STR R3, [R0, #( 0*10 + 9 )*4]
    STR R3, [R0, #( 1*10 + 0 )*4]
    STR R3, [R0, #( 1*10 + 6 )*4]
    STR R3, [R0, #( 1*10 + 9 )*4]
    STR R3, [R0, #( 2*10 + 3 )*4]
    STR R3, [R0, #( 2*10 + 4 )*4]
    STR R3, [R0, #( 2*10 + 5 )*4]
    STR R3, [R0, #( 2*10 + 6 )*4]
    STR R3, [R0, #( 3*10 + 3 )*4]
    STR R3, [R0, #( 4*10 + 1 )*4]
    STR R3, [R0, #( 4*10 + 3 )*4]
    STR R3, [R0, #( 4*10 + 8 )*4]
    STR R3, [R0, #( 5*10 + 1 )*4]
    STR R3, [R0, #( 5*10 + 6 )*4]
    STR R3, [R0, #( 5*10 + 8 )*4]
    STR R3, [R0, #( 6*10 + 6 )*4]
    STR R3, [R0, #( 7*10 + 3 )*4]
    STR R3, [R0, #( 7*10 + 4 )*4]
    STR R3, [R0, #( 7*10 + 5 )*4]
    STR R3, [R0, #( 7*10 + 6 )*4]
    STR R3, [R0, #( 8*10 + 0 )*4]
    STR R3, [R0, #( 8*10 + 3 )*4]
    STR R3, [R0, #( 8*10 + 9 )*4]
    STR R3, [R0, #( 9*10 + 0 )*4]
    STR R3, [R0, #( 9*10 + 1 )*4]
    STR R3, [R0, #( 9*10 + 8 )*4]
    STR R3, [R0, #( 9*10 + 9 )*4]

    @ Cabeza 1 y cuerpo 2
    MOV R3, #1
    STR R3, [R1, #(4*10 + 5)*4]   
    MOV R3, #2
    STR R3, [R1, #(4*10 + 4)*4]   
    BX LR

@ --- Simulación de crecimiento de la serpiente ---
fake_grow_snake:
    ADD R7, R7, #1             @ Aumenta el tamaño de la serpiente en 1 segmento
    BX LR
	

update_matrix_snake:
    PUSH {R0-R4, LR}

    LDR R0, =0x2000        @ Dirección base de la matriz
    LDR R1, =0x3000        @ Dirección base de la lista de posiciones de la serpiente
    ADD R2, R7, #1             @ Contador de segmentos
    MOV R3, #0             @ Índice (offsets en lista de posiciones)

@ --- Limpiar todas las posiciones anteriores de la serpiente ---
clear_snake_loop:
    CMP R2, #0
    BEQ set_new_snake      @ Ya terminó de limpiar

    LDR R4, [R1, R3]       @ Leer posición i de la serpiente (offset dentro de la matriz)
	MOV R5, #666
	CMP R4, R5
	BEQ set_new_snake
	
    ADD R4, R4, R0         @ Dirección absoluta en matriz: 0x2000 + offset
    MOV R5, #0
    STR R5, [R4]           @ Limpiar celda
    ADD R3, R3, #4         @ Siguiente elemento
    SUB R2, R2, #1
    B clear_snake_loop
	
	
@ --- Escribir nuevas posiciones de la serpiente ---
set_new_snake:
    LDR R0, =0x2000        @ Dirección base de la matriz
    LDR R1, =0x3000        @ Dirección base de la lista de posiciones de la serpiente
    MOV R2, R7             @ Contador de segmentos
    MOV R3, #0             @ Índice (offsets en lista de posiciones)
    MOV R4, #1             @ El primer valor será 1 (cabeza)

write_snake_loop:
    CMP R2, #0
    BEQ end_update_matrix

    LDR R5, [R1, R3]       @ Leer offset de matriz
    ADD R5, R5, R0         @ Dirección absoluta
    STR R4, [R5]           @ Escribir 1 (cabeza) o 2 (cuerpo)

    MOV R4, #2             @ Las siguientes serán cuerpo
    ADD R3, R3, #4         @ Siguiente posición de la serpiente
    SUB R2, R2, #1
    B write_snake_loop

end_update_matrix:
    POP {R0-R4, LR}
    BX LR

@ --- Movimiento de la serpiente ---

move:
    PUSH {LR}
    
    BL sim_keys

    BL read_key
    
    MOV R6, #0
    LDR R0, =0x3000
    LDR R1, [R0]
    BL move_aux

    @ 1. Verificar si está dentro del rango [0, 0x18C]
    CMP R6, #0
    BLT die
    CMP R6, #0x18C
    BGT die

    @ 2. Verificar si el valor en la nueva celda es un obstáculo (4) o cuerpo (2)
    LDR R2, =0x2000
    ADD R3, R2, R6          @ R3 ← dirección de la nueva celda
    LDR R4, [R3]            @ R4 ← contenido de la celda
    CMP R4, #4
    BEQ die
    CMP R4, #2
    BEQ die

    CMP R4, #5              @ verificación si ha manzana
    BEQ apple            @ Sí hay, aumenta
	
	BL mover_cuerpo
	
	@ Si no hay colisión, actualizar posición de la cabeza
    LDR R0, =0x3000     @ Dirección base
    STR R6, [R0]            @ Guardar nueva posición

    POP {LR}
	BX LR
	
mover_cuerpo:
	LDR R0, =0x3000     @ Coordenada de cabeza
    MOV R1, R7         @ R7 contiene el índice final (ej. 1 → 0x3004)
    LSL R1, R1, #2      @ R1 = R1 * 4 (desplazamiento en bytes)
    ADD R0, R0, R1      @ R0 = dirección final
    MOV R2, R7           @ Número de movimientos (0x3008, 0x3004, 0x3000)    
    B shift_right_loop

apple:                   @ método de validación para saber si hay manzana o no

	BL fake_grow_snake      @ Crece la serpiente
	BL mover_cuerpo
    @ Actualizar posición de la cabeza
    LDR R0, =0x3000     @ Dirección base
    STR R6, [R0]            @ Guardar nueva posición
    BL rand_apple           @ Se coloca una nueva manzana

    POP {LR}
    BX LR

read_key:
    LDR R4, [R9]               @ Leer valor de la tecla desde 0x1000
    LDR R2, =UP_ARROW      @ Cargar dirección donde esta la constante de flecha arriba
    LDR R2, [R2]       @ Constante flecha arriba
    CMP R4, R2                 @ ¿Flecha arriba?
    BEQ change_direction
    
    LDR R2, =DOWN_ARROW      @ Cargar dirección donde esta la constante de flecha abajo
    LDR R2, [R2]       @ Constante flecha abajo
    CMP R4, R2                 @ ¿Flecha abajo?
    BEQ change_direction
    
    LDR R2, =LEFT_ARROW      @ Cargar dirección donde esta la constante de flecha izquierda
    LDR R2, [R2]       @ Constante flecha izquierda
    CMP R4, R2                 @ ¿Flecha izquierda?
    BEQ change_direction
    
    LDR R2, =RIGHT_ARROW      @ Cargar dirección donde esta la constante de flecha derecha
    LDR R2, [R2]       @ Constante flecha derecha
    CMP R4, R2                 @ ¿Flecha derecha?
    BEQ change_direction
    
    BX LR

change_direction:
    LDR R0, [R9]          @ Nueva tecla presionada (posible nueva dirección)
    LDR R1, [R9, #4]      @ Dirección actual

    @ Comparar eje vertical
    LDR R2, =UP_ARROW
    LDR R2, [R2]
    CMP R0, R2
    BEQ check_vertical

    LDR R2, =DOWN_ARROW
    LDR R2, [R2]
    CMP R0, R2
    BEQ check_vertical

    @ Comparar eje horizontal
    LDR R2, =LEFT_ARROW
    LDR R2, [R2]
    CMP R0, R2
    BEQ check_horizontal

    LDR R2, =RIGHT_ARROW
    LDR R2, [R2]
    CMP R0, R2
    BEQ check_horizontal

    B end_change_dir

@ --- Verificar si nueva dirección vertical es opuesta a la actual
check_vertical:
    LDR R2, =UP_ARROW
    LDR R2, [R2]
    CMP R1, R2
    BEQ end_change_dir      @ Ya va en UP, no cambiar a DOWN

    LDR R2, =DOWN_ARROW
    LDR R2, [R2]
    CMP R1, R2
    BEQ end_change_dir      @ Ya va en DOWN, no cambiar a UP

    B apply_direction

@ --- Verificar si nueva dirección horizontal es opuesta a la actual
check_horizontal:
    LDR R2, =LEFT_ARROW
    LDR R2, [R2]
    CMP R1, R2
    BEQ end_change_dir      @ Ya va en LEFT, no cambiar a RIGHT

    LDR R2, =RIGHT_ARROW
    LDR R2, [R2]
    CMP R1, R2
    BEQ end_change_dir      @ Ya va en RIGHT, no cambiar a LEFT

    B apply_direction

@ --- Aplicar nueva dirección si es válida
apply_direction:
    STR R0, [R9, #4]     @ Guardar nueva dirección en 0x1004

end_change_dir:
    BX LR

move_aux:
    LDR R4, [R9, #4]
    LDR R2, =UP_ARROW      @ Cargar dirección donde esta la constante de flecha arriba
    LDR R2, [R2]       @ Constante flecha arriba
    CMP R4, R2                 @ ¿Flecha arriba?
    BEQ move_up
    
    LDR R2, =DOWN_ARROW      @ Cargar dirección donde esta la constante de flecha abajo
    LDR R2, [R2]       @ Constante flecha abajo
    CMP R4, R2                 @ ¿Flecha abajo?
    BEQ move_down
    
    LDR R2, =LEFT_ARROW      @ Cargar dirección donde esta la constante de flecha izquierda
    LDR R2, [R2]       @ Constante flecha izquierda
    CMP R4, R2                 @ ¿Flecha izquierda?
    BEQ move_left_check
    
    LDR R2, =RIGHT_ARROW      @ Cargar dirección donde esta la constante de flecha derecha
    LDR R2, [R2]       @ Constante flecha derecha
    CMP R4, R2                 @ ¿Flecha derecha?
    BEQ move_right_check

@ Movimiento con verificación de colisión a la izquierda
move_left_check:
    MOV R2, R1
	PUSH {LR}
    BL mod10_generic      @ R2 ← R1 % 40 (bytes por fila) → luego div 4
	POP {LR}
    CMP R2, #0
    BEQ die               @ Si está en la primera columna, muere
    B move_left

@ Movimiento con verificación de colisión a la derecha
move_right_check:
    MOV R2, R1
	PUSH {LR}
    BL mod10_generic
	POP {LR}
    CMP R2, #36           @ 9 * 4 = 36 (última columna en bytes)
    BEQ die               @ Si está en la última columna, muere
    B move_right

move_up:
    SUB R6, R1, #40         @UP
    BX LR
    
move_down:
    ADD R6, R1, #40        @Down
    BX LR
    
move_left:
    SUB R6, R1, #4         @Left
    BX LR
    
move_right:
    ADD R6, R1, #4         @Right
    BX LR

shift_right_loop:
    SUB R0, R0, #4         @ Dirección anterior
    LDR R3, [R0]           @ Leer valor de dirección anterior
    ADD R4, R0, #4         @ Dirección destino
    STR R3, [R4]           @ Guardar valor en siguiente dirección

    SUBS R2, R2, #1        @ Decrementar contador
    BNE shift_right_loop
    BX LR

sim_keys:
    LDR R6, =KEYS          @ Arreglo de teclas simuladas
    MOV R0, #5             @ Total de iteraciones simulación teclado
    CMP R12, R0             @ Revisa si ya se realizaron todas las iteraciones
    BEQ sim_end
    LDR R0, [R6, R12, LSL #2]   @ Leer tecla simulada
    STR R0, [R9]               @ Simular que "teclado" puso la tecla en 0x1000
    ADD R12, R12, #1
    BX LR
    
sim_end:
    BX LR

@ --- Colocar una manzana en posición aleatoria libre ---
rand_apple:
    PUSH {R1-R7, LR}
	PUSH {R12}
gen_loop:
    LDR R1, =seed
    LDR R2, [R1]
    ADD R2, R2, #37

    LDR R3, =73
    MUL R2, R2, R3        @ R2 = (R2 + 37) * 73

    AND R2, R2, #0xFF
    STR R2, [R1]

    MOV R10, R2
    BL mod10              @ R10 = R10 % 10 (fila)

    ADD R2, R2, #97
    MOV R11, R2
    BL mod10_R11          @ R11 = R11 % 10 (columna)

    LDR R3, =0x2000
    MOV R5, #10
    MUL R4, R10, R5       @ R4 = fila * 10
    ADD R4, R4, R11       @ R4 = fila * 10 + columna
    MOV R5, #2
    LSL R4, R4, R5        @ R4 = (fila * 10 + columna) * 4
    ADD R3, R3, R4
    LDR R5, [R3]          @Lee  el valor de la celda donde se quiere colocar la manzana
    CMP R5, #0            @Si la celda está ocupada repite el ciclo y busca otra
    BNE gen_loop

    MOV R5, #5
    STR R5, [R3]          @ Escribe el valor 5 en la matriz cuando este libre 
	POP {R12}
    POP {R1-R7, LR}
    BX LR

@ R2 ← R1 % 40 (posición en bytes dentro de la fila)
mod10_generic:
    MOV R3, #40
mod10_generic_loop:
    CMP R2, R3
    BLT mod10_generic_end
    SUB R2, R2, R3
    B mod10_generic_loop
mod10_generic_end:
    BX LR

@ Subrutina: R10 % 10 → R10 (resultado)
mod10:
    MOV R12, #10
mod10_loop:
    CMP R10, R12
    BLT mod10_end
    SUB R10, R10, R12
    B mod10_loop
mod10_end:
    BX LR

@ Subrutina: R11 % 10 → R11 (resultado)
mod10_R11:
    MOV R12, #10
mod10_R11_loop:
    CMP R11, R12
    BLT mod10_R11_end
    SUB R11, R11, R12
    B mod10_R11_loop
mod10_R11_end:
    BX LR
@ --- Gane ---
win_game:
    B end                      @ Termina el juego

die:
    LDR R1, [R0]         @ R1 ← offset actual de la cabeza (0 ≤ offset ≤ 0x18C)
    LDR R2, =0x2000      @ Base de la matriz
    ADD R3, R2, R1       @ R3 ← dirección absoluta de la cabeza
    MOV R4, #8           @ Valor que representa muerte
    STR R4, [R3]         @ Guardar el 8 en la posición de la cabeza
    B end

end:
    B end               @ Bucle infinito

.data

UP_ARROW:   .word 0xE048
DOWN_ARROW: .word 0xE050
LEFT_ARROW: .word 0xE04B
RIGHT_ARROW:.word 0xE04D
DIRECTION:.word 0xE04D

KEYS:                           @ Arreglo de teclas simuladas
    .word 0xE04D                @ Derecha
	.word 0xE04D                @ Derecha
    .word 0xE04D                @ Derecha
	.word 0xE04D                @ Derecha
    .word 0x1234                @ Tecla inválida

seed:   .word 0x5A              @ Semilla para aleatorio