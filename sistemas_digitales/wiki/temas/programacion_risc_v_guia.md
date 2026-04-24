---
nombre: Programacion RISC-V — Guia de Ejercicios
parcial: 2P
tipo: guia
tema: programacion_risc_v
fuente: raw/guias_practicas/3.prac_arquitectura_cpu.pdf
paginas_relacionadas:
  - "[[arquitectura_teoria_pt1]]"
  - "[[arquitectura_teoria_pt2]]"
  - "[[arquitectura_cpu_guia]]"
  - "[[programacion_risc_v_guia_pt2]]"
---

# Programacion RISC-V — Guia de Ejercicios

Fuente: `raw/guias_practicas/3.prac_arquitectura_cpu.pdf` — Practica 3, seccion 2: "Programacion en RISC-V" (Ej 8–15).
Los ejercicios de ensamblado/arquitectura (Ej 1–7) y de otras arquitecturas (Ej 16–21) estan en [[arquitectura_cpu_guia]].

**Nota:** esta guia cubre programacion a nivel de registros (sin llamadas a funciones, sin stack ABI). Los ejercicios de funciones con convencion de llamada, recursion y estructuras estan en [[programacion_risc_v_guia_pt2]].

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej. 8 | ¿Que son .text y .data? | ⚪ No |
| Ej. 9 | Sumar los 4 bytes de un registro | ⚪ No |
| Ej. 10 | Implementar sll sin usar la instruccion sll | ⚪ No |
| Ej. 11 | Encontrar el maximo de un arreglo | 🔴 Si |
| Ej. 12 | Copiar un vector a otro | ⚪ No |
| Ej. 13 | Copiar elementos pares de un vector (0 si impar) | 🔴 Si |
| Ej. 14 | sumar64: sumar dos enteros de 64 bits en arquitectura 32 bits | ⚪ No |
| Ej. 15 | sumaVector64: sumar vector de enteros de 64 bits | ⚪ No |

---

## Ejercicio 8 — .text y .data

**Enunciado**
¿Que es `.text` y `.data`? ¿Que tipo de informacion se guarda en cada una de ellas?

**Explicacion**
Seccion `.text`: codigo ejecutable (instrucciones del programa). Seccion `.data`: datos estaticos inicializados (variables globales, constantes). En el mapa de memoria de RISC-V: `.text` en la region baja de memoria de programa, `.data` arriba de `.text`. Las directivas de ensamblado `.section .text` y `.section .data` indican al ensamblador donde ubicar cada elemento.

**Resolucion paso a paso**

Las secciones (o segmentos) son regiones del binario con propositos distintos:

- **`.text`** — contiene el codigo ejecutable (las instrucciones del programa). Es de solo lectura en tiempo de ejecucion. El program counter apunta a instrucciones dentro de esta seccion.
- **`.data`** — contiene datos estaticos **inicializados** en el fuente: variables globales con valor inicial, constantes de cadena, etc. Se carga en memoria de lectura/escritura al iniciar el proceso.

En un binario RISC-V el mapa de memoria tipico es:

```
Direcciones bajas  →  .text  (instrucciones)
                   →  .data  (datos inicializados)
                   →  .bss   (datos sin inicializar, no parte del binario)
Direcciones altas  →  stack / heap
```

Las directivas `.section .text` y `.section .data` (o simplemente `.text` / `.data`) le indican al ensamblador en que segmento ubicar lo que sigue.

**Chuleta**
- `.text` = instrucciones (codigo ejecutable, read-only en ejecucion)
- `.data` = variables/constantes estaticas con valor inicial (read-write)
- PC siempre apunta a `.text`; `lw`/`sw` acceden principalmente a `.data` y heap/stack

**¿Aparece en parciales?** ⚪ No

---

## Ejercicio 9 — Sumar los 4 bytes de un registro

**Enunciado**
Se tienen cuatro datos sin signo de 1 byte cada uno almacenados en el registro t0. Escribir un programa RISC-V que sume el valor de los cuatro bytes y guarde el resultado en t0.

