---
nombre: Programacion RISC-V — Guia de Ejercicios (Parte 2)
parcial: 1P
programa: 2C_2026
tipo: guia
tema: programacion_risc_v
fuente: raw/guias_practicas/4.prac_programacion_RISC-V.pdf
paginas_relacionadas:
  - "[[arquitectura_teoria_pt1]]"
  - "[[arquitectura_teoria_pt2]]"
  - "[[programacion_risc_v_guia]]"
  - "[[arquitectura_cpu_guia]]"
  - "[[parciales_analizados/2P_2C_2024]]"
  - "[[parciales_analizados/2P_2C_2024_recuperatorio]]"
  - "[[parciales_analizados/2P_1C_2025]]"
---

# Programacion RISC-V — Guia de Ejercicios (Parte 2)

Fuente: `raw/guias_practicas/4.prac_programacion_RISC-V.pdf` — Practica 4, 1C 2025.
Cubre: convencion de llamada, uso del stack, recursion, manejo de estructuras.
Emulador de referencia: Ripes.

Los ejercicios de programacion a nivel de registros (sin ABI) estan en [[programacion_risc_v_guia]].

---

## Indice de ejercicios

| # | Descripcion breve | Subtema | ¿Parcial? |
|---|---|---|---|
| Ej. 1 | Debuggear funciones con errores de convencion (incisos a–f) | Convencion de llamada | ⚪ No |
| Ej. 2 | Programar: mult, Fibonacci iterativo, mayor en R2, division | Convencion de llamada | 🔴 Si |
| Ej. 3 | Debuggear funciones con auxiliares + seguimiento de stack (incisos a–b) | Uso del stack | ⚪ No |
| Ej. 4 | Conceptual: obligaciones/garantias caller/callee | Convencion de llamada | ⚪ No |
| Ej. 5a | Inv / InvertirArreglo | Programacion RISC-V | 🔴 Si |
| Ej. 5b | EsPotenciaDeDos / PotenciasEnArreglo | Programacion RISC-V | 🔴 Si |
| Ej. 5c | EvaluarMonomio / EvaluarPolinomio | Programacion RISC-V | ⚪ No |
| Ej. 6 | Debuggear funciones recursivas con errores de stack (incisos a–c) | Recursion | ⚪ No |
| Ej. 7 | Conceptual: bytes de stack para Fibonacci recursivo vs iterativo | Recursion | ⚪ No |
| Ej. 8a | Factorial recursivo | Recursion | 🔴 Si |
| Ej. 8b | Profundidad de Collatz (EsPar + recursion) | Recursion | ⚪ No |
| Ej. 8c | Fibonacci 3 (base 0/1/2) | Recursion | 🔴 Si |
| Ej. 8d | Fibonacci n (generalizacion con n argumento) | Recursion | ⚪ No |
| Ej. 8e | Raiz de funcion lineal por biseccion (jalr) | Recursion | ⚪ No |
| Ej. 9 | Struct InformacionAlumno (half 16-bit + byte 8-bit), suma notas ID impar | Estructuras | 🔴 Si |
| Ej. 10 | Lista enlazada de nodos (word 32-bit + puntero), suma de valores | Estructuras | ⚪ No |
| Ej. 11 | ArregloOrdenado: busqueda binaria recursiva e iterativa | Estructuras | ⚪ No |

---

## Convencion de Llamada

### Ejercicio 1 — Debuggear funciones (convencion de llamada sin auxiliares)

**Enunciado**
Dos programadores (A: funciones, B: tests) sin comunicacion. Ambos dicen seguir la convencion de llamada estandar, pero todos los tests fallan. Para cada programa (incisos a–f):
- Comentar los tests (que se evalua) y el codigo de la funcion (que hace, nombre descriptivo).
- Marcar prologo y epilogo de la funcion.
- Encontrar errores de convencion (no hay errores logicos) y decidir culpabilidad (A y/o B). Justificar.
- Arreglar y comprobar en Ripes.

**Inciso a — Negacion (inverso aditivo)**
Funcion: `not s1, a0; addi a0, s1, 1` → computa $-a0$ (complemento a 2). Test: `li s1, 2024; mv a0, s1; jal ra, FUNCION; add a0, s1, a0` (espera $s1 + (-s1) = 0$).
Error: Programador A usa `s1` (callee-saved) sin preservarlo en el prologo/epilogo. Programador B usa `s1` post-jal asumiendo que no fue modificado → ambos culpables.

**Inciso b — Suma de dos argumentos**
Funcion: `add a3, a0, a1` → guarda resultado en `a3` en vez de `a0`. Test: espera resultado en `a0`. Error exclusivo de Programador A: resultado no retornado en el registro de convencion (`a0`).

**Inciso c — Formula $4 \cdot a0 - a1/2$**
Funcion: `slli a2, a0, 2; srai a1, a1, 1; sub a0, a2, a1`. Test: tres llamadas con `(1,2)→3`, `(3,2)→11`, `(3,12)→6`. Notar que A modifica `a1` (caller-saved — permitido), pero B no recarga `a1` entre llamadas cuando cambia de valor. La segunda llamada reutiliza `a1=1` (ya pisado por la primera) en vez del valor original → error de Programador B.

**Inciso d — Maximo de dos valores**
Funcion: usa `a2` y `a5` como argumentos implícitos (`mv a0, a2; bgt a0, a5, terminar; mv a0, a5`). Test: pasa argumentos en `a0` y `a1` (convencion). Error: Programador A lee registros que no son los de argumento (a2/a5 en vez de a0/a1).

**Inciso e — Suma acumulada 0..n**
Funcion: lee `n` de `a0`, usa `a1` como contador interno. Test: pasa `n` en `a3` (`li a3, 4`). Error de Programador B: argumento en registro incorrecto (`a3` en vez de `a0`). FUNCION lee `a0` que estaria indefinido.

**Inciso f — Modulo m**
Funcion compleja que computa el modulo de forma que maneja negativos (`(-n) % m = m - (n % m)`). Usa `s1` sin preservarlo en prologo. Test: dos llamadas, la segunda usa `a2` como resultado esperado que fue pisado por la primera llamada. Errores de ambos: A no preserva `s1`, B reutiliza `a2` que fue modificado durante la primera llamada.

**Explicacion general**
Errores clasicos de convencion:
- Programador A: usar registros callee-saved (s0–s11, ra) sin preservar; retornar resultado en registro incorrecto.
- Programador B: pasar argumentos en registros incorrectos; asumir que registros caller-saved (a0–a7, t0–t6) se preservan entre llamadas.

**Resolucion paso a paso**

**Inciso a — codigo corregido:**
```asm
# Error A: usa s1 sin preservarlo. Error B: usa s1 post-jal (correcto si A preserva)
# Fix A: agregar prologo/epilogo para s1

NEGACION:                       # prologo ↓
    addi sp, sp, -16
    sw   s1, 0(sp)              # preservar s1 (callee-saved)
    not  s1, a0
    addi a0, s1, 1
    lw   s1, 0(sp)              # epilogo ↓: restaurar s1
    addi sp, sp, 16
    ret

# Test B (sin cambio necesario, s1 queda intacto):
    li   s1, 2024
    mv   a0, s1
    jal  ra, NEGACION
    add  a0, s1, a0             # 2024 + (-2024) = 0 ✓
```

**Inciso b — codigo corregido:**
```asm
# Error A: resultado en a3 en vez de a0
# Fix: escribir resultado en a0

SUMA:
    add  a0, a0, a1             # resultado en a0 ✓
    ret
```

**Inciso c — codigo corregido:**
```asm
# Error B: no recarga a1 entre llamadas (a1 es caller-saved → B debe preservarlo)
# Fix B: recargar argumentos antes de cada llamada

    # Primera llamada: f(1, 2) = 4*1 - 2/2 = 3
    li   a0, 1
    li   a1, 2
    jal  ra, FORMULA
    # a0 = 3, a1 = 1 (pisado por la funcion)

    # Segunda llamada: f(3, 2) = 12 - 1 = 11
    li   a0, 3
    li   a1, 2                  # B debe recargar a1 ← aqui estaba el error
    jal  ra, FORMULA

    # Tercera llamada: f(3, 12) = 12 - 6 = 6
    li   a0, 3
    li   a1, 12                 # idem
    jal  ra, FORMULA
```

**Inciso d — codigo corregido:**
```asm
# Error A: lee a2/a5 en vez de a0/a1
# Fix: usar los registros de argumento correctos

MAXIMO:
    bgt  a0, a1, max_ret        # si a0 > a1, a0 ya es el maximo
    mv   a0, a1                 # sino, a1 es el maximo
max_ret:
    ret
```

