# Log — Sistemas Digitales


## 2026-08-24 programa | 2C_2026

Cambio de reparto: la materia pasa de **dos parciales a un parcial unico** que cubre las 10
unidades del temario. Por convencion el parcial unico se rotula `1P`; no existe `2P`.

- `arquitectura`: 2P → 1P
- `programacion_risc_v`: 2P → 1P
- `microarquitectura`: 2P → 1P
- `representacion_de_informacion`, `logica_combinatoria`, `logica_secuencial`: 1P → 1P (sin movimiento)
- `diseno_modular`: nuevo en el mapa → 1P (unidades 6 y 7, todavia **sin pagina propia** en `wiki/temas/`)

Paginas actualizadas: 13 en `temas/` (6 cambiaron de parcial), 14 en `tipos_ejercicio/`
(5 cambiaron de parcial). Las 27 llevan ahora `programa: 2C_2026` debajo de `parcial:`.

Normalizacion de `tema:`:
- `temas/arquitectura_cpu_guia.md`: `arquitectura_cpu` → `arquitectura` (alias documentado en `programa.md`)
- `temas/arquitectura_teoria_pt2.md`: `arquitectura, programacion_risc_v` → `arquitectura` (secundario preservado como comentario YAML)
- `temas/hdl_system_verilog.md`: `logica_combinatoria, logica_secuencial` → `logica_combinatoria` (idem)

Avisos de reubicacion insertados (5): `convencion_llamada_risc_v`, `funcion_recursiva_risc_v`,
`iteracion_arreglo_risc_v`, `structs_y_memoria_risc_v`, `microarquitectura_ciclo_simple`.

Prosa reescrita: 15 menciones en 7 paginas de `temas/` que afirmaban un reparto 1P/2P vigente,
separadas en rotulo historico vs. parcial unico vigente.

`index.md` reagrupado bajo una unica seccion de parcial (sin seccion 2P), con aviso de cambio
de esquema arriba de todo y nota de programa viejo sobre `parciales_analizados/`. `CLAUDE.md`
actualizado (sistema de evaluacion, tabla de temas por parcial, diff de reubicaciones).

`wiki/sintesis/` esta vacio → paso de repasos, no-op.

No se modifico `raw/`, `parciales_analizados/`, `transcripciones/`, `apariciones_en_parciales:`
ni las banderas 🔴/⚪.


## 2026-08-18 mantenimiento | index desactualizado

- `index.md` marcaba 6 guias como "Fase 1 completa — PENDIENTE resolucion" cuando ya estaban resueltas (13/10/13/8/9/11 resoluciones respectivamente, 0 marcadores pendientes). Etiquetas corregidas a "resuelta".

## 2026-08-18 mantenimiento | hygiene

- Creado `wiki/sintesis/` (el log de init lo daba por creado pero no existia).
- CLAUDE.md: tabla de comandos completa (15).
- Verificacion de links: 0 rotos.

## 2026-04-19 resolver | programacion_risc_v_guia_pt2.md

- Ejercicios resueltos: 11 (Ej 1–11, todos los pendientes)
- Ej 1: codigo corregido para 6 incisos de debugging de convencion (A usa s-reg sin preservar, B pasa args incorrectos, B no recarga caller-saved entre llamadas)
- Ej 2: implementaciones completas — mult (suma iterada + flag signo), fib_iter (dos acumuladores), mayor en R2 (funcion hoja), div (restas iteradas + flag signo)
- Ej 4: tabla completa de obligaciones/garantias caller/callee con justificacion
- Ej 3: codigo corregido incisos a/b + seguimiento de stack con tabla de offsets
- Ej 5a: Inv (funcion hoja sub), InvertirArreglo (lw→jal Inv→sw, s-regs para ptr/cnt)
- Ej 5b: EsPotenciaDeDos (truco x&(x-1)==0 + blez), PotenciasEnArreglo (lbu + jal + acum)
- Ej 5c: EvaluarMonomio (x^p iterativo + mul), EvaluarPolinomio (mantener x^i en s4)
- Ej 6: codigo corregido 3 incisos — mod tail-recursive, fib con s0/s1 para 2 resultados parciales, suma con s0 para preservar n
- Ej 7: analisis de profundidad del stack — recursivo O(n), iterativo O(1); tabla de bytes por implementacion
- Ej 8a: factorial recursivo (una llamada, mul post-jal)
- Ej 8b: EsPar + Collatz (jalr EsPar, srai para par, 3n+1 para impar)
- Ej 8c: F3 con 3 casos base, 3 llamadas recursivas, s0=x s1=acumulador parcial
- Ej 8d: FN generalizado con loop i=1..n, s3=indice, s2=acumulador
- Ej 8e: biseccion con jalr para llamar funcion por puntero, deteccion de mitad por XOR de signos
- Ej 9: sumaNotasIDImpar — lhu ID + centinela + andi paridad + lbu nota en offset +2, avance de 3 bytes
- Ej 10: sumaLista — lw valor en +0, lw siguiente en +4, loop hasta puntero nulo
- Ej 11: binSearch_rec (4 args: ptr_struct/valor/left/right, slli+lhu para half) + binSearch_iter (loop con t-regs)

## 2026-04-19 tipos_ejercicio | paso 9 del pipeline

- Patrones identificados: 14 (9 del 1P, 5 del 2P)
- Paginas wiki/tipos_ejercicio/ creadas: 14
  - 1P: rangos_representacion_numerica, carry_y_overflow, flags_alu_cvzn, operadores_universales_nand_nor, circuito_con_compuerta_especifica, sdp_y_simplificacion, registro_bidireccional_tristate, registro_desplazamiento_mux, tabla_estados_flip_flop
  - 2P: funcion_recursiva_risc_v, convencion_llamada_risc_v, iteracion_arreglo_risc_v, structs_y_memoria_risc_v, microarquitectura_ciclo_simple
