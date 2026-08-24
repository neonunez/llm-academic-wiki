# Indice — Sistemas Digitales

Ultima actualizacion: 2026-08-24 (`/programa` — propagacion del programa 2C_2026)

> ⚠️ **La materia pasa a tener UN SOLO PARCIAL.** El programa vigente (`2C_2026`) evalua las
> 10 unidades del temario en un unico examen. Por convencion ese parcial unico se rotula `1P`,
> asi que **todas** las paginas de `temas/` y `tipos_ejercicio/` llevan `parcial: 1P`. **No
> existe un 2P.**
>
> Los 6 parciales de `parciales_analizados/` fueron tomados bajo el **esquema viejo de dos
> parciales** (1P = representacion/combinatoria/secuencial, 2P = arquitectura/RISC-V/
> microarquitectura). Sus rotulos `1P`/`2P` son **hechos historicos** y no dicen nada sobre
> como te van a tomar a vos. Siguen siendo un banco de ejercicios excelente, pero **ninguno
> sirve como simulacro completo** de tu parcial.
>
> Huecos conocidos: **Diseño Modular (unidades 6 y 7)** no tiene pagina propia y **punto fijo
> y flotante** (unidad 5) no esta cubierto. Ver [[programa]] para el detalle.

## Temas — Parcial unico (`1P`)

### Representacion de la Informacion

- [[temas/representacion_de_informacion_teoria]] — Sistemas de representacion, bases, cambio de base, tipos numericos (sin signo, signo+magnitud, exceso m, C2), operaciones logico-aritmeticas, carry y overflow
- [[temas/representacion_de_informacion_guia]] — Guia de ejercicios (13 ejercicios): conversion de bases, sumas precision fija, C2 vs S+M, overflow, extension de signo, inverso aditivo, biyectividad. resuelta

### Logica Combinatoria

- [[temas/logica_combinatoria_teoria]] — Algebra de Boole (axiomas, propiedades, De Morgan), compuertas basicas (NOT/AND/OR/XOR), SDP mecanismo de traduccion, circuitos estandar (half adder, full adder, shift LR, MUX/DEMUX, codificador/decodificador), timing y latencia
- [[temas/logica_combinatoria_guia]] — Guia de ejercicios (Ej 1–10, Practica 2 Partes 1+2): equivalencias booleanas, universalidad NAND/NOR, circuitos con NOR/NAND, SDP+simplificacion, inversor k-bits, inverso aditivo C2, DEMUX/codificador/decodificador. resuelta (diagramas Ej 4/5/6/8/9/10 incorporados)

### Logica Secuencial

- [[temas/logica_secuencial_teoria]] — Latches (RS/JK/D), FF-D y FF-JK (edge-triggered), registros N-bit con WriteEnable, componentes tristate, bus de registros, memorias (intro), FSM Moore/Mealy (logica de proximo estado y de salida)
- [[temas/logica_secuencial_guia]] — Guia de ejercicios (Ej 11–19, Practica 2 Partes 1+2): diagrama temporal con oscilacion, tablas caracteristicas JK, registro simple/bidireccional/tristate, extensor de signo 2→4, desplazador izquierda, auto-incrementador, operacion R0:=R0+R1 con bus. resuelta (diagrama Ej 14 incorporado)
- [[temas/hdl_system_verilog]] — HDL/SystemVerilog: modulos, modelado comportamental (assign/always_ff/always_comb), MUX/ternario, operadores de reduccion, manipulacion de bits, reset async/sync, case, modelado estructural (instancias), full adder ejemplo

### Diseño Modular (unidades 6 y 7)

- **Sin pagina propia.** Contenido disperso: mux/sumador/ALU en [[temas/logica_combinatoria_teoria]], registros de desplazamiento y contadores en [[temas/logica_secuencial_teoria]] y [[temas/logica_secuencial_guia]], Register File y memorias en [[temas/arquitectura_teoria_pt1]]. Restadores y comparadores: sin cobertura. Ver [[programa]].