**Inciso e — codigo corregido:**
```asm
# Error B: pasa n en a3 en vez de a0
# Fix: usar a0

    li   a0, 4                  # n en a0, no en a3
    jal  ra, SUMA_ACUMULADA
```

**Inciso f — codigo corregido:**
```asm
# Error A: usa s1 sin preservar. Error B: reutiliza a2 que la funcion modifico.
# Fix A: prologo/epilogo para s1.
# Fix B: guardar resultado de cada llamada en un registro s o en memoria.

MODULO:                         # prologo ↓
    addi sp, sp, -16
    sw   s1, 0(sp)
    # ... cuerpo usa s1 libremente ...
    lw   s1, 0(sp)              # epilogo ↓
    addi sp, sp, 16
    ret

# Test B corregido: guardar resultados en registros s en vez de a/t
    li   a0, 7
    li   a1, 3
    jal  ra, MODULO
    mv   s0, a0                 # guardar resultado 1 en s0 (callee-saved)
    li   a0, -7
    li   a1, 3
    jal  ra, MODULO
    mv   s1, a0                 # guardar resultado 2 en s1
    # comparar s0 y s1
```

**Chuleta**
> **Checklist de convencion de llamada:**
> 1. Callee (A): ¿usas s0–s11 o ra? → guardarlos en prologo, restaurar en epilogo
> 2. Callee (A): ¿retornas en a0? → unico registro de retorno
> 3. Caller (B): ¿argumentos en a0–a7? → no en a2, a3, a5...
> 4. Caller (B): ¿usas a0–a7 o t0–t6 despues de jal? → guardarlos ANTES del jal (son caller-saved)
> 5. Caller (B): ¿multiples llamadas? → recargar argumentos caller-saved antes de cada jal

**¿Aparece en parciales?** ⚪ No — los parciales piden programar funciones, no debuggear convencion.

---

### Ejercicio 2 — Programar funciones con convencion de llamada

**Enunciado**
Programar en RISC-V con al menos 2 casos de test cada una (convencion estandar):

a) **Multiplicacion:** $mult(x, y) = x \cdot y$, con $x, y \in \mathbb{Z}$

b) **Fibonacci Iterativo**

c) **Mayor en $\mathbb{R}^2$:**
$$mayor(x_1, y_1, x_2, y_2) = \begin{cases} 1 & \text{si } x_1 > x_2 \wedge y_1 > y_2 \\ -1 & \text{si } x_2 > x_1 \wedge y_2 > y_1 \\ 0 & \text{si no} \end{cases}$$

d) **Division:** $div(x, y) = \lfloor x/y \rfloor$, con $x, y \in \mathbb{Z}$

**Explicacion**
- `mult`: implementar con suma iterada (loop de y iteraciones, acumulando x). Manejar negativos: si uno de los factores es negativo, negar el resultado.
- Fibonacci iterativo: dos registros para $F_{n-1}$ y $F_{n-2}$, loop hasta n.
- Mayor en R2: comparar coordenadas independientemente (dos `bgt` con flags combinados).
- `div`: resta iterada o desplazamientos. Para negativos: calcular div de positivos y ajustar signo.

**Resolucion paso a paso**

**a) mult — suma iterada con manejo de signo:**
```asm
# mult: a0=x, a1=y → a0 = x*y
mult:
    addi sp, sp, -16
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = |x|
    sw   s1,  8(sp)     # s1 = |y| (contador)
    sw   s2, 12(sp)     # s2 = acumulador y flag signo

    li   t2, 0          # t2 = flag de signo (0=+, 1=-)
    mv   s0, a0
    mv   s1, a1
    li   s2, 0

    bge  s0, zero, mult_xpos
    sub  s0, zero, s0   # s0 = |x|
    xori t2, t2, 1      # flip signo
mult_xpos:
    bge  s1, zero, mult_loop
    sub  s1, zero, s1   # s1 = |y|
    xori t2, t2, 1      # flip signo

mult_loop:
    beq  s1, zero, mult_sign
    add  s2, s2, s0
    addi s1, s1, -1
    j    mult_loop

mult_sign:
    beq  t2, zero, mult_done
    sub  s2, zero, s2   # resultado negativo

mult_done:
    mv   a0, s2
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    addi sp, sp, 16
    ret

# Tests:
#   mult(3, 4)  → 12
#   mult(-3, 4) → -12
#   mult(-3,-4) → 12
#   mult(0, 5)  → 0
```

**b) fib_iter — Fibonacci iterativo:**
```asm
# fib_iter: a0=n → a0 = F(n)  [F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)]
fib_iter:
    addi sp, sp, -16
    sw   s0,  0(sp)     # s0 = contador restante
    sw   s1,  4(sp)     # s1 = F(i-2)
    sw   s2,  8(sp)     # s2 = F(i-1)
    sw   ra, 12(sp)

    mv   s0, a0
    li   s1, 0          # F(0) = 0
    li   s2, 1          # F(1) = 1

    beq  s0, zero, fi_cero
    li   t0, 1
    beq  s0, t0, fi_uno
    addi s0, s0, -1     # ya tenemos F(1); loop desde i=2

fi_loop:
    add  t0, s1, s2     # t0 = F(i) = F(i-2) + F(i-1)
    mv   s1, s2
    mv   s2, t0
    addi s0, s0, -1
    bne  s0, zero, fi_loop
    mv   a0, s2
    j    fi_fin

fi_cero: li a0, 0; j fi_fin
fi_uno:  li a0, 1
fi_fin:
    lw   s0,  0(sp)
    lw   s1,  4(sp)
    lw   s2,  8(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

# Tests:
#   fib_iter(0) → 0
#   fib_iter(1) → 1
#   fib_iter(6) → 8
#   fib_iter(10) → 55
```

**c) mayor — funcion hoja, no necesita stack frame:**
```asm
# mayor: a0=x1, a1=y1, a2=x2, a3=y2 → a0 = 1/-1/0
mayor:
    ble  a0, a2, mayor_check_neg
    ble  a1, a3, mayor_cero
    li   a0, 1
    ret
mayor_check_neg:
    bge  a0, a2, mayor_cero     # x1==x2 → 0
    bge  a1, a3, mayor_cero     # y1>=y2 → 0
    li   a0, -1
    ret
mayor_cero:
    li   a0, 0
    ret

# Tests:
#   mayor(3,4, 1,2) → 1  (3>1 y 4>2)
#   mayor(1,2, 3,4) → -1
#   mayor(3,1, 1,4) → 0  (3>1 pero 1<4)
```

**d) div — division por restas iteradas:**
```asm
# div: a0=x, a1=y → a0 = floor(x/y)
div:
    addi sp, sp, -16
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = |x|
    sw   s1,  8(sp)     # s1 = |y|
    sw   s2, 12(sp)     # s2 = cociente

    li   t2, 0          # flag signo
    mv   s0, a0
    mv   s1, a1
    li   s2, 0

    bge  s0, zero, div_yabs
    sub  s0, zero, s0
    xori t2, t2, 1
div_yabs:
    bge  s1, zero, div_loop
    sub  s1, zero, s1
    xori t2, t2, 1

div_loop:
    blt  s0, s1, div_sign
    sub  s0, s0, s1
    addi s2, s2, 1
    j    div_loop

div_sign:
    beq  t2, zero, div_done
    sub  s2, zero, s2

div_done:
    mv   a0, s2
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    addi sp, sp, 16
    ret

# Tests:
#   div(10, 3) → 3
#   div(-10, 3) → -3
#   div(7, 7)  → 1
```

**Chuleta**
> **Patron funcion con ABI:**
> 1. Prologo: `addi sp, sp, -16; sw ra, 0(sp); sw s0, 4(sp); ...`
> 2. Copiar argumentos a s-registers: `mv s0, a0; mv s1, a1`
> 3. Cuerpo con logica (usar t-registers para temporales)
> 4. Resultado en a0
> 5. Epilogo: `lw ra, 0(sp); lw s0, 4(sp); ...; addi sp, sp, 16; ret`
>
> **Manejo de signo con flag:**
> `li t_flag, 0; bge x, zero, skip; sub x, zero, x; xori t_flag, t_flag, 1`
> Al final: `beq t_flag, zero, done; sub resultado, zero, resultado`

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/convencion_llamada_risc_v]] | patron recursion/iteracion en los parciales historicos rotulados 2P — hoy material de tu **parcial unico**: [[parciales_analizados/2P_2C_2024_recuperatorio]] Ej1 (es_primo recursivo), [[parciales_analizados/2P_2C_2024]] Ej1 (Pascal recursivo). Fibonacci iterativo es version simplificada del patron recursivo.

---

### Ejercicio 4 — Conceptual: convencion de llamada

**Enunciado**
Indicar cuales son las obligaciones y garantias de la funcion llamada y la llamadora. Explicar por que se usan estas reglas. ¿Cual es la utilidad de una convencion de llamada?