Ejemplo: `t0 = 0x90 | 0x1A | 0x00 | 0x02` → resultado = `0x000000AC`

**Explicacion**
Patron: extraer cada byte con `srli` (desplazar derecha) + `andi 0xFF` (mask), acumular la suma. Los 4 bytes estan en posiciones bit 0-7, 8-15, 16-23, 24-31. Para el byte 0: `andi t1, t0, 0xFF`. Para byte 1: `srli t1, t0, 8` + `andi t1, t1, 0xFF`. Idem para bytes 2 y 3. Sumar todos. El resultado cabe en un registro de 32 bits si cada byte ≤ 255 → suma maxima = 4×255 = 1020.

**Resolucion paso a paso**

Patron: extraer cada byte con mascara `0xFF` y desplazamiento, luego acumular.

```asm
# t0 = 0xByte3 | Byte2 | Byte1 | Byte0
# Resultado en t0

andi t1, t0, 0xFF          # t1 = Byte0  (bits 7-0)

srli t2, t0, 8
andi t2, t2, 0xFF          # t2 = Byte1  (bits 15-8)
add  t1, t1, t2            # t1 = Byte0 + Byte1

srli t2, t0, 16
andi t2, t2, 0xFF          # t2 = Byte2  (bits 23-16)
add  t1, t1, t2            # t1 = Byte0 + Byte1 + Byte2

srli t2, t0, 24            # t2 = Byte3  (bits 31-24, ya en los 8 bits bajos)
                           # no hace falta andi: srli de 24 garantiza 0s en bits 31-8
add  t0, t1, t2            # t0 = suma de los cuatro bytes
```

Verificacion con el ejemplo: `t0 = 0x90_1A_00_02`
- Byte0 = 0x02, Byte1 = 0x00, Byte2 = 0x1A, Byte3 = 0x90
- Suma = 2 + 0 + 26 + 144 = 172 = 0xAC ✓

Nota: `srli t2, t0, 24` produce en los bits 31-8 exactamente los bits que estaban en 31-24 del original. Como t0 es un registro de 32 bits, bits 31-8 del resultado de srli son 0. Por lo tanto no se necesita `andi`.

**Chuleta**
1. `andi t1, t0, 0xFF` → byte 0
2. Para byte N (N = 1, 2, 3): `srli t2, t0, 8*N` + `andi t2, t2, 0xFF`
3. Acumular con `add`
4. Resultado en t0 (suma de los 4 bytes)

**¿Aparece en parciales?** ⚪ No

---

## Ejercicio 10 — Implementar sll sin usar la instruccion sll

**Enunciado**
Valor a shiftear en t0, cantidad de posiciones en t1 (sin signo). Resultado en t0.

a) Escribir el pseudocodigo del programa sll sin usar la instruccion sll.
b) Escribir el programa en RISC-V.
c) Si el programa usa registros adicionales, modificar para solo alterar t0 y t1.

**Explicacion**
Shift left logico de k posiciones = multiplicar por $2^k$ via suma iterada o loop. Pseudocodigo: hacer un loop de t1 iteraciones, en cada iteracion agregar t0 a si mismo (`add t0, t0, t0` equivale a multiplicar por 2, o sea sll por 1). Despues de t1 iteraciones, t0 queda desplazado t1 bits a la izquierda. Para no usar registros adicionales: usar t1 como contador decreciente (decrementarlo en cada iteracion hasta 0).

Cuidado: `add t0, t0, t0` es sll por 1. Despues de k iteraciones, t0 = t0_original * 2^k = t0_original << k.

**Resolucion paso a paso**

**a) Pseudocodigo:**

```
mientras t1 != 0:
    t0 = t0 + t0    # desplazar 1 bit a la izquierda
    t1 = t1 - 1
```

Razon: `add t0, t0, t0` equivale a `t0 * 2` = `t0 << 1`. Repetir t1 veces produce `t0_orig << t1`.

**b) Programa en RISC-V:**