- Banderas actualizadas: ~25 ejercicios en 6 archivos _guia.md (representacion_de_informacion, logica_combinatoria, logica_secuencial, programacion_risc_v_guia, programacion_risc_v_guia_pt2, arquitectura_cpu_guia)
- index.md actualizado: seccion "Tipos de ejercicio" completa con 14 entradas por parcial

## 2026-04-18 resolver | representacion_de_informacion_guia.md

- Ejercicios resueltos: 13 (Ej 1–13, todos con pendiente)
- Ej 1: conversiones entre bases — metodo del cociente, decimal, agrupacion de bits, hex↔decimal
- Ej 2: sumas de precision fija — 5 casos con calculo y deteccion de carry
- Ej 3: el carry es siempre 0 o 1 en cualquier base — demostracion por maximo de suma de digitos
- Ej 4: interpretar 10111111, 10000000, 11111111 en C2 y S+M — casos criticos -128 y -0
- Ej 5: codificar 0, -1, 255, -128, 128 en varias precisiones y representaciones
- Ej 6: C2 tiene -2^(k-1) que S+M no puede; S+M no tiene valores fuera del rango de C2
- Ej 7: overflow en las 5 sumas del Ej 2 interpretadas en C2 — solo la 3ra tiene overflow
- Ej 8: reordenar 6 sumandos hex para evitar overflow transitorio — estrategia intercalar +/-
- Ej 9: 8 pares C2 de 4 bits cubriendo todas las combinaciones de carry/overflow/signo
- Ej 10: demostracion algebraica que SignExt_n preserva el valor en C2 (caso pos y neg)
- Ej 11: inverso aditivo en C2 — NOT(x)=-x-1; -x=NOT(x)+1; caso especial -2^(k-1)
- Ej 12: imposible biyeccion con cero + simetria positivos/negativos — 2^k par, 2m+1 impar
- Ej 13: sistema biyectivo sin cero — tabla k=3: magnitud+1 con signo MSB

## 2026-04-18 resolver | programacion_risc_v_guia.md

- Ejercicios resueltos: 8 (Ej 8–15, todos con pendiente)
- Ej 8: .text vs .data — definicion, mapa de memoria, directivas de ensamblador
- Ej 9: suma de 4 bytes de un registro — patron srli + andi 0xFF x4, verificacion con ejemplo 0x901A0002
- Ej 10: sll sin instruccion sll — pseudocodigo + loop con add t0,t0,t0; solo t0 y t1
- Ej 11: maximo de arreglo — inicializar max=Arreglo[0], loop con bge para no_update
- Ej 12: copiar vector con dos punteros en sinconia — loop lw+sw+addi x2+decremento
- Ej 13: copiar pares (0 si impar) — andi elem,1 para paridad, branch impar/par, sw zero en impar
- Ej 14: sumar64 — carga mitades, add lo, sltu para carry, add hi+carry, store
- Ej 15: sumaVector64 — acumulador 64-bit en t3/t4, loop con logica sumar64 inlineada, offset 8 bytes

## 2026-04-18 resolver | logica_secuencial_guia.md

- Ejercicios resueltos: 9 (Ej 11–19, todos con pendiente)
- Ej 11: diagrama temporal — reconstruccion del circuito, trazado de oscilacion con periodo 40 ns, analisis de estabilidad con e0=0
- Ej 12: metodologia para tabla caracteristica FF-JK con SET/CLR — marcado ⚠️ (diagrama no extraible del PDF)
- Ej 13: metodologia sistematica para analisis de 3 circuitos secuenciales — marcado ⚠️ (diagramas no extraibles)
- Ej 14: registro simple 4-bit — ecuacion MUX+FF-D, comportamiento hold/load, verificacion
- Ej 15: registro bidireccional 4-bit — tristate, modos load/read/hold, tabla de modos
- Ej 16: extensor de signo 2→4 bits — MUX en salidas o2/o3 con señal ext, tabla de verificacion
- Ej 17: desplazador a izquierda 4-bit — MUX en salidas con señal shl, ejemplos numericos
- Ej 18: auto-incrementador bidireccional — ripple carry Cin=1, MUX cascadeado, tabla de modos
- Ej 19: diagrama de tiempos R0:=R0+R1 — variante buses separados y bus compartido, reglas tristate

## 2026-04-18 resolver | logica_combinatoria_guia.md

- Ejercicios resueltos: 10 (Ej 1–10, todos completos)
- Temas: equivalencias booleanas, SDP, universalidad NAND/NOR, circuitos con NOR/XOR/NAND, simplificacion algebraica, inversor k-bits, inverso aditivo C2, DEMUX, codificador, decodificador
- Nota: la pagina ya estaba completamente resuelta desde una sesion anterior; se registro la entrada faltante en el log.

## 2026-04-18 resolver | arquitectura_cpu_guia.md

- Ejercicios resueltos: 13 (Ej 1–7 + Ej 16–21)
- Sección 1: definicion de arquitectura, byte addressing/loads, arreglos 16 bits, etiquetas/offsets, traduccion C→RISC-V, tipos R/I/S/B/U/J + ensamblado/desensamblado, ciclo fetch-decode-execute con seguimiento
- Sección 2: bits de direccionamiento, arquitectura parametrica, opcode extensible (3 ejercicios de diseño de formatos)
- Notas: Ej 7 parcialmente resuelto — el seguimiento completo del Caso I y Caso II requiere verificacion manual de cada instruccion; se documento el patron y los primeros pasos. Ej 21 marcado con verificacion — el conjunto {4/255/16} en 12 bits es matematicamente imposible de satisfacer exactamente.

## 2026-04-18 ingest | resumen_sistemas_digitales.pdf

