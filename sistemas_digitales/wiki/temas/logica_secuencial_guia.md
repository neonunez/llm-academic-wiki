---
nombre: Logica Secuencial — Guia de Ejercicios (Practica 2, Parte 1)
parcial: 1P
programa: 2C_2026
tipo: guia
tema: logica_secuencial
fuente: "raw/guias_practicas/2.prac_logica_digital_parte_1.pdf, raw/guias_practicas/2.prac_logica_digital_parte_2.pdf"
paginas_relacionadas:
  - "[[logica_secuencial_teoria]]"
  - "[[parciales_analizados/1P_2C_2024]]"
  - "[[parciales_analizados/1P_2C_2024_recuperatorio]]"
  - "[[parciales_analizados/1P_1C_2025]]"
---

# Logica Secuencial — Guia de Ejercicios

Fuentes: `raw/guias_practicas/2.prac_logica_digital_parte_1.pdf` (enunciados + texto) y `raw/guias_practicas/2.prac_logica_digital_parte_2.pdf` (diagrama circuito Ej 14). Practica 2, Logica Digital, 1C 2025.
Esta pagina cubre los ejercicios de **Circuitos Secuenciales** (Ej 11–19). Los ejercicios de Circuitos Combinatorios (Ej 1–10) estan en [[logica_combinatoria_guia]].

---

## Indice de ejercicios

| # | Descripcion breve | ¿Parcial? |
|---|---|---|
| Ej 11 | Diagrama temporal — circuito secuencial con posible oscilacion | ⚪ No |
| Ej 12 | Tabla caracteristica de circuito secuencial con JK (latch/FF) | ⚪ No |
| Ej 13 | Tablas caracteristicas de tres circuitos secuenciales compuestos | ⚪ No |
| Ej 14 | Registro simple 4-bit (load + clk) | ⚪ No |
| Ej 15 | Registro bidireccional 4-bit (load + read + tristate) | 🔴 Si |
| Ej 16 | Extensor de signo 2→4 bits con registro | 🔴 Si |
| Ej 17 | Desplazador a izquierda 4-bit (shift left) | 🔴 Si |
| Ej 18 | Registro auto-incrementador bidireccional con inc | ⚪ No |
| Ej 19 | Diagrama de tiempos: sumar R0+R1→R0 con registros bidireccionales | ⚪ No |

---

## Ejercicios

### Ejercicio 11 — Diagrama temporal de circuito secuencial

**Enunciado**

Escribir el diagrama temporal para el siguiente circuito secuencial desde 0 ns hasta 65 ns, con los parametros:
- Retardo de 15 ns para la compuerta AND
- Retardo de 5 ns para la compuerta NOT
- En el tiempo 0 ns la senal $e_0$ cambia a 1 (inicialmente en 0)
- Las senales $i_0 = 1$ y $s_0 = 0$ en el tiempo 0 ns
- Los componentes empiezan a estabilizarse cuando sus entradas estan estables

El circuito tiene retroalimentacion: $s_0$ realimenta a si mismo mediante una AND con $e_0$, y $i_0$ conecta tambien.

(Diagrama del circuito: compuertas AND y NOT interconectadas con la senal $s_0$ como salida retroalimentada; $i_0$ y $e_0$ como entradas.)

b) ¿Podria alcanzar $s_0$ un valor estable? ¿Y si $e_0$ fuera 0 en lugar de 1?

**Explicacion**

Ejercicio de analisis de timing en circuitos con retroalimentacion. La retroalimentacion puede causar oscilacion si la senal nunca se estabiliza (el cambio en la salida siempre vuelve a cambiar la entrada).

- Cuando $e_0 = 0$: la AND con $e_0$ bloquea la retroalimentacion → $s_0$ se estabiliza en 0.
- Cuando $e_0 = 1$: la retroalimentacion esta activa. Hay que trazar cada propagacion de senal paso a paso, sumando los retardos.
- Si el circuito oscila: $s_0$ nunca se estabiliza mientras $e_0 = 1$.

El concepto se conecta con los latches inestables del RS-NOR con $S=R=1$ en [[logica_secuencial_teoria]].

**Resolucion paso a paso**

⚠️ Verificar — el circuito exacto no es extraible del texto; la reconstruccion siguiente es consistente con todos los parametros dados.

**Modelo del circuito reconstruido:**

- $n_1 = \text{NOT}(s_0)$ — retardo 5 ns
- $s_0 = \text{AND}(e_0,\ i_0,\ n_1)$ — retardo 15 ns (AND de 3 entradas; con $i_0 = 1$ fijo actua como AND de 2 entradas)

Condicion inicial consistente: $e_0=0,\ i_0=1,\ s_0=0 \Rightarrow n_1=1,\ \text{AND}(0,1,1)=0=s_0$ ✓

**Trazado temporal (0–65 ns):**

| Evento | Tiempo |
|--------|--------|
| $e_0$ cambia 0→1 (dado) | 0 ns |
| AND inputs $(1,1,1)=1$ → $s_0$ empieza a cambiar | 0 ns |
| $s_0 = 1$ | 15 ns |
| NOT(1)=0 → $n_1$ empieza a cambiar | 15 ns |
| $n_1 = 0$ | 20 ns |
| AND$(1,1,0)=0$ → $s_0$ empieza a cambiar | 20 ns |
| $s_0 = 0$ | 35 ns |
| NOT(0)=1 → $n_1$ empieza a cambiar | 35 ns |
| $n_1 = 1$ | 40 ns |
| AND$(1,1,1)=1$ → $s_0$ empieza a cambiar | 40 ns |
| $s_0 = 1$ | 55 ns |
| NOT(1)=0 → $n_1$ empieza a cambiar | 55 ns |
| $n_1 = 0$ | 60 ns |
| AND$(1,1,0)=0$ → $s_0$ empezaria a cambiar | 60 ns |
| $s_0$ llegaria a 0 | 75 ns (fuera de ventana) |