```asm
# t0 = valor a desplazar, t1 = cantidad de posiciones (sin signo)
# Resultado en t0

        beq  t1, zero, fin    # si t1 == 0, no hacer nada
loop:
        add  t0, t0, t0       # t0 <<= 1
        addi t1, t1, -1       # t1--
        bne  t1, zero, loop
fin:
```

**c) Uso de registros:** la solucion de b) ya usa solo t0 y t1. No se necesitan registros adicionales.

Cuidado con t1 = 0: el `beq` inicial evita el loop en ese caso (resultado debe quedar sin cambios).

**Chuleta**
1. Si t1 == 0 → saltar (sin desplazamiento)
2. Loop t1 veces: `add t0, t0, t0` (sll por 1)
3. Decrementar t1 en cada iteracion
4. `add rd, rs, rs` = sll de rs por 1 (sin instruccion sll)

**¿Aparece en parciales?** ⚪ No

---

## Ejercicio 11 — Encontrar el maximo de un arreglo

**Enunciado**
Dado un vector de enteros `Arreglo` (inicio en t0) y su longitud en t1, encontrar el valor maximo.

Ejemplo: Arreglo = [3, 1, 4, 1, 5, 9, 2, 6], Longitud = 8 → Salida: 9

**Explicacion**
Patron de recorrido de arreglo con comparacion acumulada. Inicializar `max = Arreglo[0]` (lw desde t0). Loop: avanzar puntero (t0 += 4), comparar elemento actual con max, actualizar max si mayor. Condicion de parada: t1 iteraciones (decrementar contador). Instruccion de comparacion: `bge current, max, no_update` (si current >= max, actual es mayor o igual, actualizar).

Este patron (recorrer arreglo buscando valor extremo) es frecuente en parciales.

**Resolucion paso a paso**

Patron: scan lineal con variable `max` inicializada en el primer elemento.

```asm
# t0 = puntero al inicio del arreglo
# t1 = longitud (>= 1)
# Resultado: maximo en t2

        lw   t2, 0(t0)        # max = Arreglo[0]
        addi t0, t0, 4        # puntero al segundo elemento
        addi t1, t1, -1       # quedan t1-1 elementos por revisar
        beq  t1, zero, fin    # si habia un solo elemento, fin

loop:
        lw   t3, 0(t0)        # elemento actual
        bge  t2, t3, no_update  # si max >= actual, no actualizar
        mv   t2, t3           # max = actual (actual > max)
no_update:
        addi t0, t0, 4        # avanzar puntero
        addi t1, t1, -1       # contador--
        bne  t1, zero, loop
fin:
        # t2 contiene el maximo
```

Traza con [3, 1, 4, 1, 5, 9, 2, 6]:
- max = 3 → 3 >= 1 (no update) → 3 < 4 (update: max=4) → 4 >= 1 → 4 < 5 (max=5) → 5 < 9 (max=9) → 9 >= 2 → 9 >= 6 → resultado: 9 ✓

**Chuleta**
1. `max = Arreglo[0]`; avanzar puntero; decrementar contador
2. Si solo habia 1 elemento → fin
3. Loop: cargar elemento, si `max >= elem` no hacer nada; si `elem > max` → `mv max, elem`; avanzar puntero y contador

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/iteracion_arreglo_risc_v]] | patron recorrido de arreglo con condicion es base de ej como `arreglo_par` ([[parciales_analizados/2P_2C_2024_recuperatorio]]) e `invertirArreglo` ([[parciales_analizados/2P_2C_2024]])

---

## Ejercicio 12 — Copiar un vector a otro

**Enunciado**
Dos vectores `s` y `q` con direcciones de inicio en t0 y t1 respectivamente. Longitud en t2. Escribir un programa que copie la informacion de `q` a `s`.

**Explicacion**
Patron de copia con dos punteros. Loop t2 veces: `lw t3, 0(t1)` (leer de q), `sw t3, 0(t0)` (escribir en s), avanzar ambos punteros (t0 += 4, t1 += 4), decrementar contador t2. El invariante es que los dos punteros avanzan en sinconia.

