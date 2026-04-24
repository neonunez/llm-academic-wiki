---
nombre: Recuperatorio 2P 2C 2024 — Analisis
parcial: 2P
cuatrimestre: 2C
año: 2024
instancia: recuperatorio
tipo_pdf: fotografiado
fuente: raw/parciales/2P/2.parcial_2C_2024_resolucion_recuperatorio.pdf
transcripcion: "[[transcripciones/2P_2C_2024_rec_raw]]"
temas_evaluados:
  - programacion_risc_v
  - arquitectura
  - microarquitectura
puntaje_maximo: 10
puntaje_por_ejercicio:
  ej1: 2
  ej2: 2
  ej3: 4
  ej4: 2
nota_visible: ilegible
---

# 2P Recuperatorio — 2C 2024

Mismo esquema que el [[2P_2C_2024]] (parcial regular): 4 ejercicios, temas idénticos.
El recuperatorio reutiliza el mismo patrón de ejercicios que el parcial regular de 2C 2024.

---

## Ejercicio 1 — Recursividad mutua: es_primo / cantidad_divisores (2 pts.)

### Enunciado

Implementar en RISC-V las funciones C:

```c
int cantidad_divisores(int k) {
    if (k <= 1) return 1;
    return cantidad_divisores_rec(k, k-1);
}
int cantidad_divisores_rec(int k, int n) {
    if (n == 1) return 1;
    int cantidad = cantidad_divisores_rec(k, n - 1);
    if (k % n == 0) { cantidad = cantidad + 1; }
    return cantidad;
}
int es_primo(int k) {
    return cantidad_divisores(k) == 1;
}
```

Respetar la convención de llamada. Explicar en qué registros se almacenan los valores y cómo se garantiza la convención.

### Resolucion

```asm
ES_PRIMO:
    ADDI SP SP -4
    SW RA 0(SP)
    JAL CANTIDAD_DIVISORES      # a0 = k; llama cantidad_divisores(k)
    LI T0 1
    BNE A0 T0 FALSE             # si retorno != 1, no es primo
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA                       # retorna con A0 = 1

FALSE:
    LI A0 0
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA                       # retorna con A0 = 0

CANTIDAD_DIVISORES:
    ADDI SP SP -4
    SW RA 0(SP)
    LI T0 1
    BLE A0 T0 CASO_UNO          # k <= 1 → retornar 1
    ADDI A1 A0 -1               # A1 = k-1 (segundo arg para _REC)
    JAL CANTIDAD_DIVISORES_REC
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

CASO_UNO:
    LI A0 1
    LW RA 0(SP)
    ADDI SP SP 4
    JR RA

CANTIDAD_DIVISORES_REC:
    ADDI SP SP -8
    LI T0 1
    BEQ A1 T0 CASO_UNO_REC     # n == 1 → retornar 1
    SW RA 0(SP)
    SW A1 4(SP)                 # guarda n en stack
    ADDI A1 A1 -1               # A1 = n-1
    JAL CANTIDAD_DIVISORES_REC  # llamada recursiva
    LW A1 4(SP)                 # restaura n
    LW RA 0(SP)
    REM A2 A0 A1                # A2 = k % n [A0=resultado acumulado, A1=n]
    BEQ A2 ZERO CASO_CERO_REC  # si k%n == 0, sumar al contador
    ADDI SP SP 8
    JR RA

CASO_CERO_REC:
    ADDI A3 A3 1                # [posible error: debería sumar a A0]
    ADDI SP SP 8
    JR RA

CASO_UNO_REC:
    [FORMULA ILEGIBLE — ver fuente pág. 3]
```

### Explicacion

El ejercicio evalúa:
1. **Convención de llamada con recursión mutua**: `es_primo` → `cantidad_divisores` → `cantidad_divisores_rec` (recursiva)
2. **Preservación de RA**: cada función que llama a otra debe salvar RA en el stack
3. **Paso de argumentos**: k en A0, n en A1 (convención RISC-V)
4. **Instrucción REM**: para calcular el resto (k % n)

### Analisis de la resolucion

**Correcta en estructura general:** la solución guarda RA, preserva argumentos en el stack, usa BEQ/BNE para casos base, y encadena las tres funciones correctamente.

**Posible error en CASO_CERO_REC:** usa `ADDI A3 A3 1` en lugar de `ADDI A0 A0 1` para acumular el contador. A3 no es el registro de retorno convencional (A0) — esto podría ser un error de transcripción o un error conceptual del alumno.