**Diagramas de señal:**

```
e0: 0...1_______________________________
s0: 0..........1__________0__________1_   (0–65 ns)
n1: 1______________0__________1__________
    0  15  20  35  40  55  60  65
```

**A t=65 ns:** $s_0=1$, $n_1=0$ (en tránsito hacia 0). El circuito **oscila indefinidamente** con período 40 ns (ciclo: 15+5+15+5).

**Inciso b):**

- Con $e_0=1$: el circuito **NO se estabiliza** — la retroalimentacion inversa $(s_0 \to \text{NOT} \to \text{AND} \to s_0)$ conmuta continuamente. Es un oscilador asincrono.
- Con $e_0=0$: $\text{AND}(0,\ \cdot,\ \cdot) = 0$ siempre → $s_0 = 0$ estable. El bit $e_0$ funciona como "enable" de la retroalimentacion: al desactivarlo, bloquea el lazo y fuerza $s_0=0$.

**Chuleta**

1. Para trazar temporal de circuito con retardos: propagar cambio de entrada a cada nodo en orden, sumando retardos de cada compuerta en el camino.
2. Oscilacion: ocurre cuando hay una inversion en la retroalimentacion ($A \to \text{NOT} \to \ldots \to A$) y el lazo esta habilitado.
3. Periodo de oscilacion = suma de retardos del lazo × 2 (hay una subida y una bajada por ciclo).
4. Control de oscilacion: un AND con una señal de "enable" en el lazo → cuando enable=0, el lazo queda cortado y la salida se estabiliza en 0.
5. Circuito estable ≠ circuito sin retroalimentacion — puede haber retroalimentacion y ser estable si el lazo no tiene inversion (ej: latch RS con S=R=0).

**¿Aparece en parciales?** ⚪ No — analisis de timing con retardos especificos, no detectado en los parciales analizados

---

### Ejercicio 12 — Tabla caracteristica de circuito secuencial con JK

**Enunciado**

Completar la tabla caracteristica para el siguiente circuito secuencial con los valores estables de la salida. Indicar si para alguna configuracion el circuito no es estable.

El circuito incluye un FF-JK con entradas SET y CLR asincrono, y una compuerta AND entre J y K y la senal A; la salida $Q$ retroalimenta a traves de NOT hacia la otra entrada.

(Referencia: Ej 41, Capitulo 3 de Null & Lobur — Essentials Of Computer Organization And Architecture)

| A | B | X | A' | B' |
|---|---|---|----|----|
| 0 | 0 | 0 | ? | ? |
| 0 | 0 | 1 | ? | ? |
| 0 | 1 | 0 | ? | ? |
| 0 | 1 | 1 | ? | ? |
| 1 | 0 | 0 | ? | ? |
| 1 | 0 | 1 | ? | ? |
| 1 | 1 | 0 | ? | ? |
| 1 | 1 | 1 | ? | ? |

**Explicacion**

Ejercicio de analisis de circuito secuencial: dado el estado actual y la entrada, determinar el estado siguiente usando las tablas de verdad de los componentes (FF-JK, AND, NOT).

- El FF-JK con SET y CLR: si SET=1 → Q=1 asincrono; si CLR=1 → Q=0 asincrono. En operacion normal: J=1,K=0 → set; J=0,K=1 → reset; J=K=1 → toggle; J=K=0 → sin cambio.
- Inestabilidad: puede ocurrir si las salidas retroalimentadas crean un loop que no converge.

**Resolucion paso a paso**

⚠️ Verificar — el diagrama exacto del circuito no es extraible del texto (referencia: Null & Lobur Ch.3 Ej.41). La resolucion describe el **metodo general** aplicable una vez conocido el circuito.

**Metodo para completar la tabla caracteristica de un circuito secuencial:**

Dado el circuito con FF-JK (con SET/CLR asincronos), AND y NOT:

**Paso 1 — Identificar ecuaciones de proximo estado:**

Para cada FF en el circuito, expresar sus entradas $J$ y $K$ en funcion del estado actual $(A, B)$ y la entrada $X$.

Ejemplo general:
$$J_A = f_1(A, B, X), \quad K_A = f_2(A, B, X)$$
$$J_B = f_3(A, B, X), \quad K_B = f_4(A, B, X)$$

**Paso 2 — Aplicar tabla de transicion del FF-JK:**

$$Q^{T+1} = J \cdot \overline{Q^T} + \overline{K} \cdot Q^T$$

| J | K | $Q^{T+1}$ |
|---|---|-----------|
| 0 | 0 | $Q^T$ (hold) |
| 1 | 0 | 1 (set) |
| 0 | 1 | 0 (reset) |
| 1 | 1 | $\overline{Q^T}$ (toggle) |

SET asincrono (si activo): $Q \to 1$ independientemente de J/K/clk.
CLR asincrono (si activo): $Q \to 0$ independientemente de J/K/clk.

**Paso 3 — Completar la tabla fila por fila:**

Para cada combinacion $(A, B, X)$:
1. Calcular $J_A, K_A, J_B, K_B$ con las ecuaciones derivadas
2. Aplicar transicion JK: calcular $A' = J_A \cdot \overline{A} + \overline{K_A} \cdot A$ y $B' = J_B \cdot \overline{B} + \overline{K_B} \cdot B$
3. Verificar si hay condiciones de inestabilidad (loop combinatorio sin FF)

**Deteccion de inestabilidad:** si las salidas combinatorias del circuito retroalimentan directamente a las entradas sin pasar por un FF (es decir, sin sincronizacion por clock), el circuito puede oscilar para ciertas entradas. Identificar los lazos y verificar si convergen.

**Chuleta**