**Resolucion paso a paso**

Patron: dos punteros en sinconia, loop t2 veces.

```asm
# t0 = puntero a s (destino)
# t1 = puntero a q (fuente)
# t2 = longitud

        beq  t2, zero, fin    # arreglo vacio

loop:
        lw   t3, 0(t1)        # leer q[i]
        sw   t3, 0(t0)        # escribir s[i]
        addi t0, t0, 4        # s++
        addi t1, t1, 4        # q++
        addi t2, t2, -1
        bne  t2, zero, loop
fin:
```

Nota: los punteros siempre avanzan en sinconia (el offset entre s y q se mantiene constante si las bases son distintas; si se superponen, el comportamiento depende de la direccion relativa — la guia no especifica restriccion).

**Chuleta**
1. Loop t2 veces: `lw t3, 0(t1)` → `sw t3, 0(t0)` → `t0 += 4` → `t1 += 4` → `t2--`

**¿Aparece en parciales?** ⚪ No

---

## Ejercicio 13 — Copiar elementos pares de un vector

**Enunciado**
Vectores `s` (en t0) y `q` (en t1), longitud en t2. Copiar los elementos pares de `q` a `s`. Si la posicion `i` de `q` no tiene un elemento par, poner 0 en `s[i]`.

**Explicacion**
Extiende el patron de copia con una condicion. Para verificar paridad sin `rem`: `andi t3, elemento, 1` — si t3 = 0 el elemento es par. Pseudocodigo:

```
para i=0..t2-1:
  elemento = q[i]
  if (elemento & 1) == 0:
    s[i] = elemento
  else:
    s[i] = 0
```

En RISC-V: `andi t3, elemento, 1` + `beq t3, zero, es_par` + store 0 en rama impar. Patron identico al `arreglo_par` del recuperatorio 2C 2024.

**Resolucion paso a paso**

Extiende el patron de copia (Ej 12) con un branch para verificar paridad del elemento.

```asm
# t0 = puntero a s (destino)
# t1 = puntero a q (fuente)
# t2 = longitud

        beq  t2, zero, fin

loop:
        lw   t3, 0(t1)           # elemento q[i]
        andi t4, t3, 1           # bit 0: 0=par, 1=impar
        bne  t4, zero, impar     # si bit0 == 1 → impar

        sw   t3, 0(t0)           # par: copiar elemento
        j    siguiente

impar:
        sw   zero, 0(t0)         # impar: guardar 0

siguiente:
        addi t0, t0, 4
        addi t1, t1, 4
        addi t2, t2, -1
        bne  t2, zero, loop
fin:
```

Verificacion de paridad: `andi t4, t3, 1` extrae el bit menos significativo. Si es 0 → par; si es 1 → impar. Este es el patron canonico para verificar paridad en RISC-V sin `rem`.

Variante alternativa con `beq` (evitar el salto incondicional `j`):

```asm
loop:
        lw   t3, 0(t1)
        andi t4, t3, 1
        beq  t4, zero, es_par    # si par → copiar
        sw   zero, 0(t0)         # impar → 0
        j    siguiente
es_par:
        sw   t3, 0(t0)
siguiente:
        addi t0, t0, 4
        addi t1, t1, 4
        addi t2, t2, -1
        bne  t2, zero, loop
```

**Chuleta**
1. `andi t4, elem, 1` → 0=par, 1=impar
2. Si impar → `sw zero, 0(t0)` (guardar 0); si par → `sw elem, 0(t0)`
3. Siempre avanzar ambos punteros y el contador

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/iteracion_arreglo_risc_v]] | `arreglo_par` en [[parciales_analizados/2P_2C_2024_recuperatorio]] (Ej2) usa exactamente este patron: `andi+xori` para paridad sin REM, post-order con cero en posiciones impares

---

## Ejercicio 14 — sumar64: sumar dos enteros de 64 bits