**Explicacion**
Resumen de la convencion (ver [[arquitectura_teoria_pt2]] para detalle completo):

| Rol | Obligaciones | Garantias recibidas |
|-----|-------------|---------------------|
| **Caller (llamadora)** | Poner argumentos en a0–a7; guardar a0–a7/t0–t6 si los necesita post-jal | Resultado en a0; registros s0–s11/ra intactos |
| **Callee (llamada)** | Resultado en a0; preservar s0–s11 y ra; restaurar sp al valor original | Argumentos en a0–a7 al entrar |

Utilidad: permite que funciones escritas independientemente se compongan correctamente. El codigo que llama a una funcion sabe exactamente donde poner argumentos y donde leer resultados sin inspeccionar la implementacion.

**Resolucion paso a paso**

**Obligaciones del Callee (funcion llamada):**
1. Leer argumentos desde `a0`–`a7`.
2. Retornar resultado en `a0`.
3. Si usa registros `s0`–`s11` o `ra`: guardarlos en el stack al inicio y restaurarlos antes de retornar.
4. Mantener `sp` con el mismo valor al retornar que al entrar.
5. Retornar con `ret` (`jalr zero, ra, 0`).

**Garantias que el Callee recibe:**
- Los argumentos estan en `a0`–`a7`.
- Puede usar libremente `t0`–`t6` y `a0`–`a7` (son caller-saved).

**Obligaciones del Caller (funcion llamadora):**
1. Cargar argumentos en `a0`–`a7` antes de `jal ra, funcion`.
2. Si necesita el valor de `t0`–`t6` o `a0`–`a7` despues del retorno: guardarlos en el stack ANTES del `jal`.
3. Leer el resultado desde `a0`.

**Garantias que el Caller recibe:**
- `s0`–`s11` y `ra` quedan intactos despues del `jal`.
- Resultado disponible en `a0`.

**¿Por que estas reglas?**
Permiten compilar funciones de forma independiente. Sin ABI, el compilador de la funcion A tendria que saber exactamente que registros usa la funcion B para no pisar valores. Con ABI, cada funcion sabe exactamente que puede modificar y que debe preservar, sin conocer la implementacion de las otras.

**Chuleta**
> - **Callee-saved** (s0–s11, ra): la funcion llamada los preserva — el caller puede confiar en que quedan iguales
> - **Caller-saved** (a0–a7, t0–t6): el caller los guarda si los necesita post-jal — la funcion llamada los puede pisar libremente
> - **sp**: siempre alineado a 16 bytes; callee lo restaura exactamente

**¿Aparece en parciales?** ⚪ No — pregunta conceptual no vista como ejercicio independiente.

---

## Uso del Stack

### Ejercicio 3 — Debuggear funciones con auxiliares y seguimiento de stack

**Enunciado**
Tres programadores (A: funciones principales, B: funciones auxiliares de biblioteca, C: tests) sin comunicacion. La biblioteca de B esta documentada como ABI-compliant. A y C dicen haber seguido la convencion, pero todos los tests fallan. Para cada programa (incisos a–b):
- Comentar tests, funcion principal y auxiliar (que hace cada una).
- Marcar prologo y epilogo de cada funcion.
- Encontrar errores y determinar culpabilidad (A, B y/o C).
- Arreglar y comprobar en Ripes.
- Realizar seguimiento del stack.

**Inciso a — Minimo de tres valores**
FUNCION (A) llama a FUNCION_AUX tres veces para encontrar el minimo de a0, a1, a2, a3. Usa la pila para preservar a2/a3/ra. Error: FUNCION_AUX (B) no restaura `ra` antes de `ret` en el path `bgt a1, a0, terminar` → sale con `ret` sin haber cargado `ra` del stack. Culpable: B.

**Inciso b — Verificar si todos los argumentos estan en un intervalo**
FUNCION (A) verifica si un conjunto de valores caen dentro de un rango usando FUNCION_AUX. Usa `s0` para preservar estado entre llamadas. FUNCION_AUX verifica si $a0 \in [a1, a2]$. Error: A usa `lw a0, (0)sp` para restaurar el primer argumento pero ya pisó el offset correcto del stack; B no preserva registros caller que A necesita post-llamada (a2, a3, a4, a5). Culpable: requiere analisis de seguimiento de stack para determinar.

**Explicacion**
Patron de seguimiento de stack: dibujar el estado del stack en cada `addi sp` y `sw`/`lw`. Verificar que cada `lw ra, offset(sp)` restaura el ra correcto (no el de una llamada anidada).

**Resolucion paso a paso**

**Inciso a — codigo corregido de FUNCION_AUX (B):**
```asm
# Error: en el path "bgt a1, a0, terminar" se hace ret sin restaurar ra
# FUNCION_AUX guarda ra al inicio, pero no lo restaura en ese camino

FUNCION_AUX:                    # minimo(a0, a1)
    addi sp, sp, -16
    sw   ra, 0(sp)              # prologo
    bgt  a1, a0, aux_terminar   # si a1 > a0: a0 ya es el minimo
    mv   a0, a1                 # a0 = min(a0, a1)
aux_terminar:                   # epilogo (aplica a AMBOS paths)
    lw   ra, 0(sp)              # ← esto faltaba en el path bgt
    addi sp, sp, 16
    ret
```

**Seguimiento del stack — inciso a:**
```
Antes de FUNCION (A):   sp = 0x100
FUNCION prologo:        sp = 0x100 - 16 = 0x0F0
  0x0F0: ra
  0x0F4: a2
  0x0F8: a3

Llamada 1 → FUNCION_AUX:
  FUNCION_AUX prologo:  sp = 0x0F0 - 16 = 0x0E0
    0x0E0: ra (de FUNCION)
  FUNCION_AUX epilogo:  sp = 0x0E0 + 16 = 0x0F0  ✓

Llamada 2 y 3: idem.

FUNCION epilogo:        sp = 0x0F0 + 16 = 0x100  ✓
```

**Inciso b — principio de correccion:**

El error tipico en este tipo de ejercicio es un offset incorrecto en el `lw` para restaurar un argumento. Si el stack frame de A es:
```
sp+0:  ra
sp+4:  s0
sp+8:  a0 original  ← guardar el primer argumento para restaurarlo post-llamada
```
Y A usa `lw a0, 0(sp)` (leyendo ra en vez del argumento), ese es el bug. La correccion es usar el offset correcto: `lw a0, 8(sp)`.

B (biblioteca ABI-compliant) no tiene errores si cumple la especificacion. Si B modifica registros que A no guardo pero deberia haber guardado, la culpa es de A.

**Chuleta**
> **Seguimiento de stack paso a paso:**
> 1. Trazar `sp` en cada `addi sp`
> 2. Anotar que se guarda en cada `sw reg, offset(sp)`
> 3. Verificar que `lw reg, offset(sp)` lee el registro correcto (no otro)
> 4. Verificar simetria: cada `addi sp, -N` tiene su `addi sp, +N` correspondiente
> 5. Al retornar, `sp` debe tener el mismo valor que al entrar

**¿Aparece en parciales?** ⚪ No — los parciales no han incluido ejercicios de debugging de stack con auxiliares.

---

## Programacion RISC-V (con ABI)

### Ejercicio 5 — Programar funciones con convencion de llamada

**Enunciado**
Programar en RISC-V con al menos 2 casos de test cada una (convencion estandar):

**a) Inv e InvertirArreglo**
- $Inv(x) = -x$
- `InvertirArreglo`: dado puntero a arreglo de enteros de 32 bits y cantidad de elementos, reemplaza cada valor por su inverso aditivo.

**b) EsPotenciaDeDos y PotenciasEnArreglo**
$$EsPotenciaDeDos(x) = \begin{cases} 1 & \text{si } \exists k \in \mathbb{N} : 2^k = x \\ 0 & \text{si no} \end{cases}$$
- `PotenciasEnArreglo`: dado puntero a arreglo de enteros sin signo de 8 bits y cantidad de elementos, devuelve cuantos son potencias de 2.
- Ayuda: una potencia de 2 tiene exactamente un bit en 1. En binario: $2^k = 00\ldots010\ldots0$. Truco: $x \& (x-1) = 0$ ssi x es potencia de 2 (y x > 0).

**c) EvaluarMonomio y EvaluarPolinomio**
- $EvaluarMonomio(x, c, p) = c \cdot x^p$
- `EvaluarPolinomio`: dado puntero a arreglo de enteros de 32 bits (coeficientes), longitud del arreglo y un entero $x$, evalua el polinomio $P(x) = \sum_{i=0}^{n-1} coef[i] \cdot x^i$.
- Ejemplo: arreglo `[3, -1, 5, 0, 2]` → $P(x) = 3 - x + 5x^2 + 2x^4$.