1. FF-JK: $Q^{T+1} = J\overline{Q} + \overline{K}Q$ — tabla de transicion clave en examenes.
2. SET/CLR asincronos tienen prioridad sobre J/K/clk — verificar primero si estan activos.
3. Para tabla caracteristica: (a) ecuaciones J,K en funcion de estado+entrada → (b) aplicar transicion JK → (c) llenar tabla.
4. Inestabilidad: buscar lazos sin FF que puedan oscilar (similar al Ej 11).
5. Con N FF de estado: $2^N$ filas por cada valor de entrada X.

**¿Aparece en parciales?** ⚪ No — tabla caracteristica de FF-JK no detectada en los parciales analizados

---

### Ejercicio 13 — Tablas caracteristicas de tres circuitos

**Enunciado**

Escribir tablas caracteristicas que especifiquen el comportamiento de cada uno de los siguientes tres circuitos secuenciales:

(a) Circuito con FF-D y compuertas combinatorias en la entrada
(b) Circuito con dos FF-D en cascada con retroalimentacion cruzada
(c) Circuito con FF-JK y logica combinatoria

(Los diagramas de los circuitos no son completamente extraibles del texto; referirse al PDF original: `raw/guias_practicas/2.prac_logica_digital_parte_1.pdf`)

**Explicacion**

Para cada circuito:
1. Identificar los flip-flops y sus entradas ($D$, $J$, $K$ o equivalente)
2. Expresar las entradas de cada FF en funcion del estado actual y entradas externas
3. Aplicar la ecuacion de proximo estado de cada FF ($Q^{t+1} = D$, o tabla JK)
4. Construir la tabla caracteristica con columnas: estado actual, entrada, estado siguiente

Este tipo de analisis es la base para disenar y verificar maquinas de estados finitos.

**Resolucion paso a paso**

⚠️ Verificar — los diagramas de los tres circuitos no son extraibles del texto del PDF. La resolucion describe el **metodo sistematico** aplicable a cualquiera de los tres circuitos una vez que se tiene el diagrama.

**Metodo para construir la tabla caracteristica de cualquier circuito secuencial:**

**Circuito con FF-D (incisos a y b):**

Paso 1 — Para cada FF-D del circuito, derivar la ecuacion de la entrada $D_i$:
$$D_i = f_i(\text{estado actual},\ \text{entradas externas})$$

Paso 2 — La ecuacion de proximo estado es directa:
$$Q_i^{T+1} = D_i$$

Paso 3 — Para cada fila de la tabla (combinacion de estado actual + entradas):
1. Evaluar $D_i$ con las ecuaciones del paso 1
2. El proximo estado es exactamente el vector de $D_i$ calculado

**Circuito con FF-JK (inciso c):**

Igual que el Ej 12: derivar $J_i, K_i$, luego aplicar $Q_i^{T+1} = J_i\overline{Q_i} + \overline{K_i}Q_i$.

**Estructura general de la tabla caracteristica:**

| Estado actual | Entradas | Entradas de FFs | Proximo estado |
|---|---|---|---|
| $Q_1, Q_0$ | $e_0, \ldots$ | $D_1, D_0$ (o $J,K$) | $Q_1', Q_0'$ |

Para cada fila: evaluar la logica combinatoria con los valores de esa fila, obtener las entradas de los FFs, aplicar la ecuacion de transicion del tipo de FF.

**Consideracion especial para circuitos con dos FF en cascada con retroalimentacion (inciso b):**

Si la retroalimentacion cruza de la salida de un FF a la entrada del otro, verificar que el circuito sea estable (la retroalimentacion pasa por FFs → sincronizado por clock → estable por construccion).

**Chuleta**

1. FF-D en circuito secuencial: derivar $D_i = f(\text{estado}, \text{entrada})$; luego $Q_i^{T+1} = D_i$ directamente.
2. FF-JK: derivar $J_i, K_i$; luego $Q_i^{T+1} = J_i\overline{Q_i} + \overline{K_i}Q_i$.
3. Tabla caracteristica: una fila por cada combinacion de (estado actual × entradas externas).
4. Con $n$ FFs y $m$ entradas: $2^{n+m}$ filas en la tabla.
5. Circuito estable si toda retroalimentacion pasa por FF (sincronizada por clock).

**¿Aparece en parciales?** ⚪ No — analisis de circuito secuencial complejo no detectado en los parciales analizados

---

### Ejercicio 14 — Registro simple 4-bit

**Enunciado**

Disenar un registro simple de cuatro bits. Es un circuito de seis entradas ($i_0$ a $i_3$, $load$, $clk$) y cuatro salidas ($o_0$ a $o_3$):

- En el flanco ascendente de $clk$: si $load = 1$, almacena $i_0 \ldots i_3$; si $load = 0$, no cambia el contenido.
- Por las lineas de salida, se emite el valor almacenado.

```
clk ─── [registros]
i3 i2 i1 i0 ── entradas
o3 o2 o1 o0 ── salidas
load ──────────
```

**Explicacion**

El registro simple usa 4 FF-D con un MUX 2→1 en cada entrada:
- $D_i = \text{MUX}(Q_i, i_k; load)$: si $load = 0$ → $D_i = Q_i$ (mantiene); si $load = 1$ → $D_i = i_k$ (carga).

Este es el componente base del que derivan el registro bidireccional (Ej 15), el extensor de signo (Ej 16) y el desplazador (Ej 17).

Ver patron en [[logica_secuencial_teoria]]: registro N-bit con WriteEnable = este mismo circuito.

**Diagrama disponible** (`raw/guias_practicas/2.prac_logica_digital_parte_2.pdf`, p.2): 4 MUX 2→1 (uno por bit) + 4 FF-D, todos conectados al mismo clk y LOAD. Evaluado: i=[1,1,0,0], LOAD=1 → o=[1,1,0,0] en el proximo flanco ascendente (carga directa confirmada).