- Fuente: raw/contenido_comunidad/resumen_sistemas_digitales.pdf
- Metodo: pdftotext (69417 chars — PDF digital, LaTeX)
- Autor: Tomas Agustin Hernandez (43 paginas)
- Parcial: 1P + 2P (cubre todos los temas de la materia)
- Temas identificados: representacion_de_informacion, logica_combinatoria, logica_secuencial, fsm, hdl_system_verilog, arquitectura, programacion_risc_v, microarquitectura
- Contenido nuevo respecto a paginas existentes:
  - FSM Moore/Mealy: definicion, diferencias (Moore = salida depende solo del estado / Mealy = estado + entradas), logica de proximo estado y de salida, codificacion de estados
  - HDL / System Verilog: modulos (comportamental/estructural), asignacion bloqueante vs no bloqueante, MUX ternario, operadores de reduccion (&/|/^), manipulacion de bits ({}/[]), alta impedancia (4'bz), always_ff / always_comb, reset async vs sync, case, precedencia de operadores, full adder en SV, mux4 estructural, simulacion vs sintesis
  - Ejemplos pedagogicos complementarios: TypeScript analogias para lw/sw, position-independent code, extraccion de byte con desplazamiento+mascara, decodificacion de instruccion binaria a RISC-V, programa resta recursiva con seguimiento de PC y sp
- Paginas creadas/actualizadas:
  - wiki/temas/hdl_system_verilog.md (nueva — HDL y System Verilog completo)
  - wiki/temas/logica_secuencial_teoria.md (actualizada — seccion FSM Moore/Mealy + link a hdl_system_verilog, fuente_adicional en frontmatter)
- index.md actualizado: entrada logica_secuencial_teoria con FSM, nueva entrada hdl_system_verilog en seccion "Logica Secuencial"
- Contenido ya cubierto (no duplicado): representacion, logica combinatoria, registros, arquitectura/RISC-V, microarquitectura

## 2026-04-18 ingest | 4.prac_programacion_RISC-V.pdf

- Fuente: raw/guias_practicas/4.prac_programacion_RISC-V.pdf
- Metodo: pdftotext (14148 chars — PDF digital)
- Parcial: 2P
- Temas identificados: programacion_risc_v, convencion_llamada, recursion, estructuras
- Contenido: 11 ejercicios en cuatro secciones — (1) Convencion de llamada (Ej 1–2, 4): debugging de funciones con errores ABI (6 incisos a-f: negacion/suma/formula/maximo/suma-acumulada/modulo), programar mult/fibonacci-iterativo/mayor-R2/division, conceptual obligaciones caller-callee; (2) Uso del stack (Ej 3): debugging con funciones auxiliares + seguimiento de stack (2 incisos: minimo-tres-valores, verificar-rango); (3) Programacion con ABI (Ej 5): Inv+InvertirArreglo, EsPotenciaDeDos+PotenciasEnArreglo (truco x&(x-1)==0), EvaluarMonomio+EvaluarPolinomio; (4) Recursion (Ej 6–8): debugging funciones recursivas (mod/fibonacci/suma-0-a-n), conceptual bytes de stack fibonacci, programar factorial/Collatz/Fibonacci3/FibonacciN/biseccion; (5) Estructuras (Ej 9–11): InformacionAlumno (half 16-bit + byte 8-bit, centinela ID nulo, suma notas ID impar), lista enlazada (word+puntero, suma valores), ArregloOrdenado (puntero+dimension 32-bit, busqueda binaria recursiva e iterativa)
- Paginas creadas:
  - wiki/temas/programacion_risc_v_guia_pt2.md (nueva — Ej 1–11, Fase 1 completa, PENDIENTE resolucion)
- index.md actualizado: entrada programacion_risc_v_guia_pt2 en seccion "Programacion RISC-V"
- Patrones confirmados: x&(x-1)==0 para potencia de 2; tamaño struct = suma de campos (half+byte=3, word+ptr=8); recorrido lista enlazada con centinela nulo via lw offset+4; busqueda binaria acceso half con slli+add+lhu; convencion de llamada errores tipicos (s-regs sin preservar, resultado en reg incorrecto, args en reg incorrecto, caller-saved no recargados)

## 2026-04-18 ingest | 3.prac_arquitectura_cpu.pdf

- Fuente: raw/guias_practicas/3.prac_arquitectura_cpu.pdf
- Metodo: pdftotext (12021 chars — PDF digital)
- Parcial: 2P
- Temas identificados: arquitectura_cpu, programacion_risc_v
- Contenido: 21 ejercicios en tres secciones — (1) Ensamblado/compilacion/seguimiento (Ej 1–7): definicion de arquitectura, byte addressing + loads tipados (lw/lh/lb/lhu/lbu), arreglos de enteros 16-bit en memoria + indexado, etiquetas y offsets de PC para branches/jumps, traduccion C→RISC-V con extensiones de signo y constantes 32-bit, tipos de instruccion R/I/S/B/U/J con ensamblado y desensamblado, seguimiento ciclo fetch-decode-execute con vuelcos de memoria reales; (2) Programacion RISC-V (Ej 8–15): .text/.data, extraer y sumar 4 bytes de un registro, implementar sll sin sll, maximo de arreglo, copiar vector, copiar elementos pares, sumar64 con carry propagado, sumaVector64; (3) Otras arquitecturas opcional (Ej 16–21): bits de direccionamiento segun tamaño/unidad de memoria, formato de instruccion parametrico, instrucciones de 1-dir con opcode expandible, opcode extensible 36-bit (7/500/50 instrucciones), opcode extensible 12-bit con registros (4/255/16)
- Paginas creadas:
  - wiki/temas/arquitectura_cpu_guia.md (nueva — Ej 1–7 + Ej 16–21, Fase 1 completa, PENDIENTE resolucion)
  - wiki/temas/programacion_risc_v_guia.md (nueva — Ej 8–15, Fase 1 completa, PENDIENTE resolucion)
- index.md actualizado: entradas arquitectura_cpu_guia y programacion_risc_v_guia en seccion "Programacion RISC-V"
- Patrones confirmados: byte addressing little-endian con loads tipados; indexado 2-byte = `slli+add+lh`; offsets B-type relativos al PC (no dependen de dir de inicio); `lui+addi` para constantes 32-bit (compensar signo si bit[11]=1); distincion instruccion vs pseudoinstruccion; paridad sin REM = `andi 0x1`; carry en suma 64-bit via `sltu` (comparar resultado con operando)

## 2026-04-18 ingest | 2.prac_logica_digital_parte_2.pdf

- Fuente: raw/guias_practicas/2.prac_logica_digital_parte_2.pdf
- Metodo: claude vision (287 chars pdftotext → fotografiado), 2 paginas
- Parcial: 1P
- Temas identificados: logica_combinatoria, logica_secuencial
- Contenido: diagramas de circuitos resueltos para Ej 4 (incisos a, b, c — circuito NOR+NOT y original evaluados; incisos b y c con vectores de prueba), Ej 5 (G(D,E,F) evaluado D=1,E=0,F=1 → G=0), Ej 6 (inversor 3-bits: 3 XOR con control compartido, confirmado control=1 → inversion bitwise), Ej 8 (DEMUX 4 salidas: 2 NOT + 4 AND, c1=1,c2=1,e=1 → s3=1), Ej 9 (codificador 4→2 basico: 2 OR — $s_1=e_2+e_3$, $s_0=e_1+e_3$; con validez: circuito extendido), Ej 10 (decodificador 2→4: 2 NOT + 4 AND, e1=1,e0=1 → s3=1), Ej 14 (registro simple: 4 MUX+FF-D, LOAD=1, i=[1,1,0,0] → o=[1,1,0,0])
- Paginas actualizadas:
  - wiki/temas/logica_combinatoria_guia.md (actualizada — frontmatter con fuentes duales, notas de diagrama disponible en Ej 4/5/6/8/9/10)
  - wiki/temas/logica_secuencial_guia.md (actualizada — frontmatter con fuentes duales, nota de diagrama disponible en Ej 14)
- index.md actualizado: entradas logica_combinatoria_guia y logica_secuencial_guia reflejan Partes 1+2
- Patrones confirmados visualmente: inversor k-bits = k XOR con control; codificador 4→2 = 2 OR ($s_1=e_2+e_3$, $s_0=e_1+e_3$); decodificador 2→4 = 2 NOT + 4 AND; DEMUX = NOT-del-control + AND-por-salida; registro simple = MUX+FF-D por bit con LOAD compartido

## 2026-04-18 ingest | 2.prac_logica_digital_parte_1.pdf

- Fuente: raw/guias_practicas/2.prac_logica_digital_parte_1.pdf
- Metodo: pdftotext (9031 chars — PDF digital)
- Parcial: 1P
- Temas identificados: logica_combinatoria, logica_secuencial
- Contenido: 19 ejercicios en dos secciones — Circuitos Combinatorios (Ej 1–10) y Circuitos Secuenciales (Ej 11–19). Temas combinatorios: equivalencias booleanas, expresabilidad con OR/AND/NOT, universalidad NAND/NOR, circuitos NOR/NAND/XOR compuestos, SDP desde tabla de verdad con simplificacion, inversor k-bits (XOR con control), inverso aditivo C2 con deteccion overflow, DEMUX 4 salidas, codificador 4→2 con validez, decodificador 2→4 + DEMUX via decodificador. Temas secuenciales: diagrama temporal con retardos y posible oscilacion, tabla caracteristica FF-JK con SET/CLR, tablas caracteristicas de tres circuitos (FF-D y FF-JK), registro simple 4-bit (WE+clk), registro bidireccional tristate, extensor de signo 2→4 bits, desplazador izquierda (shl), auto-incrementador (load+read+inc), diagrama de tiempos R0:=R0+R1 con bus.
- Paginas creadas:
  - wiki/temas/logica_combinatoria_guia.md (nueva — Fase 1 completa, Ej 1–10 con enunciado + explicacion; Resolucion y Chuleta PENDIENTE)
  - wiki/temas/logica_secuencial_guia.md (nueva — Fase 1 completa, Ej 11–19 con enunciado + explicacion; Resolucion y Chuleta PENDIENTE)
- index.md actualizado: entradas logica_combinatoria_guia y logica_secuencial_guia en sus secciones
- Banderas parciales asignadas: Ej1 (equivalencias algebraicas), Ej2 (universalidad), Ej3 (NAND/NOR), Ej4 (circuito NOR), Ej5 (SDP+simplificacion), Ej7 (inverso aditivo C2) marcados 🔴 Si en combinatoria; Ej15 (registro bidireccional tristate), Ej16 (extensor de signo), Ej17 (desplazador/shift) marcados 🔴 Si en secuencial

## 2026-04-18 ingest | 1.prac_representacion_de_informacion.pdf

- Fuente: raw/guias_practicas/1.prac_representacion_de_informacion.pdf
- Metodo: pdftotext (4762 chars — PDF digital)
- Parcial: 1P
- Temas identificados: representacion_de_informacion
- Contenido: 13 ejercicios — conversion entre bases (metodo cociente, agrupacion bits, bases 2/3/5/8/16), sumas de precision fija con acarreo (binario y hex), acarreo conceptual en cualquier base, interpretacion de binarios 8-bit en C2 y S+M, codificacion de numeros en distintas representaciones y precisiones, comparacion de rangos C2 vs S+M, overflow en sumas C2, reordenamiento de suma para evitar overflow acumulado, pares con combinaciones de carry/overflow/resultado (8 casos), demostracion de SignExtn, inverso aditivo en C2 (inv bits + 1), biyectividad de sistemas de representacion (V/F — verdadera por paridad de 2^k), sistema biyectivo sin cero
- Paginas creadas:
  - wiki/temas/representacion_de_informacion_guia.md (nueva — Fase 1 completa, 13 ejercicios con enunciado + explicacion; Resolucion y Chuleta PENDIENTE)
- index.md actualizado: entrada representacion_de_informacion_guia en seccion "Representacion de la Informacion"
- Banderas parciales asignadas: Ej2 (carry), Ej4 (interpretar C2/S+M), Ej5 (codificar), Ej6 (rangos), Ej7 (overflow), Ej8 (overflow acumulado), Ej9 (flags ALU), Ej11 (inverso aditivo) marcados 🔴 Si con links a parciales_analizados relevantes

## 2026-04-18 ingest | 5.teo_microarquitectura.pdf

- Fuente: raw/clases_teoricas/5.teo_microarquitectura.pdf
- Metodo: pdftotext (12735 chars — PDF digital, Beamer con texto extraible)
- Paginas: 62 (slides Beamer, 1C 2025)
- Parcial: 2P
- Temas identificados: microarquitectura
- Contenido: definicion de microarquitectura (entre arquitectura e implementacion fisica), estado arquitectonico (registros + PC) vs estado interno no expuesto, instrucciones evaluadas (add/sub/and/or/slt; lw/sw; beq), diseno datapath-primero luego unidad-de-control, elementos de memoria (PC, memoria de instrucciones, archivo de registros 32 regs con 2 puertos lectura + 1 escritura WE3, memoria de datos WE), procesador de ciclo simple (duracion = operacion mas costosa), ejecucion de lw (fetch→base A1→ext signo→ALU suma→mem datos→WD3→PC+4), ejecucion de sw (igual lw pero A2=RD2→WD de mem, WE=1), tipo R (MUX SrcB para ALUSrc, MUX Result para ResultSrc, ALUControl), senales de control completas (RegWrite/ImmSrc 2-bit/ALUSrc/ALUControl/MemWrite/ResultSrc), instruccion beq (desplazamiento 13-bit en 12, ImmSrc 2-bit para B-type, MUX PCNext, PCSrc=Branch AND Z), unidad de control desacoplada (controlador segun opcode→ALUOp, decodificador segun funct3/funct7→ALUControl, AND para PCSrc), soporte addi con una linea extra en controlador
- Paginas creadas:
  - wiki/temas/microarquitectura_teoria.md (nueva)
- index.md actualizado: entrada microarquitectura_teoria completada en seccion "Microarquitectura"
- Patrones nuevos detectados: PCSrc = Branch AND Z (compuerta AND externa a la UC), ImmSrc 2-bit distingue I/S/B para extensor de signo, ALUOp=00→suma/01→resta/10→decodificador, ResultSrc=1 significa leer de memoria (lw), MUX SrcB en 0=RD2 (tipo R) / 1=inmediato extendido (tipo I/S/B)

## 2026-04-18 ingest | 4.teo_arquitectura_parte_2.pdf

- Fuente: raw/clases_teoricas/4.teo_arquitectura_parte_2.pdf
- Metodo: pdftotext (18169 chars — PDF digital, Beamer con texto extraible)
- Paginas: 74 (slides Beamer, 1C 2025)
- Parcial: 2P
- Temas identificados: arquitectura, programacion_risc_v
- Contenido: byte addressing y word address (LSB = dir menor, avance de 4 entre palabras), acceso a arreglos (dir = base + 4*i, patron slli+add+lw/sw), ejemplo sumar_arreglo C→RISC-V, interfaz binaria de aplicacion (ABI): contrato de llamada a funcion (argumentos en a0–a7, retorno en a0, ra guarda PC+4 con jal), preservacion de registros (caller-saved: t0–t6/a0–a7; callee-saved: s0–s11/ra), uso de la pila (stack crece hacia abajo, sp alineado a 16 bytes, push=addi sp -16+sw, pop=lw+addi sp +16), stack frame por llamada recursiva, ejemplo factorial recursivo completo, pseudoinstrucciones (li/mv/j/ret/nop y su expansion real), recomendacion de uso de documentacion durante practica
- Paginas creadas:
  - wiki/temas/arquitectura_teoria_pt2.md (nueva)
- index.md actualizado: entrada arquitectura_teoria_pt2 completada en seccion "Arquitectura de Computadoras"
- Patrones nuevos detectados: slli rd,rs,2 = dir base + i*4 (acceso arreglo), ABI = contrato caller/callee con a0–a7 y ra, caller guarda t/a antes de jal; callee guarda s/ra al inicio y restaura antes de ret, sp siempre multiplo de 16, recursion necesita push a0+ra al inicio y pop+mul al retornar, pseudoinstrucciones encapsulan patrones frecuentes sin ampliar el ISA

## 2026-04-18 ingest | 4.teo_arquitectura_parte_1.pdf

- Fuente: raw/clases_teoricas/4.teo_arquitectura_parte_1.pdf
- Metodo: pdftotext (44021 chars — PDF digital, Beamer con texto extraible)
- Paginas: 160 (slides Beamer, 1C 2025)
- Parcial: 2P
- Temas identificados: arquitectura, programacion_risc_v
- Contenido: definicion de arquitectura (instrucciones+registros+memoria, no es la implementacion fisica), cadena de compilacion (compilador→ensamblador→enlazador→binario), RISC-V: 32 registros (zero/t0-t6/s0-s11/a0-a7/ra), instrucciones aritmeticas (add/sub/addi), inmediatos 12-bit con signo (extension de signo), cargar constante 32-bit con lui+addi (compensacion parte baja negativa), instrucciones logicas (and/or/xor y variantes con i), instrucciones de desplazamiento (sll/srl/sra y variantes con i), acceso a memoria (lw/sw con base+offset, byte-addressed, palabra=4 bytes), programa almacenado en memoria, ciclo fetch-decode-execute con PC, control de flujo (beq/bne/blt/bge/bltu/bgeu + etiquetas, j/jal/jalr/ret), tipos de instruccion maquina (R/I/S/B/U/J con campos y codificacion binaria), mapa de memoria (I/O / stack / heap / .data / .text), directivas de ensamblado (.word/.byte/.section/.global)
- Paginas creadas:
  - wiki/temas/arquitectura_teoria_pt1.md (nueva)
- index.md actualizado: entrada en seccion "Arquitectura de Computadoras"
- Patrones nuevos detectados: lui+addi para constante 32-bit (compensar extension signo parte baja: sumar 1 a lui si bit[11]=1), slli rd,rs,k = multiplicar por 2^k (patron frecuente en indexado de arreglos), xori rd,rs,-1 = NOT bitwise, extraer byte N = srli+andi 0xFF, ciclo fetch-decode-execute con PC+=4, jal guarda PC+4 en rd (mecanismo de llamada a funcion), tipos R/I/S/B/U/J determinan formato de codificacion binaria

## 2026-04-18 ingest | 3.teo_logica_secuencial.pdf

- Fuente: raw/clases_teoricas/3.teo_logica_secuencial.pdf
- Metodo: pdftotext (23902 chars — PDF digital, Beamer con texto extraible)
- Paginas: 83 (slides Beamer, 1C 2025)
- Parcial: 1P
- Temas identificados: logica_secuencial
- Contenido: circuitos combinatorios vs secuenciales (retroalimentacion), latches (RS-NOR, JK, D) con tablas de verdad y problemas de nivel/oscilacion/carreras, sincronizacion con clock, detector de flanco, flip-flops (FF-D y FF-JK con tablas de verdad y notacion T/T+1), registro N-bit con WriteEnable (FF-D + MUX), componentes tristate (Hi-Z para bus compartido), intro a memorias (M posiciones × N bits), ejercicios de clase (registro 3-bit con WE+tristate+bidireccional, bus de n registros con secuencia de copia R1→R0)
- Paginas creadas:
  - wiki/temas/logica_secuencial_teoria.md (nueva)
- index.md actualizado: entrada en seccion "Logica Secuencial"
- Patrones nuevos detectados: FF-D como celda basica de registro (WE con MUX realimenta Q cuando WE=0), tristate = aislacion electrica para bus compartido (solo un EnableOut activo a la vez), copia de registro requiere EnableOut-src + WriteEnable-dst + flanco de clock (3 pasos), FF-JK toggle (J=K=1) niega Q cada ciclo sin oscilacion por ser edge-triggered

## 2026-04-18 ingest | 2.teo_logica_combinatoria.pdf

- Fuente: raw/clases_teoricas/2.teo_logica_combinatoria.pdf
- Metodo: pdftotext (21966 chars — PDF digital, Beamer con texto extraible)
- Paginas: 93 (slides Beamer, 1C 2025)
- Parcial: 1P
- Temas identificados: logica_combinatoria
- Contenido: algebra de Boole (axiomas A1-A5, propiedades: identidad/nulo/idempotencia/inverso/conmutatividad/asociatividad/distributividad/absorcion/De Morgan), notacion OR/AND/NOT, compuertas basicas con tablas de verdad y SystemVerilog (NOT/AND/OR/XOR), caja blanca/caja negra entradas/salidas datos-vs-control (ALU 74181), mecanismo SDP (suma de productos / minterminos), circuitos estandar: half adder (Sum=XOR, Carry=AND), full adder (2 HAs + OR), shift LR k-bits con MUX, multiplexor/demultiplexor, codificador/decodificador, timing y latencia (camino critico, demora por capa)
- Paginas creadas:
  - wiki/temas/logica_combinatoria_teoria.md (nueva)
- index.md actualizado: entrada en seccion "Logica Combinatoria"
- Patrones nuevos detectados: SDP es mecanismo universal (cualquier funcion booleana es realizable con AND+OR+NOT), latencia = profundidad_capas × demora_por_compuerta, full adder = 2 half adders + OR, shift LR implementado con MUX controlado por bit de direccion

## 2026-04-18 ingest | 1.parcial_2C_2024_recuperatorio.pdf

- Fuente: raw/parciales/1P/1.parcial_2C_2024_recuperatorio.pdf
- Metodo: claude vision (5 chars pdftotext → fotografiado), 4 paginas
- Instancia: Recuperatorio del Primer Parcial 2C 2024
- Alumno: Giorgi Palazzini, Tomás Agustín (LU 795/23) — Nota: 10/10
- Temas identificados: representacion_de_informacion, logica_combinatoria, logica_secuencial
- Ejercicios: Ej1 rangos S+M 8-bit con 2do MSB=0 (±63) + C2 negativos (-128..−1) + suma -21+(-14) en C2 (−35, representable) + suma -128+(-1) (overflow, NEG+NEG=POS) + condicion paridad (LSB iguales) y negativo-sin-overflow; Ej2 universalidad NAND/NOR formulada como V/F (afirmacion 2 falsa — NOR sí representable con NAND); Ej3.1 (A+B)·C con 3 NAND via distribucion AC+BC, Ej3.2 XNOR A·B+Ā·B̄ tabla directa (respuesta incompleta: lista solo A=0,B=1, corrector no descuenta); Ej4 registro desplazamiento 4-bit bidireccional con demora: 4 MUX (selector=RIGHT/LEFT) + 4 FF-D, extremos rellenados con constante 0
- Paginas creadas:
  - wiki/transcripciones/1P_2C_2024_rec_raw.md (nueva)
  - wiki/parciales_analizados/1P_2C_2024_recuperatorio.md (nueva — analisis completo con chuletas por ejercicio y comparacion con parcial regular)
- index.md actualizado: entrada 1P_2C_2024_recuperatorio agregada en seccion "Parciales analizados"
- Patrones nuevos detectados: S+M con bit fijo reduce rango a ±(2^(k-2)-1), condicion paridad suma C2 (LSB iguales), (A+B)C con NAND via distribucion → NAND-de-NAND, registro desplazamiento bidireccional con MUX+FF-D, Ej2 tipo V/F (trampa: afirmacion negativa "no es posible X" suele ser falsa)

## 2026-04-18 ingest | 1.parcial_2C_2024_resolucion_(2).pdf

- Fuente: raw/parciales/1P/1.parcial_2C_2024_resolucion_(2).pdf
- Metodo: claude vision (6 chars pdftotext → fotografiado), 6 paginas
- Instancia: Primer Parcial 2C 2024 (segunda resolucion)
- Alumno: Kruel, Magali (LU 1257/23) — Nota: 9.5
- Temas identificados: representacion_de_informacion, logica_combinatoria, logica_secuencial
- Ejercicios: Ej1 rangos S+M/C2 + inverso aditivo via inv(n-1) + carry conceptual + overflow C2 tabla signos, Ej2 universalidad NAND/NOR por derivacion algebraica (idempotencia+De Morgan+identidad), Ej3.1 circuito correcto sin justificacion algebraica (-0.5), Ej3.2 tabla de verdad + NOR pero sin respuesta textual explicita (corrector lo nota en rojo pero no descuenta), Ej4 diseno modular: reg-bd-simple (1 bit) compuesto x4
- Paginas creadas/actualizadas:
  - wiki/transcripciones/1P_2C_2024_res2_raw.md (nueva)
  - wiki/parciales_analizados/1P_2C_2024.md (actualizada — estado: completo, 2 resoluciones, secciones de comparacion por ejercicio agregadas)
- index.md actualizado: entrada 1P_2C_2024 indica "2 resoluciones incorporadas"
- Patrones nuevos detectados: formula inverso aditivo alternativa inv(n-1)=NOT(n-1) equivalente a NOT(n)+1, representacion de overflow C2 por tabla de signos (sin formula algebraica), diseno modular de circuitos con componente nombrado reutilizable, importancia de incluir respuesta textual explicita al enunciado (no solo derivacion algebraica)

## 2026-04-18 ingest | 1.parcial_2C_2024_resolucion_(1).pdf

- Fuente: raw/parciales/1P/1.parcial_2C_2024_resolucion_(1).pdf
- Metodo: claude vision (6 chars pdftotext → fotografiado), 6 paginas
- Instancia: Primer Parcial 2C 2024
- Alumno: Manzotti, Mauro — Nota: 10
- Temas identificados: representacion_de_informacion, logica_combinatoria, logica_secuencial
- Ejercicios: Ej1 rangos S+M 4-bit/C2 8-bit + inverso aditivo C2 + carry/overflow (formula incorrecta de overflow tachada por corrector), Ej2 demostrar universalidad NAND y NOR, Ej3 circuito A·B·C con 2 NOR + NOTs / simplificacion f(A,B) a NOR(A,B), Ej4 registro bidireccional 4-bit con tristate
- Paginas creadas:
  - wiki/transcripciones/1P_2C_2024_res1_raw.md (nueva)
  - wiki/parciales_analizados/1P_2C_2024.md (nueva — resolucion_(1) incorporada; resolucion_(2) pendiente proxima iteracion)
- index.md actualizado: entrada 1P_2C_2024 agregada en seccion "Parciales analizados"
- Patrones nuevos detectados: registro bidireccional con tristate (patron logica secuencial), demostración de universalidad NAND/NOR por construcción AND+OR+NOT, simplificacion A(B+B̄)=A para colapsar expresiones complejas, overflow C2 = mismo signo entradas / signo opuesto resultado (formula V=Ck⊕C_{k-1})

## 2026-04-18 ingest | 1.parcial_1C_2025_resolucion.pdf

- Fuente: raw/parciales/1P/1.parcial_1C_2025_resolucion.pdf
- Metodo: claude vision (102 chars pdftotext → fotografiado), 4 paginas
- Instancia: Primer Parcial 1C 2025
- Alumno: ITTIG, Ernesto (LU 685/24) — Nota: 9
- Temas identificados: representacion_de_informacion, logica_combinatoria, logica_secuencial
- Ejercicios: Ej1 truncado hex (E8/7B/5C) + tabla sin signo/CA2 + flags ALU 4-bit (CVZN), Ej2 SDP F(A,B,C) + simplificacion algebraica hasta NOR+AND+OR (3 compuertas), Ej3 flip-flops D en registro desplazamiento circular (periodo 3)
- Paginas creadas:
  - wiki/transcripciones/1P_1C_2025_raw.md (nueva)
  - wiki/parciales_analizados/1P_1C_2025.md (nueva — analisis completo con chuletas por ejercicio)
- index.md actualizado: entrada 1P_1C_2025 agregada en seccion "Parciales analizados"
- Patrones nuevos detectados: truncado como tecnica de cambio de representacion, flag C en resta = NOT carry (borrow), simplificacion SDP con De Morgan directo a NOR, registro desplazamiento circular 3-bit

## 2026-04-18 ingest | 1.teo_representacion_de_informacion.pdf

- Fuente: raw/clases_teoricas/1.teo_representacion_de_informacion.pdf
- Metodo: pdftotext (22955 chars — PDF digital, Beamer con texto extraible)
- Paginas: 64 (slides Beamer, 1C 2025)
- Parcial: 1P
- Temas identificados: representacion_de_informacion
- Contenido: sistemas de representacion (finito/composicional/posicional), bases numericas, teorema de la division para cambio de base, representacion finita y rango, overflow, tipos numericos (sin signo, signo+magnitud, exceso m, complemento a 2), extension de bits, operaciones logicas (OR/AND/XOR/NOT), desplazamientos (izquierda, logico derecha, aritmetico derecha), adicion binaria con carry, resta con borrow, deteccion de overflow en C2
- Paginas creadas:
  - wiki/temas/representacion_de_informacion_teoria.md (nueva)
- index.md actualizado: entrada en seccion "Representacion de la Informacion"

## 2026-04-18 ingest | 2.parcial_2C_2024_resolucion_recuperatorio.pdf

- Fuente: raw/parciales/2P/2.parcial_2C_2024_resolucion_recuperatorio.pdf
- Metodo: claude vision (6 chars pdftotext → fotografiado), 6 paginas
- Instancia: Segundo Recuperatorio 2C 2024
- Temas identificados: programacion_risc_v, arquitectura, microarquitectura
- Ejercicios: Ej1 es_primo + cantidad_divisores (recursion mutua 3 funciones), Ej2 es_par + arreglo_par (paridad sin REM), Ej3 struct BalanceDeudor + contarDeudores (mismo struct que 2P_2C_2024), Ej4 microarquitectura ResultSrc y bits rs2
- Paginas creadas:
  - wiki/transcripciones/2P_2C_2024_rec_raw.md (nueva)
  - wiki/parciales_analizados/2P_2C_2024_recuperatorio.md (nueva — analisis completo con chuletas por ejercicio)
- index.md actualizado: entrada 2P_2C_2024_recuperatorio agregada en seccion "Parciales analizados"
- Patrones nuevos detectados: recursion mutua con 3 funciones, paridad sin REM (ANDI+XORI), arreglo_par post-order, ResultSrc=1 en instruccion tipo R (efecto de mux incorrecto)

## 2026-04-18 ingest | 2.parcial_2C_2024_resolucion.pdf

- Fuente: raw/parciales/2P/2.parcial_2C_2024_resolucion.pdf
- Metodo: claude vision (9 chars pdftotext → fotografiado)
- Nota visible en el parcial: 10/10
- Temas identificados: programacion_risc_v, arquitectura, microarquitectura
- Ejercicios: Ej1 triangulo de Pascal recursivo (RISC-V), Ej2 inv + invertirArreglo, Ej3 struct BalanceDeudor + contarDeudores, Ej4 microarquitectura ciclo simple instruccion `or`
- Paginas creadas:
  - wiki/transcripciones/2P_2C_2024_res_raw.md (nueva)
  - wiki/parciales_analizados/2P_2C_2024.md (nueva — analisis completo con chuletas por ejercicio)
- index.md actualizado: entrada 2P_2C_2024 agregada en seccion "Parciales analizados"
- Patrones nuevos detectados: acceso a struct por offset con lbu/lh, arreglo terminado en centinela ID nulo, instruccion tipo R en microarquitectura ciclo simple

## 2026-04-18 ingest | 2.parcial_1C_2025_resolucion_(2).pdf

- Fuente: raw/parciales/2P/2.parcial_1C_2025_resolucion_(2).pdf
- Metodo: claude vision (65 chars pdftotext → fotografiado)
- Temas identificados: programacion_risc_v, arquitectura, microarquitectura
- Paginas creadas/actualizadas:
  - wiki/transcripciones/2P_1C_2025_res2_raw.md (nueva)
  - wiki/parciales_analizados/2P_1C_2025.md (actualizada — estado: completo, secciones de comparacion por ejercicio agregadas)
- index.md actualizado: entrada de 2P_1C_2025 indica "2 resoluciones incorporadas"
- Diferencias clave documentadas: slli vs mul*2 en Ej1, funcion vs programa plano en Ej2, estilo conceptual vs tecnico en Ej3

## 2026-04-18 ingest | 2.parcial_1C_2025_resolucion_(1).pdf

- Fuente: raw/parciales/2P/2.parcial_1C_2025_resolucion_(1).pdf
- Metodo: claude vision (5 chars pdftotext → fotografiado)
- Temas identificados: programacion_risc_v, arquitectura, microarquitectura
- Paginas creadas:
  - wiki/transcripciones/2P_1C_2025_res1_raw.md
  - wiki/parciales_analizados/2P_1C_2025.md (parcial — incorporar res_(2) proxima iteracion)
- index.md actualizado: seccion "Parciales analizados"

## [2026-04-18] init | onboarding
- Estrategia: practica_parciales
- Total PDFs detectados: 20
  - parciales/1P/: 4 PDFs (fotografiados, vision)
  - parciales/2P/: 4 PDFs (fotografiados, vision)
  - clases_teoricas/: 6 PDFs (slides Beamer fotografiadas, vision)
  - guias_practicas/: 5 PDFs
  - contenido_comunidad/: 1 PDF (pdftotext)
- Estructura de carpetas creada: raw/, wiki/{temas,tipos_ejercicio,parciales_analizados,transcripciones,sintesis}
- CLAUDE.md, index.md, log.md generados
- Nota: explore-raw previo omitio guias_practicas/ y parciales/1P/ — inventario corregido con datos reales del filesystem

## 2026-08-30 analisis | teo-03-secuenciales.pdf
Material de estudio: `cursada_actual/teo_03_secuenciales.md` — 6 unidades explicadas (0 criticas, 6 probables), 2 patrones no cubiertos. Sin ingesta.