**Explicacion**

**5a (InvertirArreglo):** patron de recorrido de arreglo con modificacion in-place. Por cada elemento: `lw t0, 0(a0); jal ra, Inv; sw a0, 0(puntero); avanzar puntero`. Notar que `Inv` recibe argumento en `a0` y retorna en `a0`. Preservar puntero y contador (registros s).

**5b (EsPotenciaDeDos):** `x & (x-1) == 0` con `x > 0`. En RISC-V: `addi t0, a0, -1; and t0, a0, t0; seqz a0, t0; and a0, a0, a1` (donde a1 = (x > 0)). Para `PotenciasEnArreglo`: recorrer con `lbu` (byte sin signo), llamar `EsPotenciaDeDos`, acumular contador.

**5c (EvaluarPolinomio):** loop sobre coeficientes. Mantener potencia actual de x (inicializar en 1, multiplicar por x en cada iteracion). Llamar `EvaluarMonomio` en cada iteracion o acumular directamente multiplicando `coef[i] * x_pot` sin llamada auxiliar.

**Resolucion paso a paso**

**5a — Inv e InvertirArreglo:**
```asm
# Inv: a0=x → a0=-x  (funcion hoja, sin stack frame)
Inv:
    sub  a0, zero, a0
    ret

# InvertirArreglo: a0=ptr, a1=n → modifica arreglo in-place
InvertirArreglo:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)      # s0 = puntero actual
    sw   s1, 8(sp)      # s1 = contador

    mv   s0, a0
    mv   s1, a1

ia_loop:
    beq  s1, zero, ia_ret
    lw   a0, 0(s0)          # cargar elemento
    jal  ra, Inv            # a0 = -elemento
    sw   a0, 0(s0)          # guardar en su lugar
    addi s0, s0, 4          # avanzar 4 bytes (int32)
    addi s1, s1, -1
    j    ia_loop

ia_ret:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 16
    ret

# Test:
#   .data arr: .word 1, -2, 3, -4
#   li a0, arr; li a1, 4; jal ra, InvertirArreglo
#   → arr = [-1, 2, -3, 4]
```

**5b — EsPotenciaDeDos y PotenciasEnArreglo:**
```asm
# EsPotenciaDeDos: a0=x → 1 si x>0 y potencia de 2, 0 si no
# Truco: x & (x-1) == 0  ←→  exactamente un bit en 1
EsPotenciaDeDos:
    blez a0, epd_false          # x <= 0: no es potencia de 2
    addi t0, a0, -1
    and  t0, a0, t0             # x & (x-1)
    seqz a0, t0                 # 1 si resultado == 0
    ret
epd_false:
    li   a0, 0
    ret

# PotenciasEnArreglo: a0=ptr, a1=n → a0 = cantidad de potencias de 2
# Elementos: bytes sin signo (lbu, 1 byte cada uno)
PotenciasEnArreglo:
    addi sp, sp, -16
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = puntero
    sw   s1,  8(sp)     # s1 = contador de elementos restantes
    sw   s2, 12(sp)     # s2 = acumulador

    mv   s0, a0
    mv   s1, a1
    li   s2, 0

pea_loop:
    beq  s1, zero, pea_ret
    lbu  a0, 0(s0)          # cargar byte sin signo
    jal  ra, EsPotenciaDeDos
    add  s2, s2, a0         # sumar 0 o 1
    addi s0, s0, 1          # avanzar 1 byte
    addi s1, s1, -1
    j    pea_loop

pea_ret:
    mv   a0, s2
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    addi sp, sp, 16
    ret

# Tests EsPotenciaDeDos:
#   epd(1)=1, epd(2)=1, epd(4)=1, epd(8)=1
#   epd(0)=0, epd(3)=0, epd(6)=0, epd(-1)=0
# Test PotenciasEnArreglo:
#   arr = [1, 2, 3, 4, 5, 8] → 4 potencias (1,2,4,8)
```

**5c — EvaluarMonomio y EvaluarPolinomio:**
```asm
# EvaluarMonomio: a0=x, a1=c, a2=p → a0 = c * x^p
# Usa instruccion mul (extension M de RISC-V, disponible en Ripes)
EvaluarMonomio:
    addi sp, sp, -16
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = x
    sw   s1,  8(sp)     # s1 = c
    sw   s2, 12(sp)     # s2 = exponente restante / resultado parcial

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2
    li   t0, 1          # t0 = x^i (inicializar en x^0 = 1)

em_loop:
    beq  s2, zero, em_mul_c
    mul  t0, t0, s0     # t0 *= x
    addi s2, s2, -1
    j    em_loop

em_mul_c:
    mul  a0, s1, t0     # a0 = c * x^p
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    addi sp, sp, 16
    ret

# EvaluarPolinomio: a0=ptr_coef, a1=n, a2=x → a0 = P(x)
# P(x) = sum_{i=0}^{n-1} coef[i] * x^i
# Estrategia: mantener x^i en s4, actualizar en cada iteracion
EvaluarPolinomio:
    addi sp, sp, -32
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = ptr coeficientes
    sw   s1,  8(sp)     # s1 = n (limite)
    sw   s2, 12(sp)     # s2 = x
    sw   s3, 16(sp)     # s3 = indice i
    sw   s4, 20(sp)     # s4 = x^i
    sw   s5, 24(sp)     # s5 = acumulador P(x)

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2
    li   s3, 0          # i = 0
    li   s4, 1          # x^0 = 1
    li   s5, 0          # P(x) = 0

ep_loop:
    bge  s3, s1, ep_ret
    lw   t0, 0(s0)      # coef[i]
    mul  t0, t0, s4     # coef[i] * x^i
    add  s5, s5, t0     # P(x) += coef[i] * x^i
    mul  s4, s4, s2     # x^{i+1} = x^i * x
    addi s0, s0, 4      # avanzar puntero (4 bytes por int)
    addi s3, s3, 1
    j    ep_loop

ep_ret:
    mv   a0, s5
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    lw   s4, 20(sp)
    lw   s5, 24(sp)
    addi sp, sp, 32
    ret

# Test: coef=[3,-1,5,0,2], n=5, x=2
#   P(2) = 3 + (-1)*2 + 5*4 + 0*8 + 2*16 = 3-2+20+0+32 = 53
```

**Chuleta**
> **5a — InvertirArreglo (patron in-place):**
> `lw elem; jal Inv; sw resultado; addi ptr,4; addi cnt,-1; bne loop`
>
> **5b — EsPotenciaDeDos:**
> `blez → false; addi t0,a0,-1; and t0,a0,t0; seqz a0,t0`
>
> **5b — PotenciasEnArreglo (bytes):**
> `lbu elem; jal EsPotenciaDeDos; add acum,acum,a0; addi ptr,1`
>
> **5c — EvaluarPolinomio:**
> Mantener `x_pot = 1` y multiplicar por x en cada iteracion; `acum += coef[i] * x_pot`

**¿Aparece en parciales?**
- 5a: 🔴 Si → [[tipos_ejercicio/iteracion_arreglo_risc_v]] | [[tipos_ejercicio/convencion_llamada_risc_v]] | `inv + invertirArreglo` aparece directamente en [[parciales_analizados/2P_2C_2024]] Ej2.
- 5b: 🔴 Si → [[tipos_ejercicio/iteracion_arreglo_risc_v]] | patron `EsPar + arreglo_par` en [[parciales_analizados/2P_2C_2024_recuperatorio]] Ej2 es equivalente estructuralmente (funcion de clasificacion + recorrido de arreglo con conteo/filtrado).
- 5c: ⚪ No.

---

## Recursion

### Ejercicio 6 — Debuggear funciones recursivas

**Enunciado**
Dos programadores (A: funciones recursivas, B: tests) sin comunicacion. A dice seguir la convencion. Tests fallan. Para cada programa (incisos a–c):
- Comentar tests y funcion (que hace, nombre descriptivo).
- Marcar prologo, epilogo, caso base y definicion recursiva.
- Encontrar errores de convencion o uso incorrecto del stack.
- Arreglar y comprobar en Ripes.
- Para un caso de test: grafico del flujo del programa.

**Inciso a — Modulo recursivo**
Test: `mod(13, 5) = 3`. Funcion: `blt a0, a1, terminar; sub a2, a0, a1; jal FUNCION; ret`. Definicion: $mod(a, b) = mod(a-b, b)$ si $a \geq b$, sino $a$.
Errores: (1) `jal FUNCION` sin `ra` — no guarda la direccion de retorno → `jal FUNCION` en vez de `jal ra, FUNCION`. (2) No preserva `ra` en la pila (funcion no-leaf que llama recursivamente). (3) En la llamada recursiva, el argumento `a0` deberia ser `a2 = a0-a1` pero A hace `jal FUNCION` sin mover `a2` a `a0`.