**CASO_UNO_REC:** ilegible en el PDF — ver fuente.

### Chuleta

> 1. `es_primo`: guarda RA, llama `cantidad_divisores(k)`, compara resultado con 1 (LI + BNE), retorna 1 o 0
> 2. `cantidad_divisores`: caso base k≤1 → 1; sino prepara A1=k-1 y llama `_rec`
> 3. `cantidad_divisores_rec`: caso base n=1 → 1; sino salva {RA, n}, llama recursivamente, recupera n, calcula `REM A2 A0 A1` (k%n), si 0 suma 1 al contador
> 4. Stack frame: 4 bytes para funciones que solo salvan RA; 8 bytes para las que salvan RA + argumento

---

## Ejercicio 2 — arreglo_par: paridad con llamada a funcion (2 pts.)

### Enunciado

Implementar en RISC-V:
- `int es_par(int x) = x % 2 == 0` (chequeo de paridad)
- `void arreglo_par(int arr[], int largo)`: cambia cada elemento por 1 (si era par) o 0 (si impar), usando `es_par`

### Resolucion

```asm
ES_PAR:
    ANDI T0 A0 1        # T0 = bit 0 de x (1 si impar, 0 si par)
    XORI A0 T0 1        # A0 = NOT(bit0) → 1 si par, 0 si impar
    JR RA

ARREGLO_PAR:
    # A0 = puntero al arreglo, A1 = largo
    ADDI SP SP -8
    SW RA 0(SP)         # salva RA
    LW T0 0(A0)         # carga elemento actual
    SW T0 4(SP)         # lo guarda en stack
    ADDI A1 A1 -1       # decrementa contador
    BEQ ZERO A1 FIN_CICLO  # si largo=0, fin
    ADDI A0 A0 4        # avanza puntero al próximo elemento
    JAL ARREGLO_PAR     # llamada recursiva para el resto
    MV S0 A0            # S0 = dirección actual (al regresar, A0 apunta aquí)
    LW A0 4(SP)         # recupera elemento guardado
    JAL ES_PAR          # llama es_par con el elemento
    SW A0 0(S0)         # guarda resultado (0 o 1) en la posición
    ADDI S0 S0 -4       # retrocede puntero
    MV A0 S0
    LW RA 0(SP)
    ADDI SP SP 8
    JR RA

FIN_CICLO:
    JR RA
```

### Explicacion

El ejercicio evalúa:
1. **Trick de paridad sin REM**: usar `ANDI` con máscara 0x1 extrae el bit menos significativo; `XORI` con 1 lo invierte (par → 0→1, impar → 1→0)
2. **Patrón recursivo con caller-save**: `arreglo_par` es recursiva — primero avanza hasta el final, luego en el retorno escribe los resultados en cada posición
3. **Uso de S0 (callee-save)**: para preservar la dirección del elemento actual durante la llamada a `es_par`

### Analisis de la resolucion

**es_par:** correcta. `ANDI T0 A0 1` + `XORI A0 T0 1` es el patrón estándar para paridad sin REM.

**arreglo_par:** la lógica es correcta pero la implementación tiene un problema: usa S0 (callee-save) sin salvarlo en el stack, lo que viola la convención de llamada si el caller usa S0. El corrector marcó 2 puntos con nota "al 1er elemento deja dirección en A0" — posible penalización por ese detalle.

El patrón post-order es inusual pero válido: primero se avanza (pre-order de recursión), luego en el retorno se procesan los elementos de último a primero.

### Chuleta

> **es_par**: `ANDI T0 A0 1` → `XORI A0 T0 1` → `JR RA`
> (sin REM: bit0=1 es impar → XOR invierte: par=1, impar=0)
>
> **arreglo_par recursivo**:
> 1. Salvar RA + elemento actual en stack
> 2. Si largo==0 → fin
> 3. Avanzar puntero, decrementar largo, llamar recursivo
> 4. Al regresar: recuperar elemento, llamar es_par, escribir resultado
> 5. Restaurar RA, liberar stack

---

## Ejercicio 3 — BalanceDeudor: struct + arreglo + contarDeudores (4 pts.)

### Enunciado

Estructura `BalanceDeudor`:

| Campo      | Tipo                        | Offset | Tamaño |
|------------|-----------------------------|--------|--------|
| ID         | entero con signo 8 bits     | 0x0000 | 1 byte |
| Consumos   | entero sin signo 32 bits    | 0x0001 | 4 bytes |
| Cant_pagos | entero sin signo 16 bits    | 0x0005 | 2 bytes |
| Pagos      | entero complemento a 2, 16b | 0x0007 | 2 bytes |

Arreglo terminado en centinela (ID = 0).

**a)** ¿Cuántos bytes ocupa la estructura y un arreglo de 32 deudores?

**b)** Implementar `contarDeudores(balanceDeudores)`: cuenta estructuras donde `consumos > pagos`.

### Resolucion

**Parte a:**
- Estructura: $1 + 4 + 2 + 2 = 9$ bytes
- Arreglo de 32 deudores: $9 \times 32 + 1 = 289$ bytes (el +1 es el byte centinela con ID=0)

**Parte b:**

```asm
CONTAR_DEUDORES:
    # A0 = dirección del comienzo del arreglo
    LB T0 0(A0)              # carga ID (signed byte, offset 0)
    BEQ T0 ZERO FIN_CICLO   # ID == 0 → fin (centinela)
    ADDI SP SP -12
    SW RA 0(SP)              # salva RA
    LW T0 1(A0)              # consumos (word, offset 1)
    SW T0 4(SP)              # guarda consumos en stack
    LH T0 7(A0)              # pagos (half, offset 7)
    SH T0 8(SP)              # guarda pagos en stack
    ADDI A0 A0 9             # avanza al siguiente elemento (struct = 9 bytes)
    JAL CONTAR_DEUDORES      # llamada recursiva
    LW T0 4(SP)              # recupera consumos
    LH T1 8(SP)              # recupera pagos
    BLT T1 T0 SUMADOR        # si pagos < consumos → sumar
    LW RA 0(SP)
    ADDI SP SP 12
    JR RA

SUMADOR:
    ADDI A0 A0 1             # contador++ (A0 acumula el resultado)
    LW RA 0(SP)
    ADDI SP SP 12
    JR RA

FIN_CICLO:
    ADDI A0 ZERO 0           # base case: contador = 0
    JR RA
```

### Explicacion

El ejercicio evalúa:
1. **Layout de struct sin padding**: la cátedra usa structs compactos (sin alineación), por eso el offset de Consumos es 0x0001 (no 0x0004)
2. **Acceso por offset con instrucciones de tamaño apropiado**: `LB` para byte, `LW` para word (4 bytes), `LH` para halfword (2 bytes)
3. **Centinela de fin**: `ID == 0` marca el fin del arreglo (patrón ya visto en 2P_2C_2024 regular)
4. **Acumulador recursivo**: A0 acumula el contador en el retorno (patrón post-order)
5. **Comparación mixta**: consumos (sin signo, word) vs pagos (complemento a 2, half) — la comparación usa `BLT` (signed); atención a la extensión de signo de LH vs LW

### Analisis de la resolucion

**Correcta en estructura general.** Los offsets son precisos (LB 0, LW 1, LH 7). El uso de `ADDI A0 A0 9` para avanzar al siguiente elemento respeta el tamaño de la struct.

**Detalle a verificar**: la comparación entre consumos (uint32) y pagos (int16) puede ser problemática con `BLT` (signed). En el caso del ejemplo del enunciado funciona porque los valores son positivos. Para el caso general sería necesario `BLTU` para consumos.

**Stack frame de 12 bytes**: 4 (RA) + 4 (consumos word) + 4 (pagos, aunque es half — se guarda en slot de 4 bytes). Correcto.

### Chuleta

> **BalanceDeudor**: 9 bytes (1+4+2+2), sin padding
> - Offsets: ID=0, Consumos=1, Cant_pagos=5, Pagos=7
> - Instrucciones: `LB` para ID, `LW` para Consumos, `LH` para Pagos
> - Centinela: `LB T0 0(A0)` + `BEQ T0 ZERO fin`
> - Avance: `ADDI A0 A0 9` (tamaño de la struct)
>
> **contarDeudores (recursivo)**:
> 1. Leer ID → si 0, retornar 0
> 2. Salvar {RA, consumos, pagos} en stack (12 bytes)
> 3. Avanzar A0 en 9, llamar recursivo
> 4. Recuperar consumos y pagos, comparar con BLT
> 5. Si pagos < consumos: A0++ (SUMADOR); sino: retornar directo