**Resolucion paso a paso**

**Diseño del registro simple 4-bit:**

El componente central es un FF-D con WriteEnable implementado via MUX 2→1. El MUX selecciona que valor entra al FF: el dato externo (carga) o el valor actual del FF (hold).

**Ecuacion por bit $i \in \{0,1,2,3\}$:**

$$D_i = load \cdot i_i + \overline{load} \cdot Q_i$$
$$Q_i^{T+1} = D_i \quad \text{(en flanco ascendente de } clk\text{)}$$
$$o_i = Q_i \quad \text{(salida directa, siempre)}$$

**Celda de 1 bit:**

```
             load
              │
i_i ──────────┤ [MUX 2→1] ── D_i ──[FF-D]── Q_i = o_i
Q_i (feedback)┘              clk ─────────┘
```

- Entrada 0 del MUX (load=0): $Q_i$ — realimentacion, mantiene el estado
- Entrada 1 del MUX (load=1): $i_i$ — dato externo

**El registro completo replica esta celda 4 veces:**

```
clk ──────────────────────────┬──┬──┬──┐
load ──────────────────────────┤  │  │  │
i3 ── [MUX]──[FF-D]──o3        │  │  │  │
i2 ── [MUX]──[FF-D]──o2        │  │  │  │
i1 ── [MUX]──[FF-D]──o1        │  │  │  │
i0 ── [MUX]──[FF-D]──o0        │  │  │  │
```

Todos los MUX comparten el mismo `load`, todos los FF-D comparten el mismo `clk`.

**Comportamiento:**

| load | Evento | Resultado |
|------|--------|-----------|
| 0 | ↑clk | $Q_i$ mantiene (hold) |
| 1 | ↑clk | $Q_i \leftarrow i_i$ (carga) |
| x | sin flanco | $Q_i$ no cambia |

**Verificacion (confirmada por diagrama del PDF):** con $i=[1,1,0,0]$, $load=1$ en ↑clk → $o=[1,1,0,0]$ ✓

**Compuertas:** 4 MUX 2→1 (implementable como 2 AND + 1 OR + 1 NOT cada uno) + 4 FF-D.

**Chuleta**

1. Registro N-bit: N celdas identicas, cada una = MUX + FF-D, con clk y load compartidos.
2. Ecuacion de entrada del FF: $D_i = load \cdot i_i + \overline{load} \cdot Q_i$ (MUX con selector=load).
3. Hold: MUX selecciona $Q_i$ (retroalimentacion) → FF "no ve" cambio → $Q_i$ se mantiene.
4. Salida siempre activa: $o_i = Q_i$ (sin tristate). Para bidireccional agregar tristate (Ej 15).

**¿Aparece en parciales?** ⚪ No — el registro simple como componente es base pero no fue evaluado directamente en los parciales analizados

---

### Ejercicio 15 — Registro bidireccional 4-bit con tristate

**Enunciado**

Disenar un registro bidireccional de cuatro bits. Entradas: $load$, $read$, $clk$. Senales de entrada y salida compartidas: $d_0$ a $d_3$.

- Si $load = 1$ en el flanco ascendente de $clk$: almacena los valores de $d_0 \ldots d_3$.
- Si $read = 1$: emite el valor almacenado por las mismas lineas $d_0 \ldots d_3$.
- $read$ y $load$ nunca valen 1 simultaneamente.

Ayuda: utilizar componentes de tres estados (tristate).

```
clk ─── [registro-bd]
d3 d2 d1 d0 ── bidireccional (entrada o salida segun load/read)
load ──────────
read ──────────
```

**Explicacion**

El bus bidireccional requiere tristate para evitar conflicto electrico cuando la linea esta en modo entrada. El circuito:
- FF-D con MUX para $load$: igual que registro simple.
- Buffer tristate por salida: habilitado cuando $read = 1$, en Hi-Z cuando $read = 0$.
- Cuando $load = 1$: los bufferes estan en Hi-Z, los valores externos entran directamente a los FF-D.

Este patron es el ejercicio mas frecuente de los parciales historicos rotulados 1P; con el programa vigente entra en tu **parcial unico**. Ver [[logica_secuencial_teoria]] (componentes tristate y bus de registros).

**Resolucion paso a paso**

**Diseño del registro bidireccional 4-bit:**

El registro bidireccional extiende el simple (Ej 14) agregando **buffers tristate** en las salidas para compartir las lineas $d_i$ como bus de entrada/salida.

**Ecuacion por bit $i \in \{0,1,2,3\}$:**

Etapa de almacenamiento (igual que Ej 14):
$$D_i = load \cdot d_i + \overline{load} \cdot Q_i$$
$$Q_i^{T+1} = D_i \quad \text{(en flanco ascendente de } clk\text{)}$$

Etapa de salida (tristate):
$$\text{salida del tristate} = \begin{cases} Q_i & \text{si } read = 1 \\ \text{Hi-Z} & \text{si } read = 0 \end{cases}$$

La salida del tristate se conecta al mismo pin $d_i$ que la entrada — **linea bidireccional**.

**Celda de 1 bit:**

```
d_i ────┬──[MUX 2→1]── D_i ──[FF-D]── Q_i ──[TRISTATE]──┐
        │  load ───┘    clk ─────────┘      read ────────┘
        └─────────────────────────────────────────────────┘
        (bus bidireccional: d_i es entrada cuando load=1, salida cuando read=1)
```

**Modos de operacion:**

| load | read | ↑clk | Comportamiento |
|------|------|------|----------------|
| 1 | 0 | si | $Q_i \leftarrow d_i$ (carga; tristate en Hi-Z, sin conflicto) |
| 0 | 1 | — | $d_i \leftarrow Q_i$ (lectura; MUX retiene $Q_i$) |
| 0 | 0 | si/no | Hold: $Q_i$ mantiene, $d_i$ en Hi-Z |
| 1 | 1 | — | **PROHIBIDO**: conflicto electrico en el bus |