**Inciso b — Fibonacci recursivo**
Test: `fib(4)=5, fib(5)=8, fib(6)=13`. Funcion calcula Fibonacci. Estructura con dos llamadas recursivas (Fibonacci clasico). Prologo guarda `a0` y `ra`. Epilogo carga `ra`.
Error en el epilogo: en los casos base `casoBase0` y `casoBase1` no se restaura `ra` antes de `ret` (saltan directamente al `ret` al final con `j prologo` pero la etiqueta `prologo` es el punto de restauracion de `ra` → analizar si el flujo de control es correcto para los casos base).

**Inciso c — Suma 0+1+...+n**
Test: `suma(4) = 10`. Funcion: `beq a0, zero, casoBase; push a0+ra; addi a0, a0, -1; jal FUNCION; lw a1, (0)sp; add a0, a1, a0; j prologo; casoBase: li a0, 0; lw ra, (4)sp; addi sp, sp, 8; ret`.
Error: en `casoBase` se restaura `ra` desde offset 4 pero `a0` (el n guardado) esta en offset 0 → en el caso base no hay n que restaurar, pero el epilogo siempre carga `ra` de sp+4. El problema es que `j prologo` en la rama recursiva salta al punto donde se restaura `ra` pero `a1` (el n guardado) ya fue sumado con el resultado — verificar que el offset de `ra` sea correcto y que el flujo del caso recursivo restaure correctamente antes de `ret`.

**Explicacion general**
Errores clasicos en recursion:
- No guardar `ra` (funcion hoja que no lo necesita vs. funcion recursiva que si).
- No guardar los argumentos (`a0`, `a1`) cuando se modifican para la llamada recursiva.
- Usar `jal LABEL` en vez de `jal ra, LABEL` (el primero no guarda PC+4 en ra).
- Casos base que saltan directamente a `ret` sin pasar por el epilogo de restauracion.

**Resolucion paso a paso**

**Inciso a — mod corregido:**
```asm
# mod(a, b): a0=a, a1=b → a0 = a mod b
# Caso base: a < b → retornar a  |  Recursivo: mod(a-b, b)
# Nota: es tail-recursive → podemos optimizar con j en vez de jal

mod:
    blt  a0, a1, mod_base       # caso base: a < b
    addi sp, sp, -16            # prologo: guardar ra y a1
    sw   ra, 0(sp)
    sw   a1, 4(sp)
    sub  a0, a0, a1             # a0 = a-b  ← correcto (no a2)
    jal  ra, mod                # ← corregido: jal RA, no jal a secas
    lw   ra, 0(sp)              # epilogo
    lw   a1, 4(sp)
    addi sp, sp, 16
mod_base:
    ret                         # a0 ya tiene el resultado

# Alternativa tail-call (mas eficiente para mod, que es tail-recursive):
mod_opt:
    blt  a0, a1, mod_opt_ret
    sub  a0, a0, a1
    j    mod_opt                # tail call: solo saltar, sin jal
mod_opt_ret:
    ret
```

**Inciso b — fib corregido (2 llamadas recursivas):**
```asm
# fib(n): a0=n → a0=F(n)  [F(0)=0, F(1)=1]
fib:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)      # s0 = n
    sw   s1, 8(sp)      # s1 = fib(n-1) (resultado parcial)

    mv   s0, a0

    beq  s0, zero, fib_b0   # caso base F(0) = 0
    li   t0, 1
    beq  s0, t0, fib_b1     # caso base F(1) = 1

    # Paso recursivo
    addi a0, s0, -1
    jal  ra, fib
    mv   s1, a0             # s1 = fib(n-1)

    addi a0, s0, -2
    jal  ra, fib
    add  a0, s1, a0         # fib(n-1) + fib(n-2)
    j    fib_ret

fib_b0: li a0, 0; j fib_ret
fib_b1: li a0, 1
    # CAER al epilogo (no saltar directo a ret sin restaurar ra)
fib_ret:                        # ← casos base DEBEN pasar por aqui
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 16
    ret
```

**Inciso c — suma corregido:**
```asm
# suma(n): a0=n → a0 = 0+1+...+n
suma:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)          # s0 = n (preservado en s-register)

    mv   s0, a0
    beq  s0, zero, suma_base

    addi a0, s0, -1
    jal  ra, suma           # suma(n-1) → a0
    add  a0, s0, a0         # n + suma(n-1)
    j    suma_ret

suma_base:
    li   a0, 0
suma_ret:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    addi sp, sp, 16
    ret
```

**Chuleta**
> **Estructura recursiva correcta:**
> ```
> funcion:
>     addi sp, sp, -16
>     sw ra, 0(sp)
>     sw s0, 4(sp)      # guardar argumento que se necesita post-llamada
>     mv s0, a0
>     beq s0, CONDICION_BASE, caso_base
>     # preparar a0 para llamada recursiva
>     jal ra, funcion   # ← siempre jal RA, no jal a secas
>     # usar s0 y a0 para combinar resultados
>     j ret_label
> caso_base:
>     li a0, VALOR_BASE
> ret_label:            # ← TODOS los caminos pasan por aqui
>     lw ra, 0(sp)
>     lw s0, 4(sp)
>     addi sp, sp, 16
>     ret
> ```

**¿Aparece en parciales?** ⚪ No — los parciales piden programar recursion, no debuggear.

---

### Ejercicio 7 — Conceptual: bytes de stack en Fibonacci

**Enunciado**
¿Cuantos bytes de espacio en el stack se utilizan para encontrar el quinto elemento de Fibonacci en la implementacion recursiva? ¿Cuantos para el n-esimo? ¿Cuantos bytes utiliza la implementacion iterativa?

**Explicacion**
Fibonacci recursivo clasico tiene dos llamadas recursivas. Para `fib(5)`:
- El arbol de recursion tiene profundidad maxima 5 (la rama mas profunda: fib(5)→fib(4)→fib(3)→fib(2)→fib(1)).
- Cada frame guarda `a0` y `ra` → 8 bytes por frame.
- Profundidad maxima de la pila = 5 frames = 40 bytes.

En general para `fib(n)`: profundidad maxima = n, bytes en stack maximos = $8n$.

Fibonacci iterativo: no realiza llamadas recursivas → 0 bytes en stack (si es funcion hoja). Si usa prologo/epilogo: 8 bytes fijos (1 frame) independientemente de n.

**Resolucion paso a paso**

**Analisis de la implementacion recursiva:**

Cada llamada a `fib` guarda `ra` + `s0` = 8 bytes (en frame de 16 bytes con 8 bytes sin usar, pero el SP se decrementa en 16 por alineacion). Sin embargo si solo guardamos `ra` + 1 registro s, el frame minimo con alineacion es 16 bytes.

Profundidad maxima del stack call para `fib(n)`:
- La rama mas profunda es `fib(n) → fib(n-1) → ... → fib(1)` = n niveles
- Bytes maximos en stack = $16n$ bytes (con frames de 16 bytes)

Para `fib(5)`: $16 \times 5 = 80$ bytes maximos simultaneos en el stack.

Con frame de 8 bytes (si solo guardamos ra + a0, sin padding extra): $8 \times 5 = 40$ bytes.

> ⚠️ Verificar — el enunciado espera la respuesta con frame de 8 bytes (ra + a0 = 2 words). Si el frame usa 16 bytes por alineacion, la respuesta es 80. En el contexto de la guia, la respuesta esperada es 40 bytes (8 bytes/frame).

**Respuesta formal:**

| Implementacion | Bytes en stack para fib(5) | Bytes para fib(n) |
|---|---|---|
| Recursiva (frame 8B) | $8 \times 5 = 40$ bytes | $8n$ bytes |
| Recursiva (frame 16B con alineacion) | $16 \times 5 = 80$ bytes | $16n$ bytes |
| Iterativa (funcion hoja) | 0 bytes | 0 bytes |
| Iterativa (con prologo/epilogo) | 16 bytes fijos | 16 bytes fijos |

**Chuleta**
> - Recursion: stack crece con la profundidad del arbol, no con el total de nodos
> - Profundidad maxima fib(n) = n (por la rama izquierda fib(n-1)→fib(n-2)→...→fib(1))
> - Iterativo: O(1) en stack (sin importar n)
> - Truco: `bytes = bytes_por_frame × profundidad_maxima`

**¿Aparece en parciales?** ⚪ No — pregunta de analisis de espacio no vista en parciales.

---

### Ejercicio 8 — Programar funciones recursivas

**Enunciado**
Programar en RISC-V con al menos 2 casos de test (convencion estandar):

**a) Factorial:**
$$fact(x) = \begin{cases} 1 & \text{si } x = 0 \\ x \cdot fact(x-1) & \text{si no} \end{cases}$$