### Arquitectura de Computadoras

- [[temas/arquitectura_teoria_pt1]] — Definicion de arquitectura, RISC-V: registros (x0-x31), instrucciones aritmeticas/logicas/desplazamiento, memoria (lw/sw base+offset), inmediatos 12-bit y 32-bit (lui+addi), control de flujo (beq/bne/blt/bge/j/jal), ciclo fetch-decode-execute, tipos de instruccion maquina (R/I/S/B/U/J), mapa de memoria, directivas de ensamblado
- [[temas/arquitectura_teoria_pt2]] — Acceso a memoria y arreglos (byte addressing, word address, slli+add+lw/sw), ABI RISC-V (argumentos a0–a7, retorno a0, jal/jr ra), preservacion de registros (caller-saved t/a, callee-saved s/ra), uso de la pila (stack pointer sp, push/pop, stack frame, alineacion 16-byte), recursion con pila, pseudoinstrucciones (li/mv/j/ret/nop)
- [[temas/arquitectura_cpu_guia]] — Guia de ejercicios Practica 3 (Ej 1–7 ensamblado/seguimiento + Ej 16–21 otras arquitecturas/opcode extensible): byte addressing, loads, arreglos 16-bit, etiquetas/offsets, C→RISC-V, tipos R/I/S/B/U/J, ensamblado/desensamblado, ciclo instruccion con seguimiento. resuelta

### Microarquitectura

- [[temas/microarquitectura_teoria]] — Definicion de microarquitectura, estado arquitectonico, elementos de memoria (PC/mem_instrucciones/archivo_registros/mem_datos), procesador de ciclo simple, datapath (lw/sw/tipo-R/beq), senales de control (RegWrite/ImmSrc/ALUSrc/ALUControl/MemWrite/ResultSrc), unidad de control desacoplada (controlador + decodificador ALU), logica PCSrc para saltos

### Programacion RISC-V

- [[temas/programacion_risc_v_guia]] — Guia de ejercicios Practica 3 (Ej 8–15): .text/.data, extraer bytes de registro, implementar sll sin sll, maximo de arreglo, copiar vector, copiar elementos pares, sumar64, sumaVector64. resuelta
- [[temas/programacion_risc_v_guia_pt2]] — Guia de ejercicios Practica 4 (Ej 1–11): convencion de llamada (debugging+programacion), uso del stack con auxiliares, recursion (factorial/Collatz/Fibonacci3/FibonacciN/biseccion), manejo de estructuras (InformacionAlumno/lista enlazada/busqueda binaria). resuelta

## Tipos de ejercicio

Todos entran en tu **parcial unico** (`1P`). La columna de origen indica bajo que rotulo se
tomaban en el esquema viejo de dos parciales — es informacion historica, no un reparto vigente.

### Ya venian rotulados 1P

- [[tipos_ejercicio/rangos_representacion_numerica]] — Rangos S+M/C2, codificacion decimal↔binario, bits fijos (Ej1 en todos los 1P)
- [[tipos_ejercicio/carry_y_overflow]] — Deteccion de carry y overflow en C2, regla de signo, $V=C_k \oplus C_{k-1}$ (Ej1 en todos los 1P)
- [[tipos_ejercicio/flags_alu_cvzn]] — Tabla de flags CVZN para suma/resta ALU 4-bit (1P_1C_2025 Ej1)
- [[tipos_ejercicio/operadores_universales_nand_nor]] — NAND y NOR son universales; construccion de NOT/AND/OR con cada uno (Ej2 en todos los 1P)
- [[tipos_ejercicio/circuito_con_compuerta_especifica]] — Implementar funcion con NOR/NAND restringido + simplificacion algebraica (Ej3 en todos los 1P)
- [[tipos_ejercicio/sdp_y_simplificacion]] — SDP canonica desde tabla de verdad + simplificacion algebraica + circuito (Ej2 en 1P_1C_2025)
- [[tipos_ejercicio/registro_bidireccional_tristate]] — Registro con lineas bidireccionales usando FF-D + buffer tristate (Ej4 en 1P_2C_2024)
- [[tipos_ejercicio/registro_desplazamiento_mux]] — Registro de desplazamiento con MUX + FF-D; variante circular (Ej4 en 1P_2C_2024_recuperatorio; Ej3 en 1P_1C_2025)
- [[tipos_ejercicio/tabla_estados_flip_flop]] — Tabla de estados ciclo a ciclo con FF-D hasta encontrar ciclo (Ej3 en 1P_1C_2025)