**Por que no hay conflicto en modo carga:**
- Cuando $load=1$: el tristate tiene $read=0$ → salida en Hi-Z → el registro no "empuja" señal al bus. El dato externo en $d_i$ puede entrar libremente al MUX.

**Por que se usa tristate (no OR ni AND):**
- Con tristate: cuando el registro no lee, su salida queda electricamente desconectada → cero voltaje inducido en el bus.
- Sin tristate: si varios registros conectan sus salidas al mismo bus simultaneamente → cortocircuito.

**Compuertas por bit:** MUX 2→1 + FF-D + buffer tristate.
**Compuertas totales:** 4 MUX + 4 FF-D + 4 tristate.

**Chuleta**

1. Registro bidireccional = registro simple (MUX+FF-D) + tristate en la salida.
2. Tristate: enable=read → Q_i al bus; enable=0 → Hi-Z (desconectado).
3. Carga (load=1): tristate en Hi-Z, dato externo entra al MUX → FF-D en ↑clk.
4. Lectura (read=1): tristate activo, Q_i sale al bus; MUX mantiene Q_i (load=0).
5. Restriccion fundamental: NUNCA load=1 y read=1 al mismo tiempo.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/registro_bidireccional_tristate]] | [[parciales_analizados/1P_2C_2024]] Ej4 (registro bidireccional tristate modular), [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej4 (registro desplazamiento bidireccional MUX+FF-D)

---

### Ejercicio 16 — Extensor de signo 2→4 bits

**Enunciado**

Disenar un registro extensor de signo de dos a cuatro bits. Funciona como registro simple (Ej 14): toma el valor de sus cuatro entradas $i_0$ a $i_3$ en el flanco ascendente si $load = 1$.

Por sus lineas de salida ($o_0$ a $o_3$):
- Si $ext = 0$: emite el valor almacenado directamente.
- Si $ext = 1$: emite una representacion de cuatro bits del numero almacenado en los dos bits **menos significativos** del registro, interpretados como entero en complemento a 2.

```
clk ─── [extensor]
i3 i2 i1 i0 ── entradas (se carga completo)
o3 o2 o1 o0 ── salidas
load ──────────
ext  ──────────
```

**Explicacion**

La extension de signo de 2 a 4 bits en C2 funciona replicando el bit de signo:
- El numero almacenado de 2 bits es $b_1 b_0$ (con $b_1$ = bit de signo).
- La representacion de 4 bits: $o_3 = o_2 = b_1$, $o_1 = b_1$, $o_0 = b_0$.

Circuito:
- $o_0 = Q_0$ siempre.
- $o_1 = Q_1$ siempre.
- $o_2 = \text{MUX}(Q_2, Q_1; ext)$: si $ext = 0$ → usa $Q_2$ almacenado; si $ext = 1$ → replica $Q_1$ (bit de signo de los 2 bits bajos).
- $o_3 = \text{MUX}(Q_3, Q_1; ext)$: analogo.

Conecta con el concepto de ImmSrc y SignExtn en microarquitectura RISC-V. Ver [[temas/representacion_de_informacion_guia]] Ej12 (demostracion de SignExtn).

**Resolucion paso a paso**

**Diseño del extensor de signo 2→4 bits:**

El circuito es un registro simple (Ej 14) con logica adicional en las **salidas** controlada por la señal $ext$.

**Etapa de almacenamiento:** identica al Ej 14 — carga los 4 bits $i_0 \ldots i_3$ cuando $load=1$ en ↑clk.

**Etapa de salida — logica de extension:**

Cuando $ext=0$: salida directa ($o_i = Q_i$).
Cuando $ext=1$: interpreta los 2 bits bajos $Q_1 Q_0$ como entero en C2 de 2 bits y los extiende a 4 bits. El bit de signo es $Q_1$ (el MSB de los 2 bits bajos), que se replica en las posiciones 2 y 3:

$$o_0 = Q_0 \quad \text{(sin MUX — igual siempre)}$$
$$o_1 = Q_1 \quad \text{(sin MUX — igual siempre)}$$
$$o_2 = \text{MUX}(Q_2,\ Q_1;\ ext) = \overline{ext} \cdot Q_2 + ext \cdot Q_1$$
$$o_3 = \text{MUX}(Q_3,\ Q_1;\ ext) = \overline{ext} \cdot Q_3 + ext \cdot Q_1$$

**Verificacion para todos los valores de 2 bits (ext=1):**

| $Q_1 Q_0$ | Valor C2-2bits | $o_3 o_2 o_1 o_0$ | Valor C2-4bits |
|---|---|---|---|
| 0 0 | 0 | 0 0 0 0 | 0 ✓ |
| 0 1 | +1 | 0 0 0 1 | +1 ✓ |
| 1 0 | -2 | 1 1 1 0 | -2 ✓ |
| 1 1 | -1 | 1 1 1 1 | -1 ✓ |

**Circuito:**

```
         clk, load
          │    │
i0 ──[MUX]──[FF-D]── Q0 ─────────────────────────── o0
i1 ──[MUX]──[FF-D]── Q1 ─────────────────────┬───── o1
i2 ──[MUX]──[FF-D]── Q2 ──[MUX(Q2,Q1;ext)]── │───── o2
i3 ──[MUX]──[FF-D]── Q3 ──[MUX(Q3,Q1;ext)]── │───── o3
                           ext ──────────────┘
```

**Compuertas:** 4 FF-D + 4 MUX (load) + 2 MUX (ext, para $o_2$ y $o_3$) + 1 NOT (para $\overline{ext}$, compartido).

**Conexion con microarquitectura:** este circuito implementa el bloque `SignExtend` del datapath RISC-V — las instrucciones tipo I/S/B tienen inmediatos de 12 bits que se extienden a 32 bits usando el bit 11 como signo.

**Chuleta**

1. Extension de signo de $k$ a $n$ bits (C2): replicar el bit de signo (MSB del numero original) en las posiciones $k$ a $n-1$.
2. Para 2→4: $o_3 = o_2 = Q_1$ (bit de signo), $o_1 = Q_1$, $o_0 = Q_0$.
3. Implementacion: MUX en las salidas de los bits "nuevos" — selecciona entre $Q_i$ almacenado (ext=0) y $Q_{signo}$ (ext=1).
4. Los bits originales ($Q_0, Q_1$) se emiten siempre directamente, sin MUX extra.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/microarquitectura_ciclo_simple]] (ImmSrc tipo B usa extensor de signo) | extension de signo es mecanismo clave del material historico de 2P — hoy parte de tu **parcial unico**, relacionado con SignExtn en guia de representacion (Ej 12 marcado 🔴 Si)