**b) Profundidad de Collatz:**
Segun la conjetura de Collatz, aplicando
$$f(n) = \begin{cases} n/2 & \text{si n es par} \\ 3n+1 & \text{si n es impar} \end{cases}$$
con suficientes repeticiones se llega a 1. Implementar `EsPar(n)` (retorna 1 si par, 0 si impar), luego una funcion que dado $n$ retorna la cantidad de pasos $f$ para llegar a 1. $Pc(1)=0$, $Pc(6)=8$.

**c) Fibonacci 3:**
$$F_3(x) = \begin{cases} 0 & \text{si } x = 0 \\ 1 & \text{si } x = 1 \\ 2 & \text{si } x = 2 \\ F_3(x-1) + F_3(x-2) + F_3(x-3) & \text{si no} \end{cases}$$

**d) Fibonacci n:**
$$F_n(x) = \begin{cases} x & \text{si } x < n \\ \sum_{i=1}^{n} F_n(x-i) & \text{si no} \end{cases}$$
donde $n$ es un argumento adicional de la funcion.

**e) Raiz de funcion lineal por biseccion:**
Dados `min`, `max` y un puntero a funcion lineal $f$: retornar 0 si no hay raiz en $[min, max]$, o la raiz si existe. Usar `jalr` para llamar la funcion por puntero. Usar el metodo de biseccion.

**Explicacion**

**8a (Factorial):** estructura recursiva simple (una llamada recursiva). Caso base: a0=0 → retornar 1. Paso recursivo: `push a0+ra; addi a0, a0, -1; jal ra, fact; lw a1, 0(sp); mul a0, a1, a0; pop`.

**8b (Collatz):** `EsPar`: `andi a0, a0, 1; xori a0, a0, 1` (1 si par). Funcion principal: caso base a0=1 → retornar 0. Llamar EsPar. Si par: `addi a0, a0, 0; srai a0, a0, 1` (a0/2). Si impar: `slli t0, a0, 1; add a0, a0, t0; addi a0, a0, 1` (3n+1). Recursion + 1.

**8c (Fibonacci3):** tres casos base, tres llamadas recursivas, dos registros s para preservar los dos primeros resultados parciales.

**8d (FibonacciN):** generalizar 8c. Recibir n en a1. Caso base: a0 < a1 → retornar a0. Paso recursivo: loop de i=1..n haciendo llamadas Fn(x-i) y acumulando. Requiere preservar n (en s), el acumulador (en s), y el indice del loop.

**8e (biseccion):** para funcion lineal $f$, la raiz es donde $f$ cambia de signo. Biseccion: `mid = (min+max)/2; if f(mid)==0: return mid; if f(min)*f(mid)<0: return biseccion(min, mid); else return biseccion(mid, max)`. Llamar $f$ con `jalr ra, a2, 0` (donde a2 = puntero a funcion). Para funcion lineal, la biseccion converge en $O(\log(max-min))$ pasos.

**Resolucion paso a paso**

**8a — Factorial:**
```asm
# fact: a0=n → a0 = n!   [fact(0)=1, fact(n)=n*fact(n-1)]
fact:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)      # s0 = n

    mv   s0, a0
    blez s0, fact_base  # n <= 0 → 1

    addi a0, s0, -1
    jal  ra, fact       # fact(n-1) → a0
    mul  a0, s0, a0     # n * fact(n-1)
    j    fact_ret

fact_base:
    li   a0, 1
fact_ret:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    addi sp, sp, 16
    ret

# Tests: fact(0)=1, fact(1)=1, fact(4)=24, fact(5)=120
```

**8b — EsPar y Collatz:**
```asm
# EsPar: a0=n → 1 si par, 0 si impar (funcion hoja)
EsPar:
    andi a0, a0, 1      # bit0: 0=par, 1=impar
    xori a0, a0, 1      # invertir
    ret

# Collatz: a0=n → pasos para llegar a 1
# Pc(1)=0, Pc(n par)=1+Pc(n/2), Pc(n impar)=1+Pc(3n+1)
Collatz:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)      # s0 = n

    mv   s0, a0
    li   t0, 1
    beq  s0, t0, col_base   # n=1 → 0 pasos

    jal  ra, EsPar          # a0 = EsPar(s0)
    beq  a0, zero, col_impar

    # Par: siguiente = n/2
    srai a0, s0, 1
    j    col_rec

col_impar:
    # Impar: siguiente = 3*n + 1
    slli t0, s0, 1      # 2n
    add  a0, t0, s0     # 3n
    addi a0, a0, 1      # 3n+1

col_rec:
    jal  ra, Collatz    # Collatz(siguiente) → a0
    addi a0, a0, 1      # 1 + Pc(siguiente)
    j    col_ret

col_base:
    li   a0, 0
col_ret:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    addi sp, sp, 16
    ret

# Tests: Pc(1)=0, Pc(2)=1, Pc(6)=8, Pc(3)=7
```

**8c — Fibonacci3:**
```asm
# F3: a0=x → F3(x)  [3 casos base, 3 llamadas recursivas]
F3:
    addi sp, sp, -16
    sw   ra, 0(sp)
    sw   s0, 4(sp)      # s0 = x
    sw   s1, 8(sp)      # s1 = acumulador parcial

    mv   s0, a0

    li   t0, 0; beq s0, t0, f3_b0
    li   t0, 1; beq s0, t0, f3_b1
    li   t0, 2; beq s0, t0, f3_b2

    # F3(x-1)
    addi a0, s0, -1
    jal  ra, F3
    mv   s1, a0             # s1 = F3(x-1)

    # F3(x-2)
    addi a0, s0, -2
    jal  ra, F3
    add  s1, s1, a0         # s1 += F3(x-2)

    # F3(x-3)
    addi a0, s0, -3
    jal  ra, F3
    add  a0, s1, a0         # F3(x-1) + F3(x-2) + F3(x-3)
    j    f3_ret

f3_b0: li a0, 0; j f3_ret
f3_b1: li a0, 1; j f3_ret
f3_b2: li a0, 2
f3_ret:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 16
    ret

# Tests: F3(0)=0, F3(1)=1, F3(2)=2, F3(3)=3, F3(4)=6, F3(5)=11
```

**8d — FibonacciN:**
```asm
# FN: a0=x, a1=n → F_n(x)
# Caso base: x < n → retornar x
# Recursivo: sum_{i=1}^{n} FN(x-i, n)
FN:
    addi sp, sp, -32
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = x
    sw   s1,  8(sp)     # s1 = n
    sw   s2, 12(sp)     # s2 = acumulador
    sw   s3, 16(sp)     # s3 = i (indice del loop)

    mv   s0, a0
    mv   s1, a1
    li   s2, 0
    li   s3, 1          # i = 1

    blt  s0, s1, fn_base    # x < n: retornar x

fn_loop:
    bgt  s3, s1, fn_ret_acc  # i > n: terminar
    sub  a0, s0, s3           # a0 = x - i
    mv   a1, s1               # a1 = n
    jal  ra, FN
    add  s2, s2, a0           # acumular
    addi s3, s3, 1
    j    fn_loop

fn_ret_acc:
    mv   a0, s2
    j    fn_fin

fn_base:
    mv   a0, s0     # retornar x

fn_fin:
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    addi sp, sp, 32
    ret

# Verificacion: FN(x,2) = fib_iter(x), FN(x,3) = F3(x)
```

**8e — Biseccion con jalr:**
```asm
# biseccion: a0=min, a1=max, a2=ptr_f → raiz o 0 si no hay
# Precondicion: f es lineal, f(min)*f(max) <= 0
biseccion:
    addi sp, sp, -32
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = min
    sw   s1,  8(sp)     # s1 = max
    sw   s2, 12(sp)     # s2 = ptr_f
    sw   s3, 16(sp)     # s3 = f(min)
    sw   s4, 20(sp)     # s4 = mid

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2

    # Caso base: min >= max → sin raiz entera
    bge  s0, s1, bis_noraiz

    # Calcular f(min) y verificar
    mv   a0, s0
    jalr ra, s2, 0      # llamar f(min) via puntero
    mv   s3, a0         # s3 = f(min)

    # mid = (min + max) / 2
    add  s4, s0, s1
    srai s4, s4, 1

    mv   a0, s4
    jalr ra, s2, 0      # f(mid) → a0
    beq  a0, zero, bis_found    # raiz exacta en mid

    # Determinar mitad: si f(min) y f(mid) tienen signos opuestos
    xor  t0, s3, a0     # bit31=1 si signos opuestos
    blt  t0, zero, bis_left     # raiz en [min, mid]

    # Raiz en [mid+1, max]
    addi a0, s4, 1
    mv   a1, s1
    mv   a2, s2
    jal  ra, biseccion
    j    bis_ret

bis_left:
    mv   a0, s0
    mv   a1, s4
    mv   a2, s2
    jal  ra, biseccion
    j    bis_ret

bis_found:
    mv   a0, s4
    j    bis_ret

bis_noraiz:
    li   a0, 0
bis_ret:
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    lw   s4, 20(sp)
    addi sp, sp, 32
    ret
```