**Enunciado**
La arquitectura RISC-V tiene operaciones de 32 bits. El programa `sumar64` realiza la suma de dos enteros de 64 bits en C2. Los registros t0 y t1 indican las direcciones de cada numero; t2 indica donde guardar el resultado.

a) Escribir el pseudocodigo de `sumar64`.
b) Escribir `sumar64` en ensamblador RISC-V.

**Explicacion**
Cada entero de 64 bits ocupa 2 palabras de 32 bits en memoria (little-endian: parte baja en dir menor). La suma de 64 bits requiere suma de la parte baja con carry propagado a la parte alta. Pseudocodigo:

```
lo0 = mem[t0]      // 32 bits bajos del primer numero
hi0 = mem[t0+4]    // 32 bits altos del primer numero
lo1 = mem[t1]      // 32 bits bajos del segundo numero
hi1 = mem[t1+4]    // 32 bits altos del segundo numero
lo_res = lo0 + lo1
carry = (lo_res < lo0) ? 1 : 0    // carry si hubo overflow en suma baja
hi_res = hi0 + hi1 + carry
mem[t2] = lo_res
mem[t2+4] = hi_res
```

En RISC-V: detectar carry con comparacion sin signo (`bltu`/`sltu`).

**Resolucion paso a paso**

**a) Pseudocodigo:**

```
lo0 = mem[t0]       # 32 bits bajos del primer numero
hi0 = mem[t0 + 4]   # 32 bits altos del primer numero
lo1 = mem[t1]       # 32 bits bajos del segundo numero
hi1 = mem[t1 + 4]   # 32 bits altos del segundo numero

lo_res = lo0 + lo1
carry  = (lo_res < lo0) ? 1 : 0   # overflow sin signo = carry
hi_res = hi0 + hi1 + carry

mem[t2]     = lo_res
mem[t2 + 4] = hi_res
```

**b) Programa en RISC-V:**

```asm
# t0 = dir primer numero (64 bits en [t0], [t0+4])
# t1 = dir segundo numero
# t2 = dir resultado

        lw   t3, 0(t0)         # lo0
        lw   t4, 4(t0)         # hi0
        lw   t5, 0(t1)         # lo1
        lw   t6, 4(t1)         # hi1

        add  t0, t3, t5        # lo_res = lo0 + lo1  (t0 ya no es necesario como dir)
        sltu t1, t0, t3        # carry = 1 si lo_res < lo0 (unsigned overflow)
                               # (t1 ya no es necesario como dir)

        add  t4, t4, t6        # hi0 + hi1
        add  t4, t4, t1        # + carry

        sw   t0, 0(t2)         # guardar lo_res
        sw   t4, 4(t2)         # guardar hi_res
```

Clave: `sltu rd, rs1, rs2` hace `rd = 1` si `rs1 < rs2` (comparacion sin signo). Tras `add t0, t3, t5`, si hubo carry, `t0 < t3` (unsigned). Esto detecta el overflow de la parte baja. ⚠️ Verificar — la deteccion de carry puede hacerse con `sltu t1, t0, t5` tambien (si `lo_res < lo1`, idem; ambos son equivalentes cuando hay overflow).

**Chuleta**
1. Cargar las dos mitades de cada operando: `lw lo`, `lw hi` (offset 0 y 4)
2. Sumar partes bajas: `add lo_res, lo0, lo1`
3. Detectar carry: `sltu carry, lo_res, lo0` (1 si hubo overflow unsigned)
4. Sumar partes altas + carry: `add hi_res, hi0, hi1` + `add hi_res, hi_res, carry`
5. Guardar resultado: `sw lo_res, 0(t2)` + `sw hi_res, 4(t2)`

**¿Aparece en parciales?** ⚪ No — ejercicio de precision extendida, no visto en parciales de 2P

---

## Ejercicio 15 — sumaVector64: sumar vector de enteros de 64 bits

**Enunciado**
`sumaVector64` suma los valores de un vector de `n` posiciones de enteros de 64 bits. t0 = cantidad de elementos, t1 = direccion del vector, t2 = direccion donde guardar el resultado. Suponer disponible el programa `sumar64` del ejercicio anterior.