---

### Ejercicio 17 — Desplazador a izquierda 4-bit

**Enunciado**

Disenar un registro desplazador a izquierda de cuatro bits. Funciona como registro simple (Ej 14): toma el valor de sus cuatro entradas $i_0$ a $i_3$ en el flanco ascendente si $load = 1$.

Por sus lineas de salida ($o_0$ a $o_3$):
- Si $shl = 0$: emite el valor almacenado directamente.
- Si $shl = 1$: emite ese valor desplazado en uno hacia la izquierda ($o_0 = 0$, $o_k = Q_{k-1}$ para $k > 0$).

```
clk ─── [desplazador]
i3 i2 i1 i0 ── entradas
o3 o2 o1 o0 ── salidas
load ──────────
shl  ──────────
```

**Explicacion**

El desplazamiento a izquierda (shift left 1) multiplica por 2 en notacion binaria. El circuito:
- $o_0 = \text{MUX}(Q_0, 0; shl)$: si $shl = 0$ → $Q_0$; si $shl = 1$ → 0.
- $o_k = \text{MUX}(Q_k, Q_{k-1}; shl)$ para $k = 1, 2, 3$.

Generalizar: un shift-left de k bits = slli rd, rs, k en RISC-V (ver [[temas/arquitectura_teoria_pt1]]). Patron de acceso a arreglos: $\text{dir} = \text{base} + i \cdot 4 = \text{base} + \text{slli}(i, 2)$.

**Resolucion paso a paso**

**Diseño del desplazador a izquierda 4-bit:**

El circuito tiene dos capas de control independientes: $load$ gestiona el almacenamiento y $shl$ gestiona la salida.

**Etapa de almacenamiento:** identica al Ej 14 — carga los 4 bits $i_0 \ldots i_3$ cuando $load=1$ en ↑clk.

**Etapa de salida — logica de desplazamiento:**

$$o_0 = \text{MUX}(Q_0,\ 0;\ shl) = \overline{shl} \cdot Q_0$$
$$o_k = \text{MUX}(Q_k,\ Q_{k-1};\ shl) = \overline{shl} \cdot Q_k + shl \cdot Q_{k-1} \quad \text{para } k \in \{1,2,3\}$$

Cuando $shl=0$: $o_k = Q_k$ (passthrough directo).
Cuando $shl=1$: $o_0 = 0$, $o_1 = Q_0$, $o_2 = Q_1$, $o_3 = Q_2$ (cada bit sube una posicion).

**Por que es "desplazamiento a izquierda" (shift left 1):**

En notacion binaria, desplazar a la izquierda equivale a multiplicar por 2. El bit MSB ($Q_3$) se descarta (si hay overflow, se pierde):

| $Q_3 Q_2 Q_1 Q_0$ | valor | $o_3 o_2 o_1 o_0$ (shl=1) | valor |
|---|---|---|---|
| 0 1 0 1 | 5 | 1 0 1 0 | 10 ✓ |
| 0 0 1 1 | 3 | 0 1 1 0 | 6 ✓ |
| 1 0 0 0 | -8 (C2) | 0 0 0 0 | 0 (overflow) |
| 0 0 0 1 | 1 | 0 0 1 0 | 2 ✓ |

**Circuito:**

```
         clk, load
          │    │
i0 ──[MUX]──[FF-D]── Q0 ──[MUX(Q0, 0; shl)]─── o0
i1 ──[MUX]──[FF-D]── Q1 ──[MUX(Q1,Q0; shl)]─── o1
i2 ──[MUX]──[FF-D]── Q2 ──[MUX(Q2,Q1; shl)]─── o2
i3 ──[MUX]──[FF-D]── Q3 ──[MUX(Q3,Q2; shl)]─── o3
                           shl (a todos los MUX de salida)
```

**Compuertas:** 4 FF-D + 4 MUX (load) + 4 MUX (shl, en salidas) + 1 NOT (para $\overline{shl}$, compartido).

**Conexion con RISC-V:** `slli rd, rs, 1` en RISC-V realiza exactamente esta operacion (shift left logical immediate). Para acceso a arreglos de enteros (4 bytes): `slli t0, i, 2` = multiplicar indice por 4.

**Chuleta**

1. Desplazador izquierda: MUX en salidas — si shl=0: $o_k=Q_k$; si shl=1: $o_0=0$, $o_k=Q_{k-1}$.
2. Shift left = multiplicar por 2 en binario (el bit MSB se pierde si hay overflow).
3. Implementacion: 4 FF-D (almacenamiento, controlado por load) + 4 MUX en salidas (controlado por shl).
4. El desplazamiento NO modifica el valor almacenado en los FF — solo cambia lo que se emite por las salidas.
5. Generalizacion: shift left k = `slli rd, rs, k` en RISC-V.