**Chuleta**
> **Factorial (recursion simple):**
> `mv s0,a0; blez s0,base; addi a0,s0,-1; jal ra,fact; mul a0,s0,a0`
>
> **Fibonacci3 (3 llamadas, 2 resultados parciales):**
> `F3(x-1)→s1; F3(x-2)→add s1; F3(x-3)→add a0`
>
> **Collatz (llamada a EsPar antes de decidir):**
> `jal EsPar; si par: srai a0,n,1; si impar: slli+add+addi = 3n+1`
>
> **jalr para puntero a funcion:**
> `jalr ra, registro_ptr, 0`  — guarda PC+4 en ra y salta a la direccion en registro_ptr

**¿Aparece en parciales?**
- 8a: 🔴 Si → [[tipos_ejercicio/funcion_recursiva_risc_v]] | patron recursion en 2P: [[parciales_analizados/2P_2C_2024_recuperatorio]] Ej1 (es_primo + cantidad_divisores con recursion mutua), [[parciales_analizados/2P_2C_2024]] Ej1 (Pascal recursivo).
- 8c: 🔴 Si → [[tipos_ejercicio/funcion_recursiva_risc_v]] | patron Fibonacci recursivo con multiples casos base aparece en forma generalizada en varios parciales historicos rotulados 2P — hoy material de tu **parcial unico**.
- 8b, 8d, 8e: ⚪ No — no vistos en parciales.

---

## Manejo de Estructuras

### Ejercicio 9 — Struct InformacionAlumno

**Enunciado**
Estructura `InformacionAlumno`: ID del alumno (sin signo, 16 bits) + nota en el ultimo examen (sin signo, 8 bits).

Disposicion en memoria:
| Direccion | 0x0000 | 0x0002 | 0x0003 | 0x0005 | ... | 0x0030 | 0x0032 | 0x0033 |
|---|---|---|---|---|---|---|---|---|
| Valor | 5492 | 1 | 8886 | 6 | ... | 6540 | 10 | 0 |

El final del arreglo esta marcado por un ID nulo (0).

Se pide:
1. Calcular cuantos bytes ocupa `InformacionAlumno` en memoria.
2. Escribir una funcion que dado un puntero al arreglo, devuelva la suma de las notas de los alumnos con ID impar.
3. Escribir un caso de test.

Ayuda para crear el arreglo en Ripes:
```asm
.data
tablaCalificaciones:
    .half 5523
    .byte 3
    .half 8754
    .byte 6
    ...
    .half 0    # fin del arreglo
```

**Explicacion**
Tamaño del struct: `half` (2 bytes) + `byte` (1 byte) = 3 bytes por elemento. Sin padding (puede variar segun alineacion, pero en este caso es contiguo segun los offsets del enunciado: `0x0000`→ID, `0x0002`→nota, `0x0003`→proximo ID).

Patron de recorrido: loop con centinela (ID==0 termina). Por cada elemento:
- Cargar ID: `lhu t0, 0(a0)` (half sin signo).
- Verificar centinela: `beq t0, zero, fin`.
- Verificar paridad de ID: `andi t1, t0, 1; beq t1, zero, saltar` (si par, saltar).
- Si impar: cargar nota con `lbu t1, 2(a0)` y acumular.
- Avanzar puntero: `addi a0, a0, 3`.

**Resolucion paso a paso**

**Parte 1 — Tamaño del struct:**
$$\text{InformacionAlumno} = \underbrace{2 \text{ bytes}}_{\text{ID (half)}} + \underbrace{1 \text{ byte}}_{\text{nota (byte)}} = 3 \text{ bytes}$$

Sin padding (confirmado por offsets del enunciado: ID en +0, nota en +2, siguiente ID en +3).

**Parte 2 — Funcion sumaNotasIDImpar:**
```asm
# sumaNotasIDImpar: a0=ptr_tabla → a0=suma de notas con ID impar
# Struct: offset 0 = ID (half, 2 bytes); offset 2 = nota (byte, 1 byte)
# Centinela: ID == 0 marca fin del arreglo

sumaNotasIDImpar:
    addi sp, sp, -16
    sw   s0, 0(sp)      # s0 = puntero actual
    sw   s1, 4(sp)      # s1 = acumulador
    sw   ra, 8(sp)

    mv   s0, a0
    li   s1, 0

snia_loop:
    lhu  t0, 0(s0)              # t0 = ID (half sin signo)
    beq  t0, zero, snia_ret     # centinela: ID=0 → fin
    andi t1, t0, 1              # t1 = bit0 del ID
    beq  t1, zero, snia_skip   # ID par → saltar
    lbu  t2, 2(s0)              # nota en offset +2
    add  s1, s1, t2             # acumular
snia_skip:
    addi s0, s0, 3              # avanzar 3 bytes al siguiente struct
    j    snia_loop

snia_ret:
    mv   a0, s1
    lw   s0, 0(sp)
    lw   s1, 4(sp)
    lw   ra, 8(sp)
    addi sp, sp, 16
    ret
```

**Parte 3 — Caso de test:**
```asm
.data
tabla:
    .half 5492   # ID=5492 (par) → no suma
    .byte 1      # nota=1
    .half 8887   # ID=8887 (impar) → suma nota
    .byte 6      # nota=6
    .half 101    # ID=101 (impar) → suma nota
    .byte 9      # nota=9
    .half 0      # centinela

.text
    la   a0, tabla
    jal  ra, sumaNotasIDImpar
    # a0 deberia ser 6 + 9 = 15
```

**Chuleta**
> **Patron struct con centinela:**
> 1. Cargar campo centinela: `lhu/lw t0, 0(ptr)`
> 2. Si centinela: `beq t0, zero, fin`
> 3. Verificar condicion: `andi t1, campo, 1; beq/bne t1, zero, skip`
> 4. Cargar campo a procesar: `lbu/lh reg, OFFSET(ptr)`
> 5. Acumular
> 6. Avanzar: `addi ptr, ptr, TAMAÑO_STRUCT`
>
> **Tamaños de instruccion de carga:**
> `lb`/`lbu` = 1 byte | `lh`/`lhu` = 2 bytes | `lw` = 4 bytes

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/structs_y_memoria_risc_v]] | patron struct + centinela + condicion sobre campo:
- [[parciales_analizados/2P_2C_2024]] Ej3: struct `BalanceDeudor` (acceso con `lbu`/`lh` por offset, centinela ID nulo, condicion sobre campo).
- [[parciales_analizados/2P_2C_2024_recuperatorio]] Ej3: misma estructura.
- [[parciales_analizados/2P_1C_2025]] Ej2: array de structs con condicion.

---

### Ejercicio 10 — Lista enlazada

**Enunciado**
Lista enlazada de nodos: cada nodo contiene un valor de 32 bits en C2 + puntero al siguiente nodo (32 bits). El ultimo nodo tiene puntero nulo (0). La raiz apunta al primer nodo (si es nula, la lista esta vacia).

Ejemplo: Raiz → 4 → -23 → 6 → 2

Se pide:
1. Calcular cuantos bytes ocupa un nodo. ¿Cuanto ocupa una lista de n elementos?
2. Escribir una funcion que dado un puntero a la raiz, devuelva la suma de los valores.

Ayuda para crear en Ripes (en orden inverso):
```asm
.data
nodo_4: .word -1, 0x0
nodo_3: .word 6, nodo_4
nodo_2: .word 3, nodo_3
nodo_1: .word -2, nodo_2
raiz:   .word nodo_1
```

**Explicacion**
Tamaño del nodo: `word` (4 bytes) + puntero (4 bytes) = 8 bytes por nodo. Lista de n elementos: $8n$ bytes.

Patron de recorrido de lista enlazada:
```
a0 = raiz (puntero)
acum = 0
loop:
  if a0 == 0: break (lista vacia o fin)
  valor = lw 0(a0)      # offset 0: valor
  acum += valor
  a0 = lw 4(a0)         # offset 4: puntero al siguiente
  goto loop
return acum
```

**Resolucion paso a paso**

**Parte 1 — Tamaño:**
$$\text{Nodo} = \underbrace{4 \text{ bytes}}_{\text{valor (word)}} + \underbrace{4 \text{ bytes}}_{\text{puntero}} = 8 \text{ bytes}$$

Lista de n nodos: $8n$ bytes.