a) Escribir el pseudocodigo de `sumaVector64`.
b) Escribir `sumaVector64` en ensamblador RISC-V.

**Explicacion**
Combina el patron de recorrido de arreglo con el programa `sumar64`. Acumulador de 64 bits inicializado en 0 (dos palabras de 32 bits). En cada iteracion del loop: sumar el elemento actual (64 bits) al acumulador usando `sumar64`. Avanzar el puntero 8 bytes (2 palabras). Guardar el resultado de 64 bits al final en t2.

**Resolucion paso a paso**

**a) Pseudocodigo:**

```
acc_lo = 0
acc_hi = 0
para i = 0 .. t0-1:
    lo_elem = mem[t1 + i*8]
    hi_elem = mem[t1 + i*8 + 4]
    lo_nuevo = acc_lo + lo_elem
    carry    = (lo_nuevo < acc_lo) ? 1 : 0
    hi_nuevo = acc_hi + hi_elem + carry
    acc_lo = lo_nuevo
    acc_hi = hi_nuevo
mem[t2]     = acc_lo
mem[t2 + 4] = acc_hi
```

**b) Programa en RISC-V** (inlinea la logica de sumar64 sin llamada a funcion):

```asm
# t0 = cantidad de elementos (n)
# t1 = puntero al inicio del vector (cada elemento ocupa 8 bytes)
# t2 = direccion donde guardar el resultado de 64 bits
# Acumulador: t3 = lo, t4 = hi

        add  t3, zero, zero        # acc_lo = 0
        add  t4, zero, zero        # acc_hi = 0
        beq  t0, zero, fin         # vector vacio

loop:
        lw   t5, 0(t1)             # lo del elemento actual
        lw   t6, 4(t1)             # hi del elemento actual

        add  t3, t3, t5            # acc_lo += lo_elem
        sltu t5, t3, t5            # carry = 1 si acc_lo < lo_elem (overflow unsigned)
        add  t4, t4, t6            # acc_hi += hi_elem
        add  t4, t4, t5            # acc_hi += carry

        addi t1, t1, 8             # avanzar 8 bytes al siguiente elemento de 64 bits
        addi t0, t0, -1
        bne  t0, zero, loop

fin:
        sw   t3, 0(t2)             # guardar lo del resultado
        sw   t4, 4(t2)             # guardar hi del resultado
```

Notas:
- Cada elemento de 64 bits ocupa 2 palabras → offset entre elementos = 8 bytes.
- Despues de `add t3, t3, t5` (donde t5 = lo_elem), `sltu t5, t3, t5` reutiliza t5 para el carry porque `sltu` no modifica t3 y t5 aun tiene el valor de lo_elem que fue sumado.
- No se usa `jal` a sumar64: la logica se inlinea (mas simple sin ABI).

**Chuleta**
1. Inicializar acumulador 64-bit en 0: `t3=0, t4=0`
2. Loop n veces: cargar `lw lo, hi` (offsets 0 y 4); `add acc_lo, acc_lo, lo`; `sltu carry, acc_lo, lo`; `add acc_hi, acc_hi, hi`; `add acc_hi, acc_hi, carry`; `t1 += 8`
3. Al final: `sw acc_lo, 0(t2)` + `sw acc_hi, 4(t2)`

**¿Aparece en parciales?** ⚪ No — extension del ejercicio anterior

---

## Ver tambien

- [[arquitectura_teoria_pt1]] — ISA RISC-V completo, tipos de instruccion, ciclo fetch-decode-execute
- [[arquitectura_teoria_pt2]] — ABI, calling convention, stack frame, recursion
- [[arquitectura_cpu_guia]] — Ej 1-7 (ensamblado, tipos de instruccion, seguimiento) y Ej 16-21 (formatos de instruccion)
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ej2: arreglo_par (patron identico a Ej 13)
- [[parciales_analizados/2P_2C_2024]] — Ej2: invertirArreglo, Ej1: recursion Pascal