**¿Aparece en parciales?** 🔴 Si → [[tipos_ejercicio/registro_desplazamiento_mux]] | [[tipos_ejercicio/tabla_estados_flip_flop]] | [[parciales_analizados/1P_1C_2025]] Ej3; registro desplazamiento bidireccional en [[parciales_analizados/1P_2C_2024_recuperatorio]] Ej4

---

### Ejercicio 18 — Registro auto-incrementador bidireccional

**Enunciado**

Disenar un registro bidireccional auto-incrementador de cuatro bits. Funciona igual que el registro bidireccional (Ej 15), pero con una linea de entrada extra $inc$.

- Si $inc = 1$ en el flanco ascendente de $clk$: el valor almacenado se incrementa en uno.
- Solo una de las tres lineas de control ($load$, $read$, $inc$) puede valer 1 cuando $clk$ alcanza su flanco ascendente.

```
clk ─── [auto-inc]
d3 d2 d1 d0 ── bidireccional
load ──────────
read ──────────
inc  ──────────
```

**Explicacion**

El circuito combina el registro bidireccional (Ej 15) con un sumador de 1 (incrementador).

- Cuando $inc = 1$: la entrada al FF-D de cada bit es el resultado de un sumador $Q + 1$ (ripple carry de 4 bits, donde el carry inicial = 1 y la entrada B = 0).
- Cuando $load = 1$: carga desde las lineas $d_i$.
- Cuando $read = 1$: saca el valor almacenado por tristate.
- Cuando todos = 0: mantiene.

Un MUX 4→1 (o tres MUX 2→1 en cascada) selecciona entre: mantener, cargar, incrementar.

Este componente es la base de un Contador (counter) en logica digital.

**Resolucion paso a paso**

**Diseño del registro auto-incrementador bidireccional 4-bit:**

Combina el registro bidireccional (Ej 15) con un incrementador (sumador ripple carry con $C_{in}=1$, $B=0$).

**Incrementador de 4 bits (Q + 1):**

Ripple carry con $B_i = 0$ para todo $i$ y $C_0 = 1$:

$$S_0 = Q_0 \oplus 1 = \overline{Q_0}, \quad C_1 = Q_0$$
$$S_1 = Q_1 \oplus C_1, \quad C_2 = Q_1 \cdot C_1$$
$$S_2 = Q_2 \oplus C_2, \quad C_3 = Q_2 \cdot C_2$$
$$S_3 = Q_3 \oplus C_3$$

El carry se propaga hasta el primer bit que era 0 (es decir, hasta el primer $Q_i = 0$, punto donde $S_i = 1$ y $C_{i+1} = 0$).

Ejemplo: $Q = 0111\ (+7) \Rightarrow S = 1000\ (+8 \text{ sin signo}, \text{o overflow en C2-4bit})$

**Seleccion de entrada para cada FF-D (MUX 3 entradas o 2 MUX 2→1 en cascada):**

$$D_i = \begin{cases} d_i & \text{si } load = 1 \\ S_i & \text{si } inc = 1 \\ Q_i & \text{si } load = inc = 0 \end{cases}$$

Implementacion con MUX en cascada:

$$D_i = \text{MUX}\!\left(\text{MUX}(Q_i,\ d_i;\ load),\ S_i;\ inc\right)$$

O equivalentemente:
$$D_i = \overline{load}\,\overline{inc} \cdot Q_i + load \cdot d_i + inc \cdot S_i$$

(Los tres modos son mutuamente excluyentes por restriccion del enunciado.)

**Etapa de salida (tristate):** identica al Ej 15 — buffer tristate habilitado por $read$.

**Compuertas:**
- Incrementador: 4 XOR + 3 AND (carries $C_1, C_2, C_3$) = 7 compuertas
- Seleccion de entrada: 4 × (2 MUX 2→1 en cascada) = 8 MUX
- Almacenamiento: 4 FF-D
- Salida: 4 tristate
- **Total: 4 FF-D + 8 MUX + 7 compuertas (incrementador) + 4 tristate**

**Modos de operacion:**

| load | read | inc | ↑clk | Comportamiento |
|------|------|-----|------|----------------|
| 1 | 0 | 0 | si | $Q_i \leftarrow d_i$ (carga) |
| 0 | 1 | 0 | — | $d_i \leftarrow Q_i$ (lectura tristate) |
| 0 | 0 | 1 | si | $Q_i \leftarrow Q_i + 1$ (incremento) |
| 0 | 0 | 0 | si | Hold |

**Chuleta**

1. Auto-incrementador = registro bidireccional (Ej 15) + incrementador (ripple carry Cin=1, B=0).
2. Incrementador 4-bit: $S_0=\overline{Q_0}$, $S_k = Q_k \oplus C_k$, $C_{k+1} = Q_k \cdot C_k$.
3. Seleccion de modo con 2 MUX en cascada por bit: primero elige entre hold/load, luego override con inc.
4. La señal $read$ solo controla el tristate (no afecta la logica de entrada de los FF).
5. Invariante: exactamente una de {load, inc} puede ser 1 en el flanco de clock (read es ortogonal).

**¿Aparece en parciales?** ⚪ No — contador/auto-incrementador no detectado en los parciales analizados

---

### Ejercicio 19 — Diagrama de tiempos para R0 := R0 + R1

**Enunciado**

Dado el siguiente circuito con dos registros bidireccionales R0 y R1 (del Ej 15) conectados a una ALU con senales de control $add$, $sub$, $and$, $or$ y salida de $flags$:

```
R0 ─── [bus] ─── [ALU] ─── resultado
R1 ─── [bus] ─┘
              ↑flags
add/sub/and/or (control ALU)
```