### Reubicados desde 2P (esquema viejo) — hoy tambien entran en tu parcial unico

- [[tipos_ejercicio/funcion_recursiva_risc_v]] — Funcion recursiva con saved registers y multiples llamadas (Ej1 en todos los 2P)
- [[tipos_ejercicio/convencion_llamada_risc_v]] — Callee/caller-saved, stack frame, preservacion de argumentos via s* (transversal a todos los 2P)
- [[tipos_ejercicio/iteracion_arreglo_risc_v]] — Recorrido de arreglos con loop/recursion, llamadas a funcion auxiliar, paridad sin REM (Ej2 en todos los 2P)
- [[tipos_ejercicio/structs_y_memoria_risc_v]] — Structs sin padding, offsets manuales, lbu/lh/lw por tipo, centinela (Ej3 en todos los 2P)
- [[tipos_ejercicio/microarquitectura_ciclo_simple]] — Datapath ciclo simple, senales de control, instrucciones tipo R/B, extensor de signo (Ej4 en todos los 2P)

## Parciales analizados

> Todos fueron tomados bajo el **programa viejo de dos parciales** (vigente hasta 1C 2026).
> Los rotulos `1P`/`2P` de abajo son historicos. Usalos como banco de ejercicios por tema,
> **no** como simulacro del parcial unico.

- [[parciales_analizados/1P_1C_2025]] — 1er Parcial 1C 2025 (nota: 9) | Ej1: truncado hex + flags ALU 4-bit | Ej2: SDP + simplificacion algebraica + NOR | Ej3: flip-flops D registro desplazamiento circular
- [[parciales_analizados/1P_2C_2024]] — 1er Parcial 2C 2024 | 2 resoluciones (notas: 10 y 9.5) | Ej1: rangos S+M/C2 + inverso aditivo + carry/overflow | Ej2: NAND y NOR universales | Ej3: circuito A·B·C con NOR + simplificacion booleana | Ej4: registro bidireccional tristate modular
- [[parciales_analizados/2P_1C_2025]] — 2do Parcial 1C 2025 | Ej1: recursion RISC-V | Ej2: array structs | Ej3: datapath beq | 2 resoluciones incorporadas
- [[parciales_analizados/2P_2C_2024]] — 2do Parcial 2C 2024 (nota: 10) | Ej1: Pascal recursivo RISC-V | Ej2: inv + invertirArreglo | Ej3: BalanceDeudor structs | Ej4: microarquitectura `or x4,x5,x6`
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Recuperatorio 1P 2C 2024 (nota: 10) | Ej1: S+M bit fijo + suma C2 + paridad/negativo condicion | Ej2: universalidad NAND/NOR (V/F) | Ej3: (A+B)C con NAND + XNOR | Ej4: registro desplazamiento bidireccional MUX+FF-D
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — 2do Recuperatorio 2C 2024 | Ej1: es_primo + cantidad_divisores (recursion mutua) | Ej2: es_par + arreglo_par | Ej3: BalanceDeudor structs contarDeudores | Ej4: ResultSrc y bits rs2

## Sintesis

(pendiente — paginas a demanda; `wiki/sintesis/` esta vacio)

## Programa

- [[programa]] — **fuente de verdad** del reparto de temas por parcial (`2C_2026`, parcial unico), temario oficial de 10 unidades, huecos de cobertura e historial de programas