**Parte 2 — sumaLista:**
```asm
# sumaLista: a0=raiz → a0 = suma de valores
# Nodo: offset 0 = valor (word, 4B); offset 4 = ptr siguiente (word, 4B)

sumaLista:
    addi sp, sp, -16
    sw   s0, 0(sp)      # s0 = puntero al nodo actual
    sw   s1, 4(sp)      # s1 = acumulador
    sw   ra, 8(sp)

    mv   s0, a0
    li   s1, 0

sl_loop:
    beq  s0, zero, sl_ret   # puntero nulo: fin de lista
    lw   t0, 0(s0)          # valor del nodo (offset 0)
    add  s1, s1, t0         # acumular
    lw   s0, 4(s0)          # s0 = puntero al siguiente (offset 4)
    j    sl_loop

sl_ret:
    mv   a0, s1
    lw   s0, 0(sp)
    lw   s1, 4(sp)
    lw   ra, 8(sp)
    addi sp, sp, 16
    ret

# Test con el ejemplo del enunciado:
#   Raiz → 4 → -23 → 6 → 2 → null
#   sumaLista(raiz) = 4 + (-23) + 6 + 2 = -11
```

**Chuleta**
> **Recorrido de lista enlazada:**
> `while ptr != 0: valor = lw 0(ptr); acum += valor; ptr = lw 4(ptr)`
>
> **Offsets del nodo:** valor en +0, siguiente en +4 (ambos word = 4 bytes)

**¿Aparece en parciales?** ⚪ No — listas enlazadas no vistas en los parciales historicos rotulados 2P (material que con el programa vigente entra en tu **parcial unico**).

---

### Ejercicio 11 — Struct ArregloOrdenado con busqueda binaria

**Enunciado**
Estructura `ArregloOrdenado`: puntero a arreglo de enteros sin signo de 16 bits (ordenado) + dimension del arreglo (entero C2 de 32 bits). Si dimension=0, el puntero es nulo.

Ejemplo:
```
ArregloOrdenado:
  puntero → 0x10000018  (4 bytes)
  dimension = 4         (4 bytes)

Arreglo en 0x10000018: [2, 54, 1000, 2500]
```

Se pide:
1. Calcular cuantos bytes ocupa `ArregloOrdenado` en su conjunto (incluyendo el arreglo asociado).
2. Escribir una funcion que dado un puntero a `ArregloOrdenado` y un valor, realice busqueda binaria y retorne el indice del valor o -1 si no esta. Implementar de forma recursiva e iterativa.

**Explicacion**
Tamaño de la estructura: 4 bytes (puntero) + 4 bytes (dimension) = 8 bytes. El arreglo asociado: $n \times 2$ bytes (half por elemento, n = dimension). Total: $8 + 2n$ bytes.

Busqueda binaria:
- Acceder al arreglo: `lw t0, 0(a0)` (puntero al arreglo); `lw t1, 4(a0)` (dimension).
- Cargar elemento mid: `lhu t2, 0(t0 + mid*2)` → `slli t3, mid, 1; add t3, t0, t3; lhu t2, 0(t3)`.
- Comparar y ajustar limites.

Recursiva: recibir `ptr_struct, valor, left, right` como argumentos. Caso base: left > right → retornar -1.
Iterativa: loop while left <= right, ajustar mid en cada iteracion.

**Resolucion paso a paso**

**Parte 1 — Tamaño:**
$$\text{ArregloOrdenado (estructura)} = 4 + 4 = 8 \text{ bytes}$$
$$\text{ArregloOrdenado (total con datos)} = 8 + 2n \text{ bytes} \quad (n = \text{dimension})$$

**Parte 2 — Busqueda binaria recursiva:**
```asm
# binSearch_rec: a0=ptr_struct, a1=valor, a2=left, a3=right → a0=indice o -1
# ArregloOrdenado: offset 0 = ptr arreglo (word), offset 4 = dimension (word)
# Elementos: half sin signo (2 bytes), acceso con lhu

binSearch_rec:
    addi sp, sp, -32
    sw   ra,  0(sp)
    sw   s0,  4(sp)     # s0 = ptr_struct
    sw   s1,  8(sp)     # s1 = valor buscado
    sw   s2, 12(sp)     # s2 = left
    sw   s3, 16(sp)     # s3 = right
    sw   s4, 20(sp)     # s4 = mid

    mv   s0, a0
    mv   s1, a1
    mv   s2, a2
    mv   s3, a3

    bgt  s2, s3, bs_notfound    # left > right → -1

    add  s4, s2, s3
    srai s4, s4, 1              # mid = (left + right) / 2

    # arreglo[mid]: ptr_arreglo + mid*2
    lw   t0, 0(s0)              # t0 = ptr al arreglo
    slli t1, s4, 1              # t1 = mid * 2
    add  t1, t0, t1             # t1 = &arreglo[mid]
    lhu  t2, 0(t1)              # t2 = arreglo[mid] (half sin signo)

    beq  t2, s1, bs_found
    blt  t2, s1, bs_right       # arreglo[mid] < valor: ir a la derecha

    # Buscar en [left, mid-1]
    mv   a0, s0
    mv   a1, s1
    mv   a2, s2
    addi a3, s4, -1
    jal  ra, binSearch_rec
    j    bs_ret

bs_right:
    mv   a0, s0
    mv   a1, s1
    addi a2, s4, 1
    mv   a3, s3
    jal  ra, binSearch_rec
    j    bs_ret

bs_found:
    mv   a0, s4
    j    bs_ret

bs_notfound:
    li   a0, -1
bs_ret:
    lw   ra,  0(sp)
    lw   s0,  4(sp)
    lw   s1,  8(sp)
    lw   s2, 12(sp)
    lw   s3, 16(sp)
    lw   s4, 20(sp)
    addi sp, sp, 32
    ret

# Wrapper para llamar con left=0, right=n-1:
binSearch: # a0=ptr_struct, a1=valor → a0=indice o -1
    lw   a3, 4(a0)      # a3 = dimension
    addi a3, a3, -1     # right = n-1
    li   a2, 0          # left = 0
    j    binSearch_rec
```

**Busqueda binaria iterativa:**
```asm
# binSearch_iter: a0=ptr_struct, a1=valor → a0=indice o -1
# Funcion hoja (no usa s-registers, no llama funciones)
binSearch_iter:
    lw   t0, 0(a0)      # t0 = ptr al arreglo
    lw   t1, 4(a0)      # t1 = dimension
    li   t2, 0          # left = 0
    addi t3, t1, -1     # right = n-1

bsi_loop:
    bgt  t2, t3, bsi_notfound   # left > right: fin
    add  t4, t2, t3
    srai t4, t4, 1              # mid = (left+right)/2
    slli t5, t4, 1
    add  t5, t0, t5
    lhu  t5, 0(t5)              # arreglo[mid]

    beq  t5, a1, bsi_found
    blt  t5, a1, bsi_right
    addi t3, t4, -1             # right = mid - 1
    j    bsi_loop

bsi_right:
    addi t2, t4, 1              # left = mid + 1
    j    bsi_loop

bsi_found:
    mv   a0, t4
    ret
bsi_notfound:
    li   a0, -1
    ret

# Test: arr=[2,54,1000,2500], buscar 54 → indice 1; buscar 100 → -1
```

**Chuleta**
> **Acceso a arreglo de halfs (16-bit):**
> `lw t_arr, 0(ptr_struct); slli idx2, idx, 1; add t_elem, t_arr, idx2; lhu val, 0(t_elem)`
>
> **Biseccion:**
> `mid = (left+right)/2 = srai (left+right), 1`
> `arr[mid] < buscado → left = mid+1`
> `arr[mid] > buscado → right = mid-1`
> `arr[mid] == buscado → retornar mid`
> `left > right → retornar -1`

**¿Aparece en parciales?** ⚪ No — busqueda binaria no vista en los parciales historicos rotulados 2P (material que con el programa vigente entra en tu **parcial unico**).

---

## Ver tambien

- [[arquitectura_teoria_pt2]] — ABI RISC-V completo: argumentos, caller-saved/callee-saved, stack frame, recursion
- [[arquitectura_teoria_pt1]] — ISA RISC-V: instrucciones, tipos de instruccion, ciclo fetch-decode-execute
- [[programacion_risc_v_guia]] — Practica 3 (Ej 8–15): programacion a nivel de registros sin ABI
- [[parciales_analizados/2P_2C_2024]] — Ej2: inv+invertirArreglo (Ej5a), Ej1: recursion Pascal (patron Ej8), Ej3: struct BalanceDeudor (patron Ej9)
- [[parciales_analizados/2P_2C_2024_recuperatorio]] — Ej1: recursion mutua (patron Ej8), Ej2: arreglo_par (patron Ej5b), Ej3: struct con centinela (patron Ej9)
- [[parciales_analizados/2P_1C_2025]] — Ej1: recursion RISC-V, Ej2: array de structs