Indicar mediante un diagrama de tiempos la secuencia de activaciones y desactivaciones de senales de control necesarias para que el valor almacenado en R0 se sume al valor de R1 y el resultado se almacene en R0.

**Explicacion**

Este ejercicio requiere conocer el protocolo de bus con registros bidireccionales tristate. La operacion R0 := R0 + R1 necesita:

1. **Lectura de R1**: activar $read_{R1}$ para que R1 emita su valor por el bus → ALU recibe operando B.
2. **Lectura de R0**: activar $read_{R0}$ para que R0 emita su valor por el bus → ALU recibe operando A. (Nota: R1 y R0 no pueden estar en $read$ al mismo tiempo si comparten el mismo bus — usar buses separados o secuenciar.)
3. **Operacion ALU**: activar $add$ → la ALU computa R0 + R1.
4. **Escritura en R0**: desactivar $read_{R0}$, activar $load_{R0}$ → en el proximo flanco de $clk$, R0 almacena el resultado.

La clave es que los tristates impiden conflictos de bus: solo un registro puede estar en modo $read$ a la vez.

Ver [[logica_secuencial_teoria]] (patron de copia de registro: EnableOut-src + WriteEnable-dst + flanco de clock).

**Resolucion paso a paso**

**Premisa del circuito:**

R0 y R1 son registros bidireccionales (Ej 15) compartiendo un bus con una ALU. La ALU tiene dos puertos de entrada: el circuito tipico conecta R0 y R1 a puertos separados (A y B de la ALU), o la ALU tiene registros internos de latch para los operandos.

⚠️ Verificar — el diagrama exacto del bus no esta disponible. Se presentan dos variantes segun si hay uno o dos buses.

---

**Variante A — Buses separados (A-bus para R0, B-bus para R1):**

Esta variante permite leer ambos registros simultaneamente.

**Secuencia de señales:**

```
Señal        |  t1            |  t2 (↑CLK)  |  t3
-------------|----------------|-------------|--------
read_R0      |  1 ────────    |             |  0
read_R1      |  1 ────────    |             |  0
add          |  1 ────────    |  1          |  0
load_R0      |                |  1 ─────    |  0
CLK          |      ↑         |      ↑      |  ↑
```

**Paso a paso:**

1. **t1:** activar $read\_R0 = 1$ y $read\_R1 = 1$ → R0 pone su valor en bus-A, R1 en bus-B. La ALU recibe $A = R0$ y $B = R1$ combinatoriamente.
2. **t1 continuo:** activar $add = 1$ → ALU computa $A + B$; resultado disponible en la salida de la ALU.
3. **Antes de ↑CLK:** desactivar $read\_R0 = 0$ (liberar bus-A para que el resultado pueda entrar). Activar $load\_R0 = 1$.
4. **↑CLK:** R0 captura el resultado de la ALU ($Q_{R0} \leftarrow A + B$).
5. **Post-flanco:** desactivar $load\_R0 = 0$, $read\_R1 = 0$, $add = 0$.

---

**Variante B — Bus compartido (un solo bus):**

No es posible tener $read\_R0 = 1$ y $read\_R1 = 1$ al mismo tiempo (cortocircuito). Se necesitan dos ciclos de clock.

**Secuencia de señales:**

```
Señal        | Ciclo 1        | Ciclo 2       | Ciclo 2 post-↑CLK
-------------|----------------|---------------|------------------
read_R1      | 1 ──────       | 0             |
read_R0      |                | 1 ─────       | 0
add          |                | 1 ─────       | 0
load_R0      |                | (pre-flanco)1 | 0
CLK          |       ↑        |        ↑      |
```

1. **Ciclo 1:** $read\_R1 = 1$ → R1 en bus → ALU latchea operando B en registro interno de la ALU. Luego $read\_R1 = 0$.
2. **Ciclo 2:** $read\_R0 = 1$ → R0 en bus → ALU.A = R0. $add = 1$ → ALU computa.
3. **Antes de ↑CLK del ciclo 2:** $read\_R0 = 0$, $load\_R0 = 1$.
4. **↑CLK:** R0 almacena resultado.
5. **Post-flanco:** $load\_R0 = 0$, $add = 0$.

---

**Regla del bus con tristate (de [[logica_secuencial_teoria]]):**

> Solo un registro puede tener $EnableOut = 1$ (o $read = 1$) en cada instante. Violar esta regla provoca cortocircuito en el bus.

**Chuleta**

1. Para R0 := R0 + R1 con buses separados: read_R0=1, read_R1=1, add=1 → esperar resultado → load_R0=1 + ↑CLK.
2. Con bus compartido: 2 ciclos — ciclo 1 latch R1, ciclo 2 leer R0 + compute + store.
3. Orden critico: desactivar read antes de activar load para el mismo registro (evitar que el tristate interfiera con la carga).
4. La ALU opera combinatoriamente — el resultado esta disponible mientras las entradas sean estables; el clock solo captura el resultado en el registro destino.
5. Señales de control se activan en orden: read primero (para estabilizar bus) → add (para estabilizar resultado) → load + ↑CLK (para capturar).

**¿Aparece en parciales?** ⚪ No — diagrama de tiempos para operacion de bus no detectado en los parciales analizados

---

## Ver tambien

- [[logica_secuencial_teoria]] — latches, FF-D, FF-JK, registros con WE, tristate, bus
- [[logica_combinatoria_guia]] — ejercicios combinatorios (Ej 1–10) de la misma guia
- [[temas/representacion_de_informacion_guia]] — Ej 12 (SignExtn demostracion)
- [[parciales_analizados/1P_2C_2024]] — Ej4 (registro bidireccional tristate)
- [[parciales_analizados/1P_2C_2024_recuperatorio]] — Ej4 (registro desplazamiento bidireccional)
- [[parciales_analizados/1P_1C_2025]] — Ej3 (FF-D registro desplazamiento circular)