---

## Ejercicio 4 — Microarquitectura: ResultSrc y bits de instruccion (2 pts.)

### Enunciado

Para microarquitectura de ciclo simple ejecutando `or x4, x5, x6`:
- ¿Qué sucede si `ResultSrc` está siempre en 1?
- ¿Y si los bits 24 a 20 de la instrucción están en cero?

### Resolucion

**Parte a — ResultSrc=1 siempre:**

El alumno responde: "El multiplexor que decide entre tomar el dato de Data Memory o la ALU [...] decide siempre tomar de la ALU."

**Parte b — Bits 24–20 = 0:**

"Si los bits entre 24 y 20 son todos ceros, se guarda en el destino el valor que hay en el registro que indican los bits entre 19 y 15, ya que es un OR entre un valor y cero."

### Explicacion

**Contexto de la microarquitectura de ciclo simple:**

En la implementación de referencia (Harris & Harris):
- `ResultSrc = 0`: el dato escrito al register file proviene de la ALU
- `ResultSrc = 1`: el dato escrito al register file proviene de Data Memory (instrucciones load)

**Codificacion de `or x4, x5, x6`** (tipo R):

| bits 31–25 | bits 24–20 | bits 19–15 | bits 14–12 | bits 11–7 | bits 6–0 |
|------------|------------|------------|------------|-----------|----------|
| funct7     | rs2 (x6)   | rs1 (x5)   | funct3     | rd (x4)   | opcode   |
| 0000000    | 00110      | 00101      | 110        | 00100     | 0110011  |

Los bits 24–20 codifican `rs2`. Si son todos ceros, rs2 = x0 (registro zero = 0 siempre).

Entonces `or x4, x5, x0 = x5 | 0 = x5` → se copia x5 a x4.

### Analisis de la resolucion

**Parte a — Parcialmente incorrecta:** el alumno invierte la semántica de ResultSrc. ResultSrc=1 hace que el mux seleccione la salida de **Data Memory** (no la ALU). El efecto correcto es: x4 recibirá el valor leído de la dirección de memoria calculada por la ALU (resultado de OR), lo cual es incorrecto para una instrucción tipo R y podría causar comportamiento indefinido si esa dirección no contiene datos válidos.

**Parte b — Correcta:** la conclusión "OR entre valor y cero = el valor mismo" es correcta. x4 ← x5.

### Chuleta

> **ResultSrc en microarquitectura de ciclo simple:**
> - ResultSrc=0 → escribe resultado de ALU al register file (instrucciones tipo R, tipo I aritméticas)
> - ResultSrc=1 → escribe dato leído de Data Memory (instrucciones load: lw, lh, lb)
> - Si ResultSrc=1 para `or`: el register file recibe basura de Data Memory (error de control)
>
> **Bits 24–20 de instrucción tipo R = rs2:**
> - Bits 24–20 = 00000 → rs2 = x0 (siempre 0)
> - `or x4, x5, x0` = x5 | 0 = x5 → x4 ← x5 (copia directa)
> - Patrón: OR con x0 es la forma de hacer `mv` en RISC-V

---

## Patrones nuevos detectados

- **Recursion mutua con 3 funciones**: `es_primo` → `cantidad_divisores` → `cantidad_divisores_rec`. Cada nivel necesita su propio frame de stack y manejo de RA.
- **Paridad sin REM**: `ANDI T0 A0 1` + `XORI A0 T0 1` (patrón compacto para es_par)
- **arreglo_par post-order**: procesa elementos en el retorno de la recursión (de último a primero), lo que permite actualizar in-place sin un arreglo auxiliar
- **BalanceDeudor struct de 9 bytes sin padding**: misma struct que en el parcial regular 2C 2024 (ver [[2P_2C_2024]])
- **ResultSrc=1 en instrucción tipo R**: efecto de mal comportamiento del mux — el register file recibe dato de Data Memory en lugar de ALU

## Ver tambien

- [[2P_2C_2024]] — parcial regular mismo cuatrimestre (ejercicios similares: struct BalanceDeudor, microarquitectura `or`)
- [[2P_1C_2025]] — parcial siguiente (mismos patrones RISC-V)
- [[transcripciones/2P_2C_2024_rec_raw]] — transcripción fiel del PDF
